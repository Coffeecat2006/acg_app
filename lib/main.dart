import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';
import 'pages/schedule_page.dart';
import 'pages/ranking_page.dart';
import 'pages/favorites_page.dart';
import 'pages/user_page.dart';
import 'pages/settings_page.dart';
import 'pages/detail_page.dart' as detail;
import 'pages/about_page.dart';
import 'pages/tag_management_page.dart';
import 'pages/feedback_page.dart';
import 'pages/intro_page.dart';
import 'pages/streaming_platform_page.dart';
import 'pages/notification_history_page.dart';

import 'database/work_database.dart';
import 'package:drift/drift.dart' as drift;
import 'services/data_install_dialog.dart';
import 'services/data_import.dart';
import 'services/notification_service.dart';
import 'services/notification_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

// 全局導航鍵
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('zh_TW', null);
  
  // 初始化通知服務
  await NotificationService().initialize();
  
  // 初始化通知處理器
  NotificationHandler().initialize(navigatorKey);
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  
  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadLocale();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'system';
    setState(() {
      _themeMode = ThemeMode.values.firstWhere(
            (e) => e.name == themeString,
        orElse: () => ThemeMode.system,
      );
    });
  }
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', _themeMode.name);
  }
  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      _saveTheme();
    });
  }
  ThemeMode get themeMode => _themeMode;
  
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString('locale');
    if (localeString != null) {
      final parts = localeString.split('_');
      setState(() {
        _locale = Locale(parts[0], parts.length > 1 ? parts[1] : null);
      });
    }
  }
  
  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (_locale != null) {
      prefs.setString('locale', _locale!.toString());
    } else {
      prefs.remove('locale');
    }
  }
  
  void changeLocale(Locale? locale) {
    setState(() {
      _locale = locale;
      _saveLocale();
    });
  }
  
  Locale? get locale => _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACG大全',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', ''),
        Locale('en', ''),
        Locale('ja', ''),
      ],
      navigatorKey: navigatorKey,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final WorkDatabase db = WorkDatabase();
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _works = [];
  final List<Widget> _pages = [];
  bool isDark = false;
  // 動態標題，將在build方法中根據語言設定
  List<String> _appBarTitles = [];
  Timer? _notificationTimer;
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationCount = 0;

  @override
  void initState() {
    super.initState();
    _checkDataInstalled();
    _checkAndShowIntroPage();
    _loadWorks();  // 一開始就嘗試從資料庫載入
    _initializeNotifications();
    _updateUnreadNotificationCount();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = MyApp.of(context)?.themeMode;
      setState(() {
        isDark = theme == ThemeMode.dark ||
            (theme == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark);
      });
    });
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    db.close();
    super.dispose();
  }

  Future<void> _initializeNotifications() async {
    // 延遲一段時間後開始檢查通知，避免與初始化衝突
    await Future.delayed(const Duration(seconds: 5));
    
    // 首次檢查通知
    _checkNotifications();
    
    // 設定定期檢查通知（每天檢查一次）
    _scheduleNotificationCheck();
  }

  void _checkNotifications() async {
    try {
      await _notificationService.checkAndSendNotifications();
      _updateUnreadNotificationCount();
    } catch (e) {
      debugPrint('檢查通知失敗: $e');
    }
  }

  Future<void> _updateUnreadNotificationCount() async {
    try {
      final count = await _notificationService.getUnreadNotificationCount();
      setState(() {
        _unreadNotificationCount = count;
      });
    } catch (e) {
      debugPrint('更新未讀通知數量失敗: $e');
    }
  }

  void _scheduleNotificationCheck() async {
    // 獲取用戶設定的通知時間
    final notificationTimeString = await _notificationService.getNotificationTime();
    final timeParts = notificationTimeString.split(':');
    final notificationHour = int.parse(timeParts[0]);
    final notificationMinute = int.parse(timeParts[1]);
    
    // 計算到下一個通知時間的時間間隔
    final now = DateTime.now();
    var nextNotificationTime = DateTime(now.year, now.month, now.day, notificationHour, notificationMinute);
    
    // 如果今天的通知時間已經過了，設定為明天的通知時間
    if (nextNotificationTime.isBefore(now)) {
      nextNotificationTime = DateTime(now.year, now.month, now.day + 1, notificationHour, notificationMinute);
    }
    
    final duration = nextNotificationTime.difference(now);
    
    // 設定定時器每天檢查一次
    _notificationTimer = Timer.periodic(const Duration(days: 1), (_) {
      _checkNotifications();
    });
    
    // 設定到下一個通知時間的第一次檢查
    Timer(duration, () {
      _checkNotifications();
    });
  }

  Future<void> _checkDataInstalled() async {
    final prefs = await SharedPreferences.getInstance();
    bool isInstalled = prefs.getBool('isDataInstalled') ?? false;
    
    // 同時檢查資料庫中是否有實際資料
    bool hasData = false;
    try {
      final worksCount = await db.select(db.works).get();
      hasData = worksCount.isNotEmpty;
    } catch (e) {
      hasData = false;
    }
    
    // 如果SharedPreferences說已安裝但資料庫沒有資料，修正標記
    if (isInstalled && !hasData) {
      await prefs.setBool('isDataInstalled', false);
      isInstalled = false;
    }
    
    if (!isInstalled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => DataInstallDialog(db: db),
        ).then((_) => _loadWorks());  // 安裝完成後再重新載入
      });
    }
  }

  Future<void> _checkAndShowIntroPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasShownIntro = prefs.getBool('hasShownIntro') ?? false;
    if (!hasShownIntro) {
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IntroPage()),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '無法開啟連結：$url';
    }
  }

  /// 獲取作品的最新發布日期
  Future<DateTime?> _getLatestReleaseDate(Map<String, dynamic> work) async {
    DateTime? latestDate;
    
    try {
      // 檢查動畫的最新發布日期
      final animeList = work['anime'] as List?;
      if (animeList != null && animeList.isNotEmpty) {
        for (final animeData in animeList) {
          final animeId = animeData['anime_id'] as String?;
          if (animeId != null) {
            final animeDate = await _getAnimeLatestDate(animeId);
            if (animeDate != null) {
              latestDate = latestDate == null || animeDate.isAfter(latestDate) ? animeDate : latestDate;
            }
          }
        }
      }
      
      // 檢查小說的最新發布日期
      final novelList = work['novel'] as List?;
      if (novelList != null && novelList.isNotEmpty) {
        for (final novelData in novelList) {
          final novelId = novelData['novel_id'] as String?;
          if (novelId != null) {
            final novelDate = await _getNovelLatestDate(novelId);
            if (novelDate != null) {
              latestDate = latestDate == null || novelDate.isAfter(latestDate) ? novelDate : latestDate;
            }
          }
        }
      }
      
      // 檢查漫畫的最新發布日期
      final comicsList = work['comics'] as List?;
      if (comicsList != null && comicsList.isNotEmpty) {
        for (final comicsData in comicsList) {
          final comicsId = comicsData['comics_id'] as String?;
          if (comicsId != null) {
            final comicsDate = await _getComicsLatestDate(comicsId);
            if (comicsDate != null) {
              latestDate = latestDate == null || comicsDate.isAfter(latestDate) ? comicsDate : latestDate;
            }
          }
        }
      }
    } catch (e) {
      debugPrint('獲取作品最新發布日期失敗: $e');
    }
    
    return latestDate;
  }

  /// 獲取動畫的最新發布日期
  Future<DateTime?> _getAnimeLatestDate(String animeId) async {
    try {
      // 查詢動畫的季度信息
      final seasonsQuery = db.select(db.seasons)..where((t) => t.animeId.equals(animeId));
      final seasons = await seasonsQuery.get();
      
      DateTime? latestDate;
      
      for (final season in seasons) {
        // 檢查季度的發布日期
        if (season.releaseDate != null) {
          latestDate = latestDate == null || season.releaseDate!.isAfter(latestDate) ? season.releaseDate : latestDate;
        }
        
        // 檢查這個季度的集數最新播放時間
        final episodesQuery = db.select(db.episodes)
          ..where((t) => t.animeId.equals(animeId) & t.seasonNumber.equals(season.seasonNumber))
          ..orderBy([(t) => drift.OrderingTerm.desc(t.airTime)]);
        
        final episodes = await episodesQuery.get();
        if (episodes.isNotEmpty && episodes.first.airTime != null) {
          final latestEpisodeDate = episodes.first.airTime!;
          latestDate = latestDate == null || latestEpisodeDate.isAfter(latestDate) ? latestEpisodeDate : latestDate;
        }
      }
      
      return latestDate;
    } catch (e) {
      debugPrint('獲取動畫最新日期失敗 ($animeId): $e');
      return null;
    }
  }

  /// 獲取小說的最新發布日期
  Future<DateTime?> _getNovelLatestDate(String novelId) async {
    try {
      final bookQuery = db.select(db.novelBooks)..where((t) => t.novelId.equals(novelId));
      final books = await bookQuery.get();
      
      DateTime? latestDate;
      
      for (final book in books) {
        // 檢查台版和日版的發布日期，取最新的
        if (book.publishDateTw != null) {
          latestDate = latestDate == null || book.publishDateTw!.isAfter(latestDate) ? book.publishDateTw : latestDate;
        }
        if (book.publishDateJp != null) {
          latestDate = latestDate == null || book.publishDateJp!.isAfter(latestDate) ? book.publishDateJp : latestDate;
        }
      }
      
      return latestDate;
    } catch (e) {
      debugPrint('獲取小說最新日期失敗 ($novelId): $e');
      return null;
    }
  }

  /// 獲取漫畫的最新發布日期
  Future<DateTime?> _getComicsLatestDate(String comicsId) async {
    try {
      final bookQuery = db.select(db.comicsBooks)..where((t) => t.comicsId.equals(comicsId));
      final books = await bookQuery.get();
      
      DateTime? latestDate;
      
      for (final book in books) {
        // 檢查台版和日版的發布日期，取最新的
        if (book.releaseDateTw != null) {
          latestDate = latestDate == null || book.releaseDateTw!.isAfter(latestDate) ? book.releaseDateTw : latestDate;
        }
        if (book.releaseDateJp != null) {
          latestDate = latestDate == null || book.releaseDateJp!.isAfter(latestDate) ? book.releaseDateJp : latestDate;
        }
      }
      
      return latestDate;
    } catch (e) {
      debugPrint('獲取漫畫最新日期失敗 ($comicsId): $e');
      return null;
    }
  }

  Future<void> _loadWorks() async {
    // 從資料庫讀取 works table
    final records = await db.select(db.works).get();
    final worksList = <Map<String, dynamic>>[];
    
    for (final w in records) {
      final workData = {
        'id': w.id,
        'title': w.title,
        'title_jp': w.titleJp,
        'tags': json.decode(w.categoryTags ?? '[]'),
        'introduction': w.introduction,
        'news': w.news,
        'anime': json.decode(w.animeList ?? '[]'),
        'novel': json.decode(w.novelList ?? '[]'),
        'comics': json.decode(w.comicsList ?? '[]'),
        'others': json.decode(w.othersList ?? '[]'),
      };
      
      // 計算這個作品的最新發布日期
      final latestDate = await _getLatestReleaseDate(workData);
      workData['latest_release_date'] = latestDate;
      
      worksList.add(workData);
    }
    
    // 按最新發布日期排序（最新的在前）
    worksList.sort((a, b) {
      final dateA = a['latest_release_date'] as DateTime?;
      final dateB = b['latest_release_date'] as DateTime?;
      
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      
      return dateB.compareTo(dateA); // 降序排列，最新的在前
    });

    setState(() {
      _works = worksList;
      _pages
        ..clear()
        ..addAll([
          HomePage(works: _works),
          const SchedulePage(),
          const RankingPage(),
          const FavoritesPage(),
          const UserPage(),
        ]);
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
  Widget _buildDrawer() {
    final localizations = AppLocalizations.of(context)!;
    
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(localizations.appTitle, style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(localizations.home),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: Text(localizations.drawerStreamingPlatforms),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StreamingPlatformPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: Text(localizations.drawerFeedback),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(localizations.drawerShareApp),
              onTap: () async {
                Navigator.pop(context);
                const shareLink = 'https://coffeecat2006.me/acg_app/';
                const shareText = '''
                我剛剛在使用「ACG大全」App，集合最新動畫/漫畫/小說等一手資訊，介面又好用！
                快來一起探索 ACG 世界 👉 $shareLink
                ''';
                await Share.share(shareText, subject: '推薦你一個超好用的 ACG App');
              },
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: Text(localizations.drawerDataUpdate),
              onTap: () => _showDataUpdateDialog(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(localizations.settingsTitle),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(localizations.aboutTitle),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.label_outline),
              title: Text(localizations.drawerTagManagement),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TagManagementPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: Text(localizations.drawerSponsorDevelopment),
              onTap: () {
                Navigator.pop(context);
                _launchUrl('https://buymeacoffee.com/thecoffeecatstudio');
              },
            ),
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDark ? localizations.drawerLightMode : localizations.drawerDarkMode),
              onTap: () {
                Navigator.pop(context);
                MyApp.of(context)?.toggleTheme();
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
            const Spacer(),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.drawerUsername, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(localizations.drawerEmail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    // 更新標題
    _appBarTitles = [
      localizations.homeTitle,
      localizations.scheduleTitle,
      localizations.rankingTitle,
      localizations.favoritesTitle,
      localizations.userTitle,
    ];
    
    if (_pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(_appBarTitles[0])),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(_appBarTitles[_selectedIndex]),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState?.openDrawer()),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationHistoryPage()),
                    );
                    _updateUnreadNotificationCount();
                  },
                ),
                if (_unreadNotificationCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        _unreadNotificationCount > 99 ? '99+' : '$_unreadNotificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearch(context: context, delegate: WorksSearchDelegate(_works)),
            ),
          ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: localizations.home),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: localizations.schedule),
          BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: localizations.ranking),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: localizations.favorites),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: localizations.user),
        ],
      ),
    );
  }

  Future<void> _showDataUpdateDialog(BuildContext context) async {
    Navigator.pop(context); // 先關閉抽屜

    // 顯示確認對話框
    final bool? shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('資料更新'),
        content: const Text('是否要清空資料庫並重新下載資料？\n\n這個操作將會：\n• 清空所有本地資料\n• 重新下載最新資料\n• 重建資料庫\n\n請確保您的網路連線穩定'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('確定'),
          ),
        ],
      ),
    );

    if (shouldUpdate == true) {
      // 顯示進度對話框
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _DataUpdateProgressDialog(db: db),
      ).then((_) {
        // 資料更新完成後重新載入
        _loadWorks();
      });
    }
  }
}

class _DataUpdateProgressDialog extends StatefulWidget {
  final WorkDatabase db;
  const _DataUpdateProgressDialog({required this.db});

  @override
  State<_DataUpdateProgressDialog> createState() => _DataUpdateProgressDialogState();
}

class _DataUpdateProgressDialogState extends State<_DataUpdateProgressDialog> {
  double _progress = 0.0;
  String _statusText = "準備清空資料庫...";
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _startUpdate();
  }

  Future<void> _startUpdate() async {
    setState(() {
      _isUpdating = true;
      _statusText = "清空資料庫...";
    });

    try {
      // 第一步：清空資料庫
      await widget.db.clearAllData();
      
      setState(() {
        _progress = 0.2;
        _statusText = "開始下載資料...";
      });

      // 第二步：重新下載資料
      await importLatestDataDio(widget.db, onProgress: (received, total) {
        if (total != -1) {
          setState(() {
            _progress = 0.2 + (received / total) * 0.8; // 從 20% 到 100%
            _statusText = "下載中: ${((_progress - 0.2) * 100 / 0.8).toStringAsFixed(0)}%";
          });
        }
      });

      // 記錄資料更新時間
      await NotificationService().recordDataUpdate();

      setState(() {
        _progress = 1.0;
        _statusText = "資料更新完成！";
      });

      // 延遲一點時間讓用戶看到完成消息
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _statusText = "更新失敗: $e";
      });
      // 錯誤時等待用戶關閉
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('資料更新中'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _progress),
          const SizedBox(height: 16),
          Text(_statusText),
        ],
      ),
    );
  }
}

class WorksSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> allWorks;
  WorksSearchDelegate(this.allWorks);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }
  @override
  Widget buildResults(BuildContext context) {
    final filtered = allWorks.where((w) {
      final title = (w['title'] ?? '').toString();
      final titleJp = (w['title_jp'] ?? '').toString();
      return title.contains(query) || titleJp.contains(query);
    }).toList();
    if (filtered.isEmpty) {
      return const Center(child: Text('找不到相關作品'));
    }
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return ListTile(
          title: Text(item['title'] ?? ''),
          subtitle: Text(item['title_jp'] ?? ''),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => detail.DetailPage(work: item)),
            );
          },
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allWorks.where((w) {
      final title = (w['title'] ?? '').toString();
      final titleJp = (w['title_jp'] ?? '').toString();
      return title.contains(query) || titleJp.contains(query);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item['title'] ?? ''),
          onTap: () {
            query = item['title'] ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}

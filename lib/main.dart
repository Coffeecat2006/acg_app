import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('zh_TW', null);
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
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'system';
    setState(() {
      _themeMode = _stringToThemeMode(themeString);
    });
  }
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', _themeMode.name);
  }
  void toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    });
    _saveTheme();
  }
  ThemeMode get themeMode => _themeMode;
  ThemeMode _stringToThemeMode(String str) {
    switch (str) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACG大全',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      themeMode: _themeMode,
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
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _works = [];
  final List<Widget> _pages = [];
  bool isDark = false;
  final List<String> _appBarTitles = ['ACG大全', '時間表', '排行榜', '收藏', '使用者'];
  @override
  void initState() {
    super.initState();
    _loadWorks();
    _checkAndShowIntroPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = MyApp.of(context)?.themeMode;
      setState(() {
        isDark = theme == ThemeMode.dark ||
            (theme == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark);
      });
    });
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
  Future<void> _loadWorks() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/text/works/works.json');
      final data = json.decode(jsonString);
      final worksList = (data['works'] as List).map((e) => e as Map<String, dynamic>).toList();
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
    } catch (e) {
      debugPrint("Error loading works.json: $e");
    }
  }
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Text('ACG大全', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('首頁'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('動畫串流平台'),
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
              title: const Text('問題與回報'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享應用'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('資料更新'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('設定'),
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
              title: const Text('關於'),
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
              title: const Text('標籤管理'),
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
              title: const Text('贊助應用開發'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDark ? '切換亮色' : '切換暗色'),
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
                children: const [
                  Text('使用者名稱(開發中)', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('test@test.com'),
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
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch<String>(
                context: context,
                delegate: WorksSearchDelegate(_works),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '時間表'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '排行榜'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '收藏'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '使用者'),
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

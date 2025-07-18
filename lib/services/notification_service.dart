import 'dart:io';
import 'dart:convert'; // Added for json
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' hide Column;
import '../database/work_database.dart';
import '../database/favorites_database.dart';
import 'notification_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  
  // 作品通知設定鍵值
  static const String _animeNotificationKey = 'anime_notification_enabled';
  static const String _novelNotificationKey = 'novel_notification_enabled';
  static const String _comicsNotificationKey = 'comics_notification_enabled';
  
  // 通知設定鍵值
  static const String _notificationVibrationKey = 'notification_vibration_enabled';
  static const String _notificationTimeKey = 'notification_time';
  static const String _dataUpdateNotificationKey = 'data_update_notification_enabled';
  static const String _lastDataUpdateKey = 'last_data_update_date';
  static const String _dataUpdateNotificationShownKey = 'data_update_notification_shown';
  static const String _notificationHistoryKey = 'notification_history';

  Future<void> initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  // 處理通知點擊
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      _handleNotificationPayload(response.payload!);
    }
  }

  // 處理通知payload
  void _handleNotificationPayload(String payload) {
    debugPrint('Notification tapped with payload: $payload');
    NotificationHandler().handleNotificationTap(payload);
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidInfo != null) {
        final granted = await androidInfo.requestNotificationsPermission();
        return granted ?? false;
      }
    } else if (Platform.isIOS) {
      final iosInfo = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      if (iosInfo != null) {
        final granted = await iosInfo.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    }
    return false;
  }

  // 獲取通知設定
  Future<bool> getAnimeNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_animeNotificationKey) ?? false;
  }

  Future<bool> getNovelNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_novelNotificationKey) ?? false;
  }

  Future<bool> getComicsNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_comicsNotificationKey) ?? false;
  }

  // 設定作品通知
  Future<void> setAnimeNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_animeNotificationKey, enabled);
  }

  Future<void> setNovelNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_novelNotificationKey, enabled);
  }

  Future<void> setComicsNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_comicsNotificationKey, enabled);
  }

  // 獲取通知設定
  Future<bool> getNotificationVibrationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationVibrationKey) ?? false;
  }

  Future<String> getNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_notificationTimeKey) ?? '09:00';
  }

  Future<bool> getDataUpdateNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dataUpdateNotificationKey) ?? false;
  }

  // 設定通知設定
  Future<void> setNotificationVibrationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationVibrationKey, enabled);
  }

  Future<void> setNotificationTime(String time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_notificationTimeKey, time);
  }

  Future<void> setDataUpdateNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dataUpdateNotificationKey, enabled);
  }

  // 記錄最後一次資料更新時間
  Future<void> recordDataUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastDataUpdateKey, DateTime.now().toIso8601String());
    await prefs.setBool(_dataUpdateNotificationShownKey, false);
  }

  // 檢查是否需要資料更新通知
  Future<bool> shouldShowDataUpdateNotification() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 如果沒有啟用資料更新通知，直接返回false
    if (!await getDataUpdateNotificationEnabled()) {
      return false;
    }
    
    // 如果已經顯示過通知，不再顯示
    if (prefs.getBool(_dataUpdateNotificationShownKey) ?? false) {
      return false;
    }
    
    // 檢查最後一次更新時間
    final lastUpdateString = prefs.getString(_lastDataUpdateKey);
    if (lastUpdateString == null) {
      return false;
    }
    
    final lastUpdate = DateTime.parse(lastUpdateString);
    final now = DateTime.now();
    final daysDiff = now.difference(lastUpdate).inDays;
    
    // 如果超過7天，需要顯示通知
    if (daysDiff >= 7) {
      await prefs.setBool(_dataUpdateNotificationShownKey, true);
      return true;
    }
    
    return false;
  }

  // 發送通知
  Future<void> showEpisodeNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final vibrationEnabled = await getNotificationVibrationEnabled();
    
    final androidDetails = AndroidNotificationDetails(
      'episode_updates',
      '新集數通知',
      channelDescription: '收藏作品的新集數通知',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: vibrationEnabled,
      vibrationPattern: vibrationEnabled ? Int64List.fromList([0, 250, 250, 250]) : null,
    );
    const iosDetails = DarwinNotificationDetails();
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, notificationDetails, payload: payload);
    
    // 儲存通知到歷史記錄
    await _saveNotificationToHistory(title, body, payload ?? '');
  }

  // 發送資料更新通知
  Future<void> showDataUpdateNotification() async {
    final vibrationEnabled = await getNotificationVibrationEnabled();
    
    final androidDetails = AndroidNotificationDetails(
      'data_update',
      '資料更新通知',
      channelDescription: '提醒用戶更新資料',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: vibrationEnabled,
      vibrationPattern: vibrationEnabled ? Int64List.fromList([0, 250, 250, 250]) : null,
    );
    const iosDetails = DarwinNotificationDetails();
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      99999,
      '資料更新提醒',
      '您已經超過7天沒有更新資料了，建議更新以獲得最新內容',
      notificationDetails,
      payload: 'data_update',
    );
    
    // 儲存通知到歷史記錄
    await _saveNotificationToHistory(
      '資料更新提醒',
      '您已經超過7天沒有更新資料了，建議更新以獲得最新內容',
      'data_update',
    );
  }

  // 檢查並發送通知的邏輯
  Future<void> checkAndSendNotifications() async {
    // 檢查資料更新通知
    if (await shouldShowDataUpdateNotification()) {
      await showDataUpdateNotification();
    }

    final animeEnabled = await getAnimeNotificationEnabled();
    final novelEnabled = await getNovelNotificationEnabled();
    final comicsEnabled = await getComicsNotificationEnabled();

    // 如果都沒有啟用通知，直接返回
    if (!animeEnabled && !novelEnabled && !comicsEnabled) {
      return;
    }

    final workDb = WorkDatabase();
    final favDb = FavoritesDatabaseHelper.instance;

    try {
      // 獲取所有收藏的作品
      final allFavorites = await favDb.getAllFavorites();
      final favoriteAnimes = allFavorites.where((fav) => fav['type'] == 'anime' && fav['is_favorite'] == 1).toList();
      final favoriteNovels = allFavorites.where((fav) => fav['type'] == 'novel' && fav['is_favorite'] == 1).toList();
      final favoriteComics = allFavorites.where((fav) => fav['type'] == 'comics' && fav['is_favorite'] == 1).toList();

      // 檢查各類型的新集數
      if (animeEnabled && favoriteAnimes.isNotEmpty) {
        await _checkAnimeNotifications(workDb, favoriteAnimes);
      }

      if (novelEnabled && favoriteNovels.isNotEmpty) {
        await _checkNovelNotifications(workDb, favoriteNovels);
      }

      if (comicsEnabled && favoriteComics.isNotEmpty) {
        await _checkComicsNotifications(workDb, favoriteComics);
      }
    } catch (e) {
      debugPrint('檢查通知時發生錯誤: $e');
    } finally {
      workDb.close();
    }
  }

  Future<void> _checkAnimeNotifications(WorkDatabase workDb, List<Map<String, dynamic>> favoriteAnimes) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);
    
    // 獲取收藏的動畫ID列表
    final favoriteAnimeIds = favoriteAnimes.map((fav) => fav['id'].toString()).toSet();
    
    // 查詢今天有新集數的動畫
    final todayEpisodes = await (workDb.select(workDb.episodes)
          ..where((t) => t.airTime.isBetweenValues(todayStart, todayEnd)))
        .get();
    
    // 篩選出收藏的動畫
    final favoriteEpisodesToday = todayEpisodes.where((episode) => 
        favoriteAnimeIds.contains(episode.animeId)).toList();
    
    if (favoriteEpisodesToday.isNotEmpty) {
      // 按動畫分組
      final Map<String, List<Episode>> episodesByAnime = {};
      for (var episode in favoriteEpisodesToday) {
        if (!episodesByAnime.containsKey(episode.animeId)) {
          episodesByAnime[episode.animeId] = [];
        }
        episodesByAnime[episode.animeId]!.add(episode);
      }
      
      // 為每個動畫發送通知
      for (var animeId in episodesByAnime.keys) {
        final episodes = episodesByAnime[animeId]!;
        final animeInfo = await (workDb.select(workDb.anime)
              ..where((t) => t.id.equals(animeId)))
            .getSingleOrNull();
        
        if (animeInfo != null) {
          final episodeCount = episodes.length;
          final episodeText = episodeCount == 1 
              ? '第${episodes.first.episodeNumber}集'
              : '$episodeCount集';
          
          await showEpisodeNotification(
            id: animeId.hashCode,
            title: '動畫新集數通知',
            body: '《${animeInfo.title}》今天更新了$episodeText！',
            payload: 'anime:$animeId:${animeInfo.title}',
          );
        }
      }
    }
  }

  Future<void> _checkNovelNotifications(WorkDatabase workDb, List<Map<String, dynamic>> favoriteNovels) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);
    
    // 獲取收藏的小說ID列表
    final favoriteNovelIds = favoriteNovels.map((fav) => fav['id'].toString()).toSet();
    
    // 查詢今天有新書的小說
    final todayBooks = await (workDb.select(workDb.novelBooks)
          ..where((t) => t.publishDateTw.isBetweenValues(todayStart, todayEnd) |
                         t.publishDateJp.isBetweenValues(todayStart, todayEnd)))
        .get();
    
    // 篩選出收藏的小說
    final favoriteBooksToday = todayBooks.where((book) => 
        favoriteNovelIds.contains(book.novelId)).toList();
    
    if (favoriteBooksToday.isNotEmpty) {
      // 按小說分組
      final Map<String, List<NovelBook>> booksByNovel = {};
      for (var book in favoriteBooksToday) {
        if (!booksByNovel.containsKey(book.novelId)) {
          booksByNovel[book.novelId] = [];
        }
        booksByNovel[book.novelId]!.add(book);
      }
      
      // 為每個小說發送通知
      for (var novelId in booksByNovel.keys) {
        final books = booksByNovel[novelId]!;
        final novelInfo = await (workDb.select(workDb.novels)
              ..where((t) => t.id.equals(novelId)))
            .getSingleOrNull();
        
        if (novelInfo != null) {
          final bookCount = books.length;
          final bookText = bookCount == 1 ? '新書' : '$bookCount本新書';
          
          await showEpisodeNotification(
            id: novelId.hashCode + 1000,
            title: '小說新書通知',
            body: '《${novelInfo.title}》今天發行了$bookText！',
            payload: 'novel:$novelId:${novelInfo.title}',
          );
        }
      }
    }
  }

  Future<void> _checkComicsNotifications(WorkDatabase workDb, List<Map<String, dynamic>> favoriteComics) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);
    
    // 獲取收藏的漫畫ID列表
    final favoriteComicsIds = favoriteComics.map((fav) => fav['id'].toString()).toSet();
    
    // 查詢今天有新書的漫畫
    final todayBooks = await (workDb.select(workDb.comicsBooks)
          ..where((t) => t.releaseDateTw.isBetweenValues(todayStart, todayEnd) |
                         t.releaseDateJp.isBetweenValues(todayStart, todayEnd)))
        .get();
    
    // 篩選出收藏的漫畫
    final favoriteBooksToday = todayBooks.where((book) => 
        favoriteComicsIds.contains(book.comicsId)).toList();
    
    if (favoriteBooksToday.isNotEmpty) {
      // 按漫畫分組
      final Map<String, List<ComicsBook>> booksByComics = {};
      for (var book in favoriteBooksToday) {
        if (!booksByComics.containsKey(book.comicsId)) {
          booksByComics[book.comicsId] = [];
        }
        booksByComics[book.comicsId]!.add(book);
      }
      
      // 為每個漫畫發送通知
      for (var comicsId in booksByComics.keys) {
        final books = booksByComics[comicsId]!;
        final comicsInfo = await (workDb.select(workDb.comics)
              ..where((t) => t.id.equals(comicsId)))
            .getSingleOrNull();
        
        if (comicsInfo != null) {
          final bookCount = books.length;
          final bookText = bookCount == 1 ? '新書' : '$bookCount本新書';
          
          await showEpisodeNotification(
            id: comicsId.hashCode + 2000,
            title: '漫畫新書通知',
            body: '《${comicsInfo.title}》今天發行了$bookText！',
            payload: 'comics:$comicsId:${comicsInfo.title}',
          );
        }
      }
    }
  }

  // 通知歷史管理
  Future<void> _saveNotificationToHistory(String title, String body, String payload) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_notificationHistoryKey) ?? '[]';
    final List<dynamic> history = json.decode(historyJson);
    
    final notification = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'body': body,
      'payload': payload,
      'timestamp': DateTime.now().toIso8601String(),
      'read': false,
    };
    
    history.insert(0, notification); // 新通知放在最前面
    
    // 只保留最近100個通知
    if (history.length > 100) {
      history.removeRange(100, history.length);
    }
    
    await prefs.setString(_notificationHistoryKey, json.encode(history));
  }

  Future<List<Map<String, dynamic>>> getNotificationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_notificationHistoryKey) ?? '[]';
    final List<dynamic> history = json.decode(historyJson);
    
    return history.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_notificationHistoryKey) ?? '[]';
    final List<dynamic> history = json.decode(historyJson);
    
    for (var notification in history) {
      if (notification['id'] == notificationId) {
        notification['read'] = true;
        break;
      }
    }
    
    await prefs.setString(_notificationHistoryKey, json.encode(history));
  }

  Future<void> clearNotificationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationHistoryKey);
  }

  Future<int> getUnreadNotificationCount() async {
    final history = await getNotificationHistory();
    return history.where((notification) => notification['read'] == false).length;
  }
} 
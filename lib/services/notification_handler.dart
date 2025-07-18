import 'package:flutter/material.dart';
import '../pages/anime_detail_page.dart';
import '../pages/novel_detail_page.dart';
import '../pages/comics_detail_page.dart';
import '../pages/settings_page.dart';

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._internal();
  factory NotificationHandler() => _instance;
  NotificationHandler._internal();

  GlobalKey<NavigatorState>? _navigatorKey;

  void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  void handleNotificationTap(String payload) {
    if (_navigatorKey?.currentState == null) {
      debugPrint('Navigator not available');
      return;
    }

    final context = _navigatorKey!.currentState!.context;
    
    if (payload == 'data_update') {
      // 跳轉到設定頁面
      _navigateToSettings(context);
    } else if (payload.contains(':')) {
      // 解析作品通知payload
      final parts = payload.split(':');
      if (parts.length >= 3) {
        final type = parts[0];
        final id = parts[1];
        final title = parts[2];
        
        _navigateToWorkDetail(context, type, id, title);
      }
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  void _navigateToWorkDetail(BuildContext context, String type, String id, String title) {
    Widget page;
    
    switch (type) {
      case 'anime':
        page = AnimeDetailPage(work: {"title": title, "anime_id": id});
        break;
      case 'novel':
        page = NovelDetailPage(work: {"title": title, "novel_id": id});
        break;
      case 'comics':
        page = ComicsDetailPage(work: {"title": title, "comics_id": id});
        break;
      default:
        debugPrint('Unknown work type: $type');
        return;
    }
    
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
} 
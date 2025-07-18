import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../services/notification_handler.dart';
import '../l10n/app_localizations.dart';

class NotificationHistoryPage extends StatefulWidget {
  const NotificationHistoryPage({Key? key}) : super(key: key);

  @override
  State<NotificationHistoryPage> createState() => _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  List<Map<String, dynamic>> _notifications = [];
  bool _loading = true;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _loading = true;
    });
    
    try {
      final notifications = await _notificationService.getNotificationHistory();
      setState(() {
        _notifications = notifications;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${localizations.loadFailed}: $e')),
        );
      }
    }
  }

  String _formatTimestamp(String timestamp, AppLocalizations localizations) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inDays > 0) {
        return '${difference.inDays}${localizations.daysAgo}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}${localizations.hoursAgo}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}${localizations.minutesAgo}';
      } else {
        return localizations.justNow;
      }
    } catch (e) {
      return localizations.unknownTime;
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    await _notificationService.markNotificationAsRead(notificationId);
    _loadNotifications();
  }

  void _onNotificationTap(Map<String, dynamic> notification) {
    // 標記為已讀
    _markAsRead(notification['id']);
    
    // 處理通知點擊
    final payload = notification['payload'] as String;
    if (payload.isNotEmpty) {
      NotificationHandler().handleNotificationTap(payload);
    }
  }

  Future<void> _showClearDialog() async {
    final localizations = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.clearAllNotifications),
        content: const Text('確定要清除所有通知歷史嗎？此操作無法復原。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(localizations.confirm),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await _notificationService.clearNotificationHistory();
      _loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.notificationTitle),
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: localizations.clearAllNotifications,
              onPressed: _showClearDialog,
            ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        localizations.noNotifications,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadNotifications,
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      final isRead = notification['read'] == true;
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isRead ? Colors.grey : Colors.blue,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            notification['title'] ?? '無標題',
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              color: isRead ? Colors.grey[600] : null,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['body'] ?? '',
                                style: TextStyle(
                                  color: isRead ? Colors.grey[500] : null,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTimestamp(notification['timestamp'] ?? '', localizations),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          trailing: !isRead
                              ? Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                          onTap: () => _onNotificationTap(notification),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
} 
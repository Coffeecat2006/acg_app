import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import '../services/data_install_dialog.dart';
import '../database/work_database.dart';
import 'terms_of_service_page.dart';
import 'privacy_policy_page.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final WorkDatabase _db = WorkDatabase();
  final NotificationService _notificationService = NotificationService();
  
  // 資料庫相關
  String _databaseSize = '計算中...';
  bool _hasDatabaseData = true;
  
  // 作品通知設定
  bool _animeNotificationEnabled = false;
  bool _novelNotificationEnabled = false;
  bool _comicsNotificationEnabled = false;
  
  // 通知設定
  bool _notificationVibrationEnabled = false;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 9, minute: 0);
  bool _dataUpdateNotificationEnabled = false;
  
  // 語言設定
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _calculateDatabaseSize();
    _checkDatabaseData();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final animeEnabled = await _notificationService.getAnimeNotificationEnabled();
    final novelEnabled = await _notificationService.getNovelNotificationEnabled();
    final comicsEnabled = await _notificationService.getComicsNotificationEnabled();
    
    final vibrationEnabled = await _notificationService.getNotificationVibrationEnabled();
    final notificationTime = await _notificationService.getNotificationTime();
    final dataUpdateEnabled = await _notificationService.getDataUpdateNotificationEnabled();
    
    // 載入語言設定
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString('locale');
    Locale? locale;
    if (localeString != null) {
      final parts = localeString.split('_');
      locale = Locale(parts[0], parts.length > 1 ? parts[1] : null);
    }
    
    setState(() {
      _animeNotificationEnabled = animeEnabled;
      _novelNotificationEnabled = novelEnabled;
      _comicsNotificationEnabled = comicsEnabled;
      
      _notificationVibrationEnabled = vibrationEnabled;
      _notificationTime = TimeOfDay(
        hour: int.parse(notificationTime.split(':')[0]),
        minute: int.parse(notificationTime.split(':')[1]),
      );
      _dataUpdateNotificationEnabled = dataUpdateEnabled;
      _selectedLocale = locale;
    });
  }

  Future<void> _calculateDatabaseSize() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final databaseFile = File(p.join(directory.path, 'work_database.sqlite'));
      
      if (await databaseFile.exists()) {
        final bytes = await databaseFile.length();
        final mb = bytes / (1024 * 1024);
        setState(() {
          _databaseSize = '${mb.toStringAsFixed(2)} MB';
        });
      } else {
        setState(() {
          _databaseSize = '0 MB';
        });
      }
    } catch (e) {
      setState(() {
        _databaseSize = '無法計算';
      });
    }
  }

  Future<void> _checkDatabaseData() async {
    try {
      final worksCount = await _db.select(_db.works).get();
      setState(() {
        _hasDatabaseData = worksCount.isNotEmpty;
      });
    } catch (e) {
      setState(() {
        _hasDatabaseData = false;
      });
    }
  }

  Future<void> _showDeleteDataDialog() async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('刪除資料'),
        content: const Text('確定要刪除所有資料嗎？\n\n刪除後：\n• 所有下載的資料將被清空\n• 應用內將無法顯示任何內容\n• 需要重新下載資料才能正常使用'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('刪除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await _deleteAllData();
    }
  }

  Future<void> _deleteAllData() async {
    try {
      // 顯示刪除進度
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          title: Text('刪除中'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('正在刪除資料...'),
            ],
          ),
        ),
      );

      // 清空資料庫
      await _db.clearAllData();
      
      // 標記資料未安裝
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDataInstalled', false);
      
      // 更新狀態
      setState(() {
        _hasDatabaseData = false;
      });
      
      // 重新計算資料庫大小
      await _calculateDatabaseSize();
      
      // 關閉進度對話框
      Navigator.of(context).pop();
      
      // 顯示成功訊息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('資料已成功刪除')),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('刪除失敗：$e')),
      );
    }
  }

  Future<void> _showDownloadDataDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DataInstallDialog(db: _db),
    ).then((_) async {
      // 下載完成後更新狀態
      _checkDatabaseData();
      _calculateDatabaseSize();
      
      // 記錄資料更新時間
      await _notificationService.recordDataUpdate();
    });
  }

  Future<void> _toggleNotificationSetting(String type, bool value) async {
    if (value) {
      // 請求通知權限
      await _notificationService.initialize();
      final granted = await _notificationService.requestPermissions();
      
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要通知權限才能啟用此功能')),
        );
        return;
      }
    }

    // 儲存設定
    switch (type) {
      case 'anime':
        await _notificationService.setAnimeNotificationEnabled(value);
        setState(() {
          _animeNotificationEnabled = value;
        });
        break;
      case 'novel':
        await _notificationService.setNovelNotificationEnabled(value);
        setState(() {
          _novelNotificationEnabled = value;
        });
        break;
      case 'comics':
        await _notificationService.setComicsNotificationEnabled(value);
        setState(() {
          _comicsNotificationEnabled = value;
        });
        break;
    }
  }

  Future<void> _testNotifications() async {
    try {
      await _notificationService.checkAndSendNotifications();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('通知檢查完成！如果有新集數將會收到通知')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('通知檢查失敗：$e')),
      );
    }
  }

  Future<void> _toggleGeneralNotificationSetting(String type, bool value) async {
    switch (type) {
      case 'vibration':
        await _notificationService.setNotificationVibrationEnabled(value);
        setState(() {
          _notificationVibrationEnabled = value;
        });
        break;
      case 'dataUpdate':
        await _notificationService.setDataUpdateNotificationEnabled(value);
        setState(() {
          _dataUpdateNotificationEnabled = value;
        });
        break;
    }
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );
    
    if (picked != null) {
      final timeString = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      await _notificationService.setNotificationTime(timeString);
      setState(() {
        _notificationTime = picked;
      });
    }
  }

  Widget _buildLanguageSelector(AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Locale?>(
        value: _selectedLocale,
        isExpanded: true,
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        items: [
          DropdownMenuItem<Locale?>(
            value: null,
            child: Row(
              children: [
                const Icon(Icons.settings, size: 20),
                const SizedBox(width: 12),
                Text(localizations.languageSystem),
              ],
            ),
          ),
          DropdownMenuItem<Locale?>(
            value: const Locale('zh', ''),
            child: Row(
              children: [
                const Text('🇹🇼', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Text(localizations.languageChinese),
              ],
            ),
          ),
          DropdownMenuItem<Locale?>(
            value: const Locale('en', ''),
            child: Row(
              children: [
                const Text('🇺🇸', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Text(localizations.languageEnglish),
              ],
            ),
          ),
          DropdownMenuItem<Locale?>(
            value: const Locale('ja', ''),
            child: Row(
              children: [
                const Text('🇯🇵', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Text(localizations.languageJapanese),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _selectedLocale = value;
          });
          MyApp.of(context)?.changeLocale(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 語言設定
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.language, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildLanguageSelector(localizations),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 作品通知
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.workNotificationTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildNotificationSwitch(
                    title: localizations.animeNotificationTitle,
                    description: localizations.animeNotificationDesc,
                    value: _animeNotificationEnabled,
                    onChanged: (value) => _toggleNotificationSetting('anime', value),
                  ),
                  const SizedBox(height: 8),
                  _buildNotificationSwitch(
                    title: localizations.novelNotificationTitle,
                    description: localizations.novelNotificationDesc,
                    value: _novelNotificationEnabled,
                    onChanged: (value) => _toggleNotificationSetting('novel', value),
                  ),
                  const SizedBox(height: 8),
                  _buildNotificationSwitch(
                    title: localizations.comicsNotificationTitle,
                    description: localizations.comicsNotificationDesc,
                    value: _comicsNotificationEnabled,
                    onChanged: (value) => _toggleNotificationSetting('comics', value),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _testNotifications,
                      icon: const Icon(Icons.notifications),
                      label: Text(localizations.checkNotificationNow),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 通知設定
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.generalNotificationTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildNotificationSwitch(
                    title: localizations.vibrationNotificationTitle,
                    description: localizations.vibrationNotificationDesc,
                    value: _notificationVibrationEnabled,
                    onChanged: (value) => _toggleGeneralNotificationSetting('vibration', value),
                  ),
                  const SizedBox(height: 8),
                  _buildNotificationTimeSelector(localizations),
                  const SizedBox(height: 8),
                  _buildNotificationSwitch(
                    title: localizations.dataUpdateNotificationTitle,
                    description: localizations.dataUpdateNotificationDesc,
                    value: _dataUpdateNotificationEnabled,
                    onChanged: (value) => _toggleGeneralNotificationSetting('dataUpdate', value),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 儲存空間管理
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.storageTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(localizations.databaseSize),
                          Text('${localizations.currentUsage}$_databaseSize', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _calculateDatabaseSize,
                        tooltip: localizations.recalculate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _hasDatabaseData
                        ? ElevatedButton.icon(
                            onPressed: _showDeleteDataDialog,
                            icon: const Icon(Icons.delete),
                            label: Text(localizations.deleteData),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: _showDownloadDataDialog,
                            icon: const Icon(Icons.download),
                            label: Text(localizations.downloadData),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 關於
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.aboutTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(localizations.version),
                      const Text('Pre-Alpha v0.2.0', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TermsOfServicePage()),
                      );
                    },
                    child: Text(localizations.viewTermsOfService),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                      );
                    },
                    child: Text(localizations.viewPrivacyPolicy),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildNotificationTimeSelector(AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizations.notificationTimeTitle),
              Text(localizations.notificationTimeDesc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        TextButton(
          onPressed: _selectNotificationTime,
          child: Text(
            '${_notificationTime.hour.toString().padLeft(2, '0')}:${_notificationTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'terms_of_service_page.dart';
import 'privacy_policy_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // 假資料
  String theme = 'system';
  bool saveLocally = true;
  bool autoUpdate = true;
  bool pushNotifications = true;
  int imageQuality = 80;
  String language = 'zh-TW';
  String cacheSize = 'test.test GB';
  String username = 'test';
  String email = 'test@test.com';
  bool privacyMode = false;
  bool showComments = true;
  bool commentNotifications = true;
  bool autoPlayVideos = false;
  bool showSpoilers = false;
  bool sharelist = false;
  bool shareCollections = false;
  bool showOnlineStatus = true;
  bool newEpisodeNotifications = true;
  bool followedSeriesUpdates = true;
  bool newsletterSubscription = true;

  void handleSettingChange(String key, dynamic value) {
    setState(() {
      switch(key) {
        case 'theme':
          theme = value;
          break;
        case 'saveLocally':
          saveLocally = value;
          break;
        case 'autoUpdate':
          autoUpdate = value;
          break;
        case 'pushNotifications':
          pushNotifications = value;
          break;
        case 'imageQuality':
          imageQuality = value;
          break;
        case 'language':
          language = value;
          break;
        case 'cacheSize':
          cacheSize = value;
          break;
        case 'username':
          username = value;
          break;
        case 'email':
          email = value;
          break;
        case 'privacyMode':
          privacyMode = value;
          break;
        case 'showComments':
          showComments = value;
          break;
        case 'commentNotifications':
          commentNotifications = value;
          break;
        case 'autoPlayVideos':
          autoPlayVideos = value;
          break;
        case 'showSpoilers':
          showSpoilers = value;
          break;
        case 'sharelist':
          sharelist = value;
          break;
        case 'shareCollections':
          shareCollections = value;
          break;
        case 'showOnlineStatus':
          showOnlineStatus = value;
          break;
        case 'newEpisodeNotifications':
          newEpisodeNotifications = value;
          break;
        case 'followedSeriesUpdates':
          followedSeriesUpdates = value;
          break;
        case 'newsletterSubscription':
          newsletterSubscription = value;
          break;
      }
    });
  }

  void handleClearCache() {
    setState(() {
      cacheSize = '0 GB';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 用戶資料管理
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('用戶資料', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(labelText: '用戶名稱'),
                    controller: TextEditingController(text: username),
                    onChanged: (value) => handleSettingChange('username', value),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: '電子郵件'),
                    controller: TextEditingController(text: email),
                    onChanged: (value) => handleSettingChange('email', value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('隱私模式 (隱藏收藏)'),
                      Switch(
                        value: privacyMode,
                        onChanged: (val) => handleSettingChange('privacyMode', val),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // 修改個人資料的操作
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('修改個人資料'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 互動設定
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('互動設定', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('顯示留言'),
                          Text('在作品頁面顯示其他用戶的留言', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Switch(
                        value: showComments,
                        onChanged: (val) => handleSettingChange('showComments', val),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('留言通知'),
                          Text('收到留言回覆時通知我', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Switch(
                        value: commentNotifications,
                        onChanged: (val) => handleSettingChange('commentNotifications', val),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('顯示更詳細資訊'),
                          Text('在作品頁面，會有更詳細的資訊顯示', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Switch(
                        value: autoPlayVideos,
                        onChanged: (val) => handleSettingChange('autoPlayVideos', val),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 隱私設定
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('隱私設定', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('分享我的清單'),
                          Text('允許其他用戶查看我的清單', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Switch(
                        value: sharelist,
                        onChanged: (val) => handleSettingChange('sharelist', val),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('分享收藏列表'),
                        ],
                      ),
                      Switch(
                        value: shareCollections,
                        onChanged: (val) => handleSettingChange('shareCollections', val),
                      ),
                    ],
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
                  const Text('通知設定', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('新集數通知'),
                        ],
                      ),
                      Switch(
                        value: newEpisodeNotifications,
                        onChanged: (val) => handleSettingChange('newEpisodeNotifications', val),
                      ),
                    ],
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
                  const Text('儲存空間', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('快取大小'),
                          Text('目前使用：$cacheSize', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: handleClearCache,
                        icon: const Icon(Icons.delete),
                        label: const Text('清除快取'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 帳號與安全
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('帳號與安全', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // 設定雙重驗證
                    },
                    icon: const Icon(Icons.security),
                    label: const Text('設定雙重驗證'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // 查看已登入裝置
                    },
                    icon: const Icon(Icons.devices),
                    label: const Text('查看已登入裝置'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // 登出所有裝置
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('登出所有裝置'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
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
                  const Text('關於', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('版本: '),
                      Text('Pre-Alpha v0.1.2', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TermsOfServicePage()),
                      );
                    },
                    child: const Text('查看服務條款'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                      );
                    },
                    child: const Text('查看隱私政策'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

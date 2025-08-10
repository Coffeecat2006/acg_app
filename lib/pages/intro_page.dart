import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'terms_of_service_page.dart';
import 'privacy_policy_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  Future<void> _acceptIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasShownIntro', true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(
        title: "ACG大全 App - Alpha v0.2.0",
        content: "發布時間：2025 年 7 月 29 日 20:00（UTC+8）\n版本代號：Phoenix\n狀態：Alpha 測試版\n類型：APK（Android專用）",
      ),
      _buildPage(
          title: "版本更新內容",
          content: "🎨 界面重新設計：\n1. 用戶頁面全面重新設計（Material Design 3 風格）\n2. 新增編輯個人資料功能（頭像上傳、用戶名、郵箱、個人簡介）\n3. 統計數據更新（已標籤作品、最近查看等）\n4. 移除頂部標題欄，界面更簡潔\n\n🌍 多語言支援：\n5. 完整支援中文、英文、日文\n6. 包含用戶頁面、設定頁面、關於頁面、時間表頁面\n\n📱 功能增強：\n7. 首頁智能排序（按最新發布日期）\n8. 通知歷史頁面和完整通知設定\n9. 語言選擇改為下拉式選單\n10. 幫助中心導航到問題回報頁面"
      ),
      _buildPage(
        title: "目前功能與狀態",
        content: "✅ 完整功能：\n• 主頁智能排序（最新作品優先）\n• 用戶個人資料管理（頭像、資訊、偏好）\n• 完整的多語言支援（中/英/日）\n• 通知系統（歷史記錄、設定、推送）\n• 收藏與標籤管理\n• 設定頁面（語言、通知、儲存空間）\n\n🚧 進行中：\n• 排行榜功能開發中\n• 搜尋功能優化中\n• 圖片顯示系統改進中",
      ),
      _buildPage(
        title: "注意事項",
        content: "⚠️ 測試版限制：\n• 部分圖片可能無法正常顯示\n• 資料為測試用途，可能不完整\n• 部分功能仍在開發中\n• 建議定期備份收藏資料\n\n📱 系統需求：\n• Android 7.0 以上\n• 至少 2GB RAM\n• 100MB 可用儲存空間",
      ),
      _buildFinalPage(),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ACG大全 App - 介紹'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) => _buildDot(index)),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildFinalPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("回饋與參與",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text("歡迎至 Discord 社群提交回饋，協助完善 App！",
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsOfServicePage()));
                },
                child: const Text('服務條款'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()));
                },
                child: const Text('隱私條款'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _acceptIntro,
              child: const Text('我了解了，並同意'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

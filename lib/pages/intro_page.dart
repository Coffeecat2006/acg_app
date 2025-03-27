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
        title: "ACG大全 App - Pre-Alpha v0.1.1",
        content: "發布時間：2025 年 3 月 27 日 23:30（UTC+8）\n版本代號：Stellar\n狀態：Pre-Alpha 測試版\n類型：APK（Android專用）",
      ),
      _buildPage(
        title: "版本更新內容",
        content: "1. 時間表優化，新增快速跳轉至其他月份功能\n2. 修復時間表月份資料點擊後下方介面顯示異常\n3. 在開啟動畫顯示情況下，可正常察看當日動畫\n4. 動畫詳細介面顯示方式調整，新增下方介面顯示後再跳轉\n5. 修復版本號顯示錯誤問題\n6. 主頁標題現在會自動依分頁變動\n7. 修復部分資料讀取異常 Bug\n8. 修復首次開啟 App 可跳過同意按鈕 Bug\n9. Git 新增上傳時自動 Build APK 功能",
      ),
      _buildPage(
        title: "目前功能與狀態",
        content: "• 主頁、搜尋功能已建構（資料為測試用）\n• 時間表與標籤功能初步可用\n• 側欄部分按鍵未實裝\n• 排行與用戶功能未開放\n• 設定頁為展示用",
      ),
      _buildPage(
        title: "注意事項",
        content: "• 資料不穩定，可能閃退\n• 圖片不會正常顯示\n• 回報功能無效\n• 資料為AI生成，僅供測試",
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('關於 ACG大全')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildIntro(),
          const SizedBox(height: 24),
          _buildFunctionSpec(),
          const SizedBox(height: 24),
          _buildFunctionTutorial(),
          const SizedBox(height: 24),
          _buildFuturePlan(),
          const SizedBox(height: 24),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('ACG大全 - Pre-Alpha v0.1.2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('開發者資訊: coffeecatstudio'),
        Text('開發人員: coffeecat'),
      ],
    );
  }

  Widget _buildIntro() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ACG大全 App 簡介',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
          'ACG大全是一款專為 ACG 愛好者打造的資訊查詢 App，匯集動畫、漫畫、輕小說等多元資訊，'
              '讓用戶能快速獲取最新作品資料、觀看平台與購買連結。\n\n'
              '本 App 免費、無廣告、無商業用途，僅供查詢使用。',
        ),
      ],
    );
  }

  Widget _buildFunctionSpec() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('App 顯示資料',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _infoBlock('動畫資訊', [
          '名稱、日文名、原作',
          '製作公司、代理商',
          '季數、集數與每集播出時間',
          '製作人員、聲優角色對應',
          'OP / ED 歌名與連結',
          '觀看平台、官方網站、簡介與封面圖',
        ]),
        const SizedBox(height: 12),
        _infoBlock('輕小說與漫畫', [
          '書名、作者、插畫',
          '台版與日版出版日',
          '出版社資訊、動畫化狀況',
          '實體與電子書購買連結',
          '官方網站、社群、封面圖與簡介',
        ]),
      ],
    );
  }

  Widget _infoBlock(String title, List<String> lines) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...lines.map((e) =>
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 14)),
                    Expanded(child: Text(e)),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionTutorial() {
    final tutorials = [
      {
        'icon': Icons.home,
        'title': '首頁',
        'content': '首頁顯示所有動畫、漫畫與小說作品。可使用上方搜尋列快速搜尋作品，支援中日文標題關鍵字。點擊作品可查看詳細資料頁。'
      },
      {
        'icon': Icons.calendar_today,
        'title': '時間表',
        'content':
        '可切換「本季動畫」與「本月書籍」兩種檢視方式：\n\n'
            '- 本季動畫：以週為單位呈現每日播出集數，點擊日期可切換。\n'
            '- 本月書籍：以月曆顯示出版資訊，依顏色標示台版/日版小說與漫畫。\n\n'
            '點擊作品可進入詳細頁面。'
      },
      {
        'icon': Icons.bar_chart,
        'title': '排行榜',
        'content': '功能建置中，預計未來提供依觀看次數、收藏數等統計排行的熱門作品清單。'
      },
      {
        'icon': Icons.favorite,
        'title': '我的收藏',
        'content':
        '將喜歡的動畫/漫畫/小說加入收藏，會顯示於此頁。可依「類型」與「標籤」進行分類與篩選。'
      },
      {
        'icon': Icons.label,
        'title': '標籤管理',
        'content':
        '你可以新增自訂標籤（如 ⭐ 待看、✔ 已看完），並在收藏作品時加入。\n\n標籤支援刪除、篩選使用，資料會儲存在本地資料庫中。'
      },
      {
        'icon': Icons.person,
        'title': '使用者',
        'content':
        '顯示目前使用者暱稱與帳號（開發中）。下方可查看歷史紀錄、收藏統計，並支援編輯名稱與 Email。'
      },
      {
        'icon': Icons.settings,
        'title': '設定',
        'content':
        '包含以下選項：\n\n'
            '- 主題模式切換（亮 / 暗 / 系統）\n'
            '- 語言選擇\n'
            '- 快取清除與圖片品質設定\n'
            '- 隱私模式（是否公開收藏、留言）\n'
            '- 通知偏好（新集數、留言回覆等）\n\n'
            '設定將自動儲存並在下次啟動保留。'
      },
      {
        'icon': Icons.bug_report,
        'title': '問題與回報',
        'content':
        '你可以提供使用上的錯誤回報、改善建議與功能需求。\n\n支援附加圖片、音訊、影片等檔案（大小限制為 10MB）。'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('功能教學與使用說明',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...tutorials.map((item) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ExpansionTile(
              leading: Icon(item['icon'] as IconData),
              title: Text(item['title'] as String),
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(item['content'] as String,
                      style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFuturePlan() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('未來規劃',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
            'App 將持續更新與優化，未來會加入更多功能、排行系統、'
                '使用者社群互動與作品通知服務等，打造更完整的查詢體驗。'
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('官方連結與社群',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('官網：'),
        InkWell(
          onTap: () => _launchUrl('https://coffeecat2006.me/acg_app'),
          child: const Text(
            'https://coffeecat2006.me/acg_app',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Discord：'),
        InkWell(
          onTap: () => _launchUrl('https://discord.gg/QrXeUzU99H'),
          child: const Text(
            'https://discord.gg/QrXeUzU99H',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Buy me a coffee：'),
        InkWell(
          onTap: () => _launchUrl('https://buymeacoffee.com/thecoffeecatstudio'),
          child: const Text(
            'https://buymeacoffee.com/thecoffeecatstudio',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 24),
        const Center(
            child: Text('感謝您的支持，讓我們一起打造更完善的 ACG大全 App！')),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '無法開啟連結：$url';
    }
  }
}
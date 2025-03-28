import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '動畫串流平台',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamingPlatformPage(),
    );
  }
}

class StreamingPlatformPage extends StatelessWidget {
  final List<Map<String, String>> platforms = [
    {
      'name': '巴哈姆特動畫瘋',
      'website': 'https://ani.gamer.com.tw',
      'plan': '99元 / 月',
      'intro': '提供豐富動畫內容，免費版可觀看但含廣告；亦有付費方案提供無廣告體驗。'
    },
    {
      'name': '愛奇藝',
      'website': 'https://www.iq.com',
      'plan': '240元 / 月',
      'intro': '知名大陸串流平台，提供動畫及多樣影視內容。'
    },
    {
      'name': 'Amazon Prime Video',
      'website': 'https://www.primevideo.com',
      'plan': '169元 / 月',
      'intro': '國際知名平台，除動畫外亦有豐富影視節目。'
    },
    {
      'name': 'AniPass',
      'website': 'https://garageplay.tw',
      'plan': '399元 / 年',
      'intro': '專注動畫內容，提供獨家動畫及相關活動。'
    },
    {
      'name': 'bilibili',
      'website': 'https://www.bilibili.com',
      'plan': '25人民幣 / 月',
      'intro': '深受年輕人喜愛，主打動畫、遊戲及二次元文化。'
    },
    {
      'name': 'CATCHPLAY+',
      'website': 'https://catchplay.com',
      'plan': '250元 / 月',
      'intro': '提供高品質電影與動畫內容，娛樂體驗出眾。'
    },
    {
      'name': 'Crunchyroll',
      'website': 'https://www.crunchyroll.com',
      'plan': '60元 / 月',
      'intro': '以日本動畫為主，提供多語言字幕，是動畫迷首選平台。'
    },
    {
      'name': 'Disney+',
      'website': 'https://www.disneyplus.com',
      'plan': '270元 / 月',
      'intro': '全球串流平台，集合迪士尼及其他品牌，包含部分動畫內容。'
    },
    {
      'name': 'friDay影音',
      'website': 'https://video.friday.tw',
      'plan': '199元 / 30天',
      'intro': '多元影音平台，涵蓋電影、劇集及動畫。'
    },
    {
      'name': 'Hami Video',
      'website': 'https://hamivideo.hinet.net',
      'plan': '199元 / 月',
      'intro': '由中華電信提供，串流多類影音內容，動畫亦是其中重點。'
    },
    {
      'name': 'KKTV',
      'website': 'https://www.kktv.me',
      'plan': '149元 / 月',
      'intro': '主打亞洲影視內容，包含熱門動畫及劇集。'
    },
    {
      'name': 'LINE TV',
      'website': 'https://www.linetv.tw',
      'plan': '210元 / 月',
      'intro': '以社群互動為特色，提供多元影視與動畫內容。'
    },
    {
      'name': 'LiTV立視線上影視',
      'website': 'https://www.litv.tv',
      'plan': '150元 / 月',
      'intro': '提供豐富台灣本土與國際影視，動畫資源充足。'
    },
    {
      'name': 'MyVideo',
      'website': 'https://www.myvideo.net.tw',
      'plan': '250元 / 月',
      'intro': '多元影音平台，注重本地及國際影視作品，動畫亦在其中。'
    },
    {
      'name': 'Netflix',
      'website': 'https://www.netflix.com',
      'plan': '270元 / 月',
      'intro': '全球知名串流平台，涵蓋動畫、影劇、紀錄片等多元內容。'
    },
    {
      'name': 'YouTube',
      'website': 'https://www.youtube.com',
      'plan': '免費（YouTube Premium NT\$199/月）',
      'intro': '全球最大影片平台，提供免費影片觀看（含廣告），也提供付費無廣告、離線與背景播放等額外功能。'
    },
    {
      'name': 'ofiii 歐飛',
      'website': 'https://www.ofiii.com',
      'plan': '免費',
      'intro': '免費觀看平台，提供大量動畫內容，適合預算有限用戶。'
    },
    {
      'name': '中華電信MOD',
      'website': 'https://mod.cht.com.tw',
      'plan': '免費（隨中華電信寬頻方案提供）',
      'intro': '由中華電信提供，集成直播與隨選視訊內容，提供電影、劇集、新聞及動畫等多元節目，專為中華電信用戶打造。'
    },
  ];

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('動畫串流平台'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: platforms.length,
              itemBuilder: (context, index) {
                final platform = platforms[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          platform['name']!,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => _launchURL(platform['website']!),
                          child: Text(
                            platform['website']!,
                            style: const TextStyle(
                                color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("基本方案: ${platform['plan']}"),
                        const SizedBox(height: 4),
                        Text(platform['intro']!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '本資料僅供參考，內容不一定準確，一切依各串流平台所標示為主。',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


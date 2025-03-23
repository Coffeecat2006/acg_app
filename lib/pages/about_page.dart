import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("關於 ACG大全"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App 簡介
              const Text(
                "App 簡介",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "ACG大全 是一款為動畫、漫畫與輕小說愛好者量身打造的綜合資訊平台，提供作品瀏覽、更新時間表、排行榜、收藏與標籤管理等功能，幫助您輕鬆掌握最新動態與打造個人化的收藏清單。",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // 使用說明分類
              const Text(
                "使用說明",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ExpansionTile(
                title: const Text("首頁"),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "首頁提供所有作品的概覽，您可以瀏覽最新更新的動畫、漫畫與輕小說，並點擊作品卡片查看詳細資訊。",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("時間表"),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "時間表頁面展示各作品的更新或上映時間，支援週與月分頁查詢，讓您隨時掌握最新動態。",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("排行榜"),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "排行榜根據各項指標呈現熱門作品，幫助您發掘目前最受歡迎的動畫、漫畫與輕小說。",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("收藏與標籤管理"),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "收藏功能讓您將喜愛的作品儲存起來，並可透過標籤管理功能將作品分類（例如待觀看、已觀看等），方便日後查詢與管理。",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("用戶設定"),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "用戶頁面提供帳號資訊管理、個人偏好設定及其他功能，確保您享有個性化使用體驗。",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 注意事項
              const Text(
                "注意事項",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "1. 請保持網路連線穩定，以便及時取得最新資料。\n"
                    "2. 收藏作品前，請確認作品資訊正確，避免重複收藏。\n"
                    "3. 如有任何建議或問題，歡迎透過問題與回報功能反饋給我們。",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

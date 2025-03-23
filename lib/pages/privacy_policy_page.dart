import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  Text _sectionTitle(String text) => Text(
    text,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  Text _sectionContent(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, height: 1.5),
  );

  Divider get _divider => const Divider(height: 24, thickness: 1);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('隱私條款'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: '返回首頁',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Container(
        color: isDark ? Colors.black : Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '隱私條款（ACG大全 App）',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 8),
              _sectionContent('開始生效日期：2025 年 3 月 23 日'),
              const SizedBox(height: 16),
              _sectionContent('ACG大全 App 非常重視您的隱私。本隱私條款說明我們在您使用本應用時如何收集、使用及保護您的個人資訊。使用本應用即表示您同意此隱私條款中的內容。'),
              _divider,
              _sectionTitle('1. 我們收集的資訊'),
              _sectionContent('當您使用 ACG大全 App 時，我們可能會收集以下類型的資訊：\n\n- 個人資訊：\n  當您創建帳號時，我們可能會收集您的電子郵件地址、用戶名及您選擇提供的其他資訊。\n\n- 使用數據：\n  我們可能會收集您在應用內的使用行為資訊，例如訪問的頁面、使用的功能以及停留的時間。\n\n- 設備資訊：\n  我們可能會收集您使用的設備資訊，例如設備型號、操作系統版本及應用版本等。'),
              _divider,
              _sectionTitle('2. 我們如何使用您的資訊'),
              _sectionContent('我們收集的資訊將用於改進應用功能及提升使用者體驗。我們可能會將您的資訊用於以下目的：\n- 改善應用功能與性能。\n- 回應您的反饋、問題或 BUG 回報。\n- 發送應用更新通知、公告及重要資訊。\n- 個性化您的應用使用體驗。'),
              _divider,
              _sectionTitle('3. 資訊分享政策'),
              _sectionContent('我們不會將您的個人資訊出售、交易或租賃給第三方。只有在以下情況下，我們才會分享您的資訊：\n- 取得您的同意時：我們在獲得您的明確許可後，才會分享您的資訊。\n- 法律合規：在法律要求或為保護 ACG大全 App 及其用戶的權利、財產或安全時，我們可能會披露您的資訊。'),
              _divider,
              _sectionTitle('4. 資料安全'),
              _sectionContent('我們採取合理的措施來保護您的資訊，防止未經授權的存取、濫用或洩露。不過，請注意，任何網路傳輸或電子儲存方式都無法保證 100% 的安全性。'),
              _divider,
              _sectionTitle('5. 第三方服務'),
              _sectionContent('本應用可能包含第三方網站或服務的連結。我們不對這些第三方服務的隱私政策或內容負責，建議您在使用前查閱其隱私政策。'),
              _divider,
              _sectionTitle('6. 使用者產生內容'),
              _sectionContent('如果您在應用內或相關平台（如 Discord）提交內容（如評論、BUG 回報等），請注意這些內容可能會對其他用戶可見。請避免在使用者產生內容中分享敏感個人資訊。'),
              _divider,
              _sectionTitle('7. 兒童隱私'),
              _sectionContent('本應用不適用於 13 歲以下的兒童。我們不會主動收集 13 歲以下兒童的個人資訊。如果我們發現誤收了 13 歲以下兒童的資訊，將會立即刪除相關資料。'),
              _divider,
              _sectionTitle('8. 隱私條款變更'),
              _sectionContent('我們可能會不定期更新本隱私條款，以反映我們的最新做法或滿足法律需求。如果條款有重大變更，我們將透過應用通知或電子郵件通知您。建議您定期查看本條款，以了解我們如何保護您的資訊。'),
              _divider,
              _sectionTitle('9. 您的權利'),
              _sectionContent('根據您的所在地區，您可能擁有以下與個人資訊相關的權利：\n- 存取、更新或刪除資訊的權利。\n- 反對或限制某些類型數據處理的權利。\n- 在適用情況下，隨時撤回同意的權利。\n\n如需行使這些權利，請使用以下聯繫方式聯絡我們。'),
              _divider,
              _sectionTitle('10. 聯絡方式'),
              _sectionContent('如您對本隱私條款有任何疑問、意見或反饋，請聯繫我們：\n- 電子郵件： thecoffeecatstudio@gmail.com\n- Discord 社群： 點擊加入我們的社群伺服器 (https://discord.gg/QrXeUzU99H)'),
              _divider,
              _sectionContent('感謝您信任 ACG大全 App！我們致力於保護您的隱私，為您提供安全、愉快的使用體驗。'),
            ],
          ),
        ),
      ),
    );
  }
}

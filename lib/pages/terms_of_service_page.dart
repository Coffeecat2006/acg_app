import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({Key? key}) : super(key: key);

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
        title: const Text('服務條款'),
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
                '服務條款（ACG大全 App）',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 8),
              _sectionContent('開始生效日期：2025 年 3 月 23 日'),
              const SizedBox(height: 16),
              _sectionContent(
                  '歡迎使用 ACG大全 App！在您使用本應用程式之前，請仔細閱讀並同意以下服務條款。使用本應用即表示您同意遵守這些條款。如您不同意，請立即停止使用本應用程式。'),
              _divider,
              _sectionTitle('1. 接受條款'),
              _sectionContent('當您使用 ACG大全 App 時，表示您已閱讀、理解並同意這些服務條款。如您不同意，請勿繼續使用本應用。'),
              _divider,
              _sectionTitle('2. 資格條件'),
              _sectionContent('您必須年滿 13 歲方可使用 ACG大全 App。若您未滿 18 歲，需在父母或法定監護人的監督下使用，並取得他們對這些條款的同意。'),
              _divider,
              _sectionTitle('3. 使用者責任'),
              _sectionContent('在使用本應用時，您同意以下事項：\n- 遵守所有適用法律及規範。\n- 不從事有害、濫用或惡意行為，包括但不限於騷擾、散佈垃圾訊息或嘗試駭入應用。\n- 提供準確的資訊，例如註冊帳號時或提交意見反饋時。'),
              const SizedBox(height: 8),
              _sectionContent('您不得進行以下行為：\n- 嘗試破壞應用功能或未經授權訪問其程式碼或數據庫。\n- 張貼攻擊性、不適當或違法內容。'),
              _divider,
              _sectionTitle('4. 帳號建立與安全'),
              _sectionContent('使用某些功能可能需要建立帳號。您需妥善保管帳號憑證，並對所有帳號活動負責。\n\n如您發現帳號可能被未經授權使用，請立即與我們聯繫。'),
              _divider,
              _sectionTitle('5. 內容與智慧財產權'),
              _sectionContent('ACG大全 App 中的所有內容，包括但不限於圖片、文字、圖形與數據，均受智慧財產權法保護。\n未經授權，您不得複製、修改、散佈或以其他方式使用應用內的內容，除非僅用於個人、非商業用途。\n\n使用者產生的內容（如評論、回報）仍歸屬使用者所有，但提交至應用後，您授予 ACG大全 非獨家、免版稅的授權，允許我們在應用內展示、使用與散佈該內容。'),
              _divider,
              _sectionTitle('6. 使用者產生內容政策'),
              _sectionContent('使用者需對其提交至應用的內容（如評論、BUG 回報）負責，ACG大全 有權移除或管理以下類型的內容：\n- 違反法律或第三方權利的內容。\n- 含有攻擊性、不適當或有害語言的內容。\n- 被認為是垃圾訊息、欺詐或不相關的內容。'),
              _divider,
              _sectionTitle('7. 隱私與數據收集'),
              _sectionContent('我們重視您的隱私，請詳閱我們的 隱私政策，了解我們如何收集、儲存與保護您的個人資訊。使用本應用即表示您同意我們根據隱私政策處理您的數據。'),
              _divider,
              _sectionTitle('8. 應用更新與更改'),
              _sectionContent('ACG大全 可能會發布應用更新，以改進功能、修復錯誤或新增功能。您可能需要下載最新版本才能繼續使用本應用。\n\n我們保留在未經事先通知的情況下，修改、暫停或停止應用部分功能的權利。'),
              _divider,
              _sectionTitle('9. 免責聲明'),
              _sectionContent('ACG大全 App 是基於「現狀」提供，無任何明示或暗示的保證。\n我們不保證應用不會出現錯誤、不中斷或無任何有害組件。'),
              _divider,
              _sectionTitle('10. 責任限制'),
              _sectionContent('在法律允許的最大範圍內，ACG大全 及其開發者對於使用本應用所產生的任何間接、附帶、特殊或後果性損害不承擔責任。\n\n這包括但不限於數據遺失、服務中斷或與使用者產生的內容有關的問題。'),
              _divider,
              _sectionTitle('11. 訪問終止'),
              _sectionContent('若我們認為您違反了這些服務條款或相關法律，我們保留隨時終止或暫停您訪問 ACG大全 App 的權利。'),
              _divider,
              _sectionTitle('12. 準據法'),
              _sectionContent('這些服務條款應依照您所在地區的法律解釋與執行。任何與應用有關的法律爭議，應根據當地適用法律解決。'),
              _divider,
              _sectionTitle('13. 服務條款的修改'),
              _sectionContent('我們可能不時更新這些服務條款。如有重大變更，將透過應用通知或電子郵件通知您。繼續使用應用即表示您同意修訂後的條款。'),
              _divider,
              _sectionTitle('14. 聯繫方式'),
              _sectionContent('如您對這些服務條款有任何疑問、意見或反饋，請聯繫我們：\n電子郵件： thecoffeecatstudio@gmail.com\nDiscord 社群： 點擊加入我們的社群伺服器 (https://discord.gg/QrXeUzU99H)'),
              _divider,
              _sectionContent('感謝您使用 ACG大全 App！我們期待與您共同打造更好的 ACG 資訊平台！ 🎉'),
            ],
          ),
        ),
      ),
    );
  }
}

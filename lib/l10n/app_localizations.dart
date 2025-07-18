import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'ACG大全'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In zh, this message translates to:
  /// **'ACG大全'**
  String get homeTitle;

  /// No description provided for @scheduleTitle.
  ///
  /// In zh, this message translates to:
  /// **'時間表'**
  String get scheduleTitle;

  /// No description provided for @rankingTitle.
  ///
  /// In zh, this message translates to:
  /// **'排行榜'**
  String get rankingTitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get favoritesTitle;

  /// No description provided for @userTitle.
  ///
  /// In zh, this message translates to:
  /// **'使用者'**
  String get userTitle;

  /// No description provided for @notificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'通知'**
  String get notificationTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'設定'**
  String get settingsTitle;

  /// No description provided for @aboutTitle.
  ///
  /// In zh, this message translates to:
  /// **'關於'**
  String get aboutTitle;

  /// No description provided for @searchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜尋'**
  String get searchHint;

  /// No description provided for @noData.
  ///
  /// In zh, this message translates to:
  /// **'暫無資料'**
  String get noData;

  /// No description provided for @loading.
  ///
  /// In zh, this message translates to:
  /// **'載入中...'**
  String get loading;

  /// No description provided for @refresh.
  ///
  /// In zh, this message translates to:
  /// **'重新整理'**
  String get refresh;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In zh, this message translates to:
  /// **'確定'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'儲存'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In zh, this message translates to:
  /// **'刪除'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In zh, this message translates to:
  /// **'編輯'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In zh, this message translates to:
  /// **'新增'**
  String get add;

  /// No description provided for @clear.
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get clear;

  /// No description provided for @close.
  ///
  /// In zh, this message translates to:
  /// **'關閉'**
  String get close;

  /// No description provided for @back.
  ///
  /// In zh, this message translates to:
  /// **'返回'**
  String get back;

  /// No description provided for @next.
  ///
  /// In zh, this message translates to:
  /// **'下一步'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In zh, this message translates to:
  /// **'上一步'**
  String get previous;

  /// No description provided for @done.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get done;

  /// No description provided for @error.
  ///
  /// In zh, this message translates to:
  /// **'錯誤'**
  String get error;

  /// No description provided for @success.
  ///
  /// In zh, this message translates to:
  /// **'成功'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In zh, this message translates to:
  /// **'警告'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In zh, this message translates to:
  /// **'資訊'**
  String get info;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'語言'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟隨系統'**
  String get languageSystem;

  /// No description provided for @languageChinese.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @languageEnglish.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @notificationSettings.
  ///
  /// In zh, this message translates to:
  /// **'通知設定'**
  String get notificationSettings;

  /// No description provided for @workNotifications.
  ///
  /// In zh, this message translates to:
  /// **'作品通知'**
  String get workNotifications;

  /// No description provided for @animeNotification.
  ///
  /// In zh, this message translates to:
  /// **'動畫通知'**
  String get animeNotification;

  /// No description provided for @novelNotification.
  ///
  /// In zh, this message translates to:
  /// **'小說通知'**
  String get novelNotification;

  /// No description provided for @comicsNotification.
  ///
  /// In zh, this message translates to:
  /// **'漫畫通知'**
  String get comicsNotification;

  /// No description provided for @notificationVibration.
  ///
  /// In zh, this message translates to:
  /// **'通知震動'**
  String get notificationVibration;

  /// No description provided for @notificationTime.
  ///
  /// In zh, this message translates to:
  /// **'通知時間'**
  String get notificationTime;

  /// No description provided for @dataUpdateNotification.
  ///
  /// In zh, this message translates to:
  /// **'資料更新通知'**
  String get dataUpdateNotification;

  /// No description provided for @storageManagement.
  ///
  /// In zh, this message translates to:
  /// **'儲存管理'**
  String get storageManagement;

  /// No description provided for @databaseSize.
  ///
  /// In zh, this message translates to:
  /// **'資料庫大小'**
  String get databaseSize;

  /// No description provided for @deleteData.
  ///
  /// In zh, this message translates to:
  /// **'刪除資料'**
  String get deleteData;

  /// No description provided for @downloadData.
  ///
  /// In zh, this message translates to:
  /// **'下載資料'**
  String get downloadData;

  /// No description provided for @noNotifications.
  ///
  /// In zh, this message translates to:
  /// **'暫無通知'**
  String get noNotifications;

  /// No description provided for @clearAllNotifications.
  ///
  /// In zh, this message translates to:
  /// **'清除所有通知'**
  String get clearAllNotifications;

  /// No description provided for @markAsRead.
  ///
  /// In zh, this message translates to:
  /// **'標記為已讀'**
  String get markAsRead;

  /// No description provided for @home.
  ///
  /// In zh, this message translates to:
  /// **'首頁'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In zh, this message translates to:
  /// **'時間表'**
  String get schedule;

  /// No description provided for @ranking.
  ///
  /// In zh, this message translates to:
  /// **'排行榜'**
  String get ranking;

  /// No description provided for @favorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get favorites;

  /// No description provided for @user.
  ///
  /// In zh, this message translates to:
  /// **'使用者'**
  String get user;

  /// No description provided for @anime.
  ///
  /// In zh, this message translates to:
  /// **'動畫'**
  String get anime;

  /// No description provided for @novel.
  ///
  /// In zh, this message translates to:
  /// **'小說'**
  String get novel;

  /// No description provided for @comics.
  ///
  /// In zh, this message translates to:
  /// **'漫畫'**
  String get comics;

  /// No description provided for @allWorks.
  ///
  /// In zh, this message translates to:
  /// **'所有作品'**
  String get allWorks;

  /// No description provided for @thisSeasonAnime.
  ///
  /// In zh, this message translates to:
  /// **'本季動畫'**
  String get thisSeasonAnime;

  /// No description provided for @thisMonthBooks.
  ///
  /// In zh, this message translates to:
  /// **'本月書籍'**
  String get thisMonthBooks;

  /// No description provided for @myFavorites.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get myFavorites;

  /// No description provided for @tagManagement.
  ///
  /// In zh, this message translates to:
  /// **'標籤管理'**
  String get tagManagement;

  /// No description provided for @addTag.
  ///
  /// In zh, this message translates to:
  /// **'新增標籤'**
  String get addTag;

  /// No description provided for @deleteTag.
  ///
  /// In zh, this message translates to:
  /// **'刪除標籤'**
  String get deleteTag;

  /// No description provided for @noTags.
  ///
  /// In zh, this message translates to:
  /// **'尚無標籤'**
  String get noTags;

  /// No description provided for @selectTag.
  ///
  /// In zh, this message translates to:
  /// **'選擇標籤'**
  String get selectTag;

  /// No description provided for @newTag.
  ///
  /// In zh, this message translates to:
  /// **'新增標籤'**
  String get newTag;

  /// No description provided for @sortBy.
  ///
  /// In zh, this message translates to:
  /// **'排序：'**
  String get sortBy;

  /// No description provided for @titleAsc.
  ///
  /// In zh, this message translates to:
  /// **'標題升序'**
  String get titleAsc;

  /// No description provided for @titleDesc.
  ///
  /// In zh, this message translates to:
  /// **'標題降序'**
  String get titleDesc;

  /// No description provided for @releaseDateAsc.
  ///
  /// In zh, this message translates to:
  /// **'推出時間升序'**
  String get releaseDateAsc;

  /// No description provided for @releaseDateDesc.
  ///
  /// In zh, this message translates to:
  /// **'推出時間降序'**
  String get releaseDateDesc;

  /// No description provided for @favDateAsc.
  ///
  /// In zh, this message translates to:
  /// **'收藏日期升序'**
  String get favDateAsc;

  /// No description provided for @favDateDesc.
  ///
  /// In zh, this message translates to:
  /// **'收藏日期降序'**
  String get favDateDesc;

  /// No description provided for @filterByTag.
  ///
  /// In zh, this message translates to:
  /// **'標籤：'**
  String get filterByTag;

  /// No description provided for @allTags.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get allTags;

  /// No description provided for @minutesAgo.
  ///
  /// In zh, this message translates to:
  /// **'分鐘前'**
  String get minutesAgo;

  /// No description provided for @hoursAgo.
  ///
  /// In zh, this message translates to:
  /// **'小時前'**
  String get hoursAgo;

  /// No description provided for @daysAgo.
  ///
  /// In zh, this message translates to:
  /// **'天前'**
  String get daysAgo;

  /// No description provided for @justNow.
  ///
  /// In zh, this message translates to:
  /// **'剛剛'**
  String get justNow;

  /// No description provided for @unknownTime.
  ///
  /// In zh, this message translates to:
  /// **'未知時間'**
  String get unknownTime;

  /// No description provided for @loadFailed.
  ///
  /// In zh, this message translates to:
  /// **'載入失敗'**
  String get loadFailed;

  /// No description provided for @dataUpdateReminder.
  ///
  /// In zh, this message translates to:
  /// **'資料更新提醒'**
  String get dataUpdateReminder;

  /// No description provided for @dataUpdateReminderBody.
  ///
  /// In zh, this message translates to:
  /// **'您已經超過7天沒有更新資料了，建議更新以獲得最新內容'**
  String get dataUpdateReminderBody;

  /// No description provided for @newEpisodeNotification.
  ///
  /// In zh, this message translates to:
  /// **'新集數通知'**
  String get newEpisodeNotification;

  /// No description provided for @newBookNotification.
  ///
  /// In zh, this message translates to:
  /// **'新書通知'**
  String get newBookNotification;

  /// No description provided for @watchLater.
  ///
  /// In zh, this message translates to:
  /// **'⭐ 待觀看'**
  String get watchLater;

  /// No description provided for @watched.
  ///
  /// In zh, this message translates to:
  /// **'✔️ 已觀看'**
  String get watched;

  /// No description provided for @popular.
  ///
  /// In zh, this message translates to:
  /// **'🔥 熱門'**
  String get popular;

  /// No description provided for @recommended.
  ///
  /// In zh, this message translates to:
  /// **'💡 推薦'**
  String get recommended;

  /// No description provided for @drawerStreamingPlatforms.
  ///
  /// In zh, this message translates to:
  /// **'動畫串流平台'**
  String get drawerStreamingPlatforms;

  /// No description provided for @drawerFeedback.
  ///
  /// In zh, this message translates to:
  /// **'問題與回報'**
  String get drawerFeedback;

  /// No description provided for @drawerShareApp.
  ///
  /// In zh, this message translates to:
  /// **'分享應用'**
  String get drawerShareApp;

  /// No description provided for @drawerDataUpdate.
  ///
  /// In zh, this message translates to:
  /// **'資料更新'**
  String get drawerDataUpdate;

  /// No description provided for @drawerTagManagement.
  ///
  /// In zh, this message translates to:
  /// **'標籤管理'**
  String get drawerTagManagement;

  /// No description provided for @drawerSponsorDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'贊助應用開發'**
  String get drawerSponsorDevelopment;

  /// No description provided for @drawerLightMode.
  ///
  /// In zh, this message translates to:
  /// **'切換亮色'**
  String get drawerLightMode;

  /// No description provided for @drawerDarkMode.
  ///
  /// In zh, this message translates to:
  /// **'切換暗色'**
  String get drawerDarkMode;

  /// No description provided for @drawerUsername.
  ///
  /// In zh, this message translates to:
  /// **'使用者名稱(開發中)'**
  String get drawerUsername;

  /// No description provided for @drawerEmail.
  ///
  /// In zh, this message translates to:
  /// **'test@test.com'**
  String get drawerEmail;

  /// No description provided for @workNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'作品通知'**
  String get workNotificationTitle;

  /// No description provided for @animeNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'收藏的動畫新集數通知'**
  String get animeNotificationTitle;

  /// No description provided for @animeNotificationDesc.
  ///
  /// In zh, this message translates to:
  /// **'當收藏的動畫有新集數時通知我'**
  String get animeNotificationDesc;

  /// No description provided for @novelNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'收藏的小說新集數通知'**
  String get novelNotificationTitle;

  /// No description provided for @novelNotificationDesc.
  ///
  /// In zh, this message translates to:
  /// **'當收藏的小說有新集數時通知我'**
  String get novelNotificationDesc;

  /// No description provided for @comicsNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'收藏的漫畫新集數通知'**
  String get comicsNotificationTitle;

  /// No description provided for @comicsNotificationDesc.
  ///
  /// In zh, this message translates to:
  /// **'當收藏的漫畫有新集數時通知我'**
  String get comicsNotificationDesc;

  /// No description provided for @checkNotificationNow.
  ///
  /// In zh, this message translates to:
  /// **'立即檢查通知'**
  String get checkNotificationNow;

  /// No description provided for @generalNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'通知設定'**
  String get generalNotificationTitle;

  /// No description provided for @vibrationNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'通知震動'**
  String get vibrationNotificationTitle;

  /// No description provided for @vibrationNotificationDesc.
  ///
  /// In zh, this message translates to:
  /// **'收到通知時震動提醒'**
  String get vibrationNotificationDesc;

  /// No description provided for @notificationTimeTitle.
  ///
  /// In zh, this message translates to:
  /// **'通知時間'**
  String get notificationTimeTitle;

  /// No description provided for @notificationTimeDesc.
  ///
  /// In zh, this message translates to:
  /// **'每天檢查通知的時間'**
  String get notificationTimeDesc;

  /// No description provided for @dataUpdateNotificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'資料更新通知'**
  String get dataUpdateNotificationTitle;

  /// No description provided for @dataUpdateNotificationDesc.
  ///
  /// In zh, this message translates to:
  /// **'超過7天未更新資料時提醒'**
  String get dataUpdateNotificationDesc;

  /// No description provided for @storageTitle.
  ///
  /// In zh, this message translates to:
  /// **'儲存空間'**
  String get storageTitle;

  /// No description provided for @currentUsage.
  ///
  /// In zh, this message translates to:
  /// **'目前使用：'**
  String get currentUsage;

  /// No description provided for @recalculate.
  ///
  /// In zh, this message translates to:
  /// **'重新計算'**
  String get recalculate;

  /// No description provided for @deleteDataConfirmTitle.
  ///
  /// In zh, this message translates to:
  /// **'刪除資料'**
  String get deleteDataConfirmTitle;

  /// No description provided for @deleteDataConfirmContent.
  ///
  /// In zh, this message translates to:
  /// **'確定要刪除所有資料嗎？\n\n刪除後：\n• 所有下載的資料將被清空\n• 應用內將無法顯示任何內容\n• 需要重新下載資料才能正常使用'**
  String get deleteDataConfirmContent;

  /// No description provided for @deleting.
  ///
  /// In zh, this message translates to:
  /// **'刪除中'**
  String get deleting;

  /// No description provided for @version.
  ///
  /// In zh, this message translates to:
  /// **'版本: '**
  String get version;

  /// No description provided for @viewTermsOfService.
  ///
  /// In zh, this message translates to:
  /// **'查看服務條款'**
  String get viewTermsOfService;

  /// No description provided for @viewPrivacyPolicy.
  ///
  /// In zh, this message translates to:
  /// **'查看隱私政策'**
  String get viewPrivacyPolicy;

  /// No description provided for @aboutAppTitle.
  ///
  /// In zh, this message translates to:
  /// **'關於 ACG大全'**
  String get aboutAppTitle;

  /// No description provided for @appVersion.
  ///
  /// In zh, this message translates to:
  /// **'ACG大全 - Pre-Alpha v0.2.0'**
  String get appVersion;

  /// No description provided for @developerInfo.
  ///
  /// In zh, this message translates to:
  /// **'開發者資訊: coffeecatstudio'**
  String get developerInfo;

  /// No description provided for @developer.
  ///
  /// In zh, this message translates to:
  /// **'開發人員: coffeecat'**
  String get developer;

  /// No description provided for @appIntroTitle.
  ///
  /// In zh, this message translates to:
  /// **'ACG大全 App 簡介'**
  String get appIntroTitle;

  /// No description provided for @appIntroContent.
  ///
  /// In zh, this message translates to:
  /// **'ACG大全 是一款專為 ACG 愛好者設計的應用程式，集成了動畫、漫畫、小說等多項資源的查詢功能。透過簡潔的介面和豐富的功能，為用戶提供最便捷的 ACG 資訊獲取體驗。'**
  String get appIntroContent;

  /// No description provided for @functionSpecTitle.
  ///
  /// In zh, this message translates to:
  /// **'功能特色'**
  String get functionSpecTitle;

  /// No description provided for @functionTutorialTitle.
  ///
  /// In zh, this message translates to:
  /// **'使用教學'**
  String get functionTutorialTitle;

  /// No description provided for @futurePlanTitle.
  ///
  /// In zh, this message translates to:
  /// **'未來計劃'**
  String get futurePlanTitle;

  /// No description provided for @contactInfoTitle.
  ///
  /// In zh, this message translates to:
  /// **'聯繫資訊'**
  String get contactInfoTitle;

  /// No description provided for @languageJapanese.
  ///
  /// In zh, this message translates to:
  /// **'日本語'**
  String get languageJapanese;

  /// No description provided for @scheduleToday.
  ///
  /// In zh, this message translates to:
  /// **'今日'**
  String get scheduleToday;

  /// No description provided for @scheduleWeekly.
  ///
  /// In zh, this message translates to:
  /// **'週間'**
  String get scheduleWeekly;

  /// No description provided for @scheduleMonthly.
  ///
  /// In zh, this message translates to:
  /// **'月間'**
  String get scheduleMonthly;

  /// No description provided for @scheduleOnAir.
  ///
  /// In zh, this message translates to:
  /// **'播放中'**
  String get scheduleOnAir;

  /// No description provided for @scheduleUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'即將播放'**
  String get scheduleUpcoming;

  /// No description provided for @scheduleCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已完結'**
  String get scheduleCompleted;

  /// No description provided for @scheduleMonday.
  ///
  /// In zh, this message translates to:
  /// **'一'**
  String get scheduleMonday;

  /// No description provided for @scheduleTuesday.
  ///
  /// In zh, this message translates to:
  /// **'二'**
  String get scheduleTuesday;

  /// No description provided for @scheduleWednesday.
  ///
  /// In zh, this message translates to:
  /// **'三'**
  String get scheduleWednesday;

  /// No description provided for @scheduleThursday.
  ///
  /// In zh, this message translates to:
  /// **'四'**
  String get scheduleThursday;

  /// No description provided for @scheduleFriday.
  ///
  /// In zh, this message translates to:
  /// **'五'**
  String get scheduleFriday;

  /// No description provided for @scheduleSaturday.
  ///
  /// In zh, this message translates to:
  /// **'六'**
  String get scheduleSaturday;

  /// No description provided for @scheduleSunday.
  ///
  /// In zh, this message translates to:
  /// **'日'**
  String get scheduleSunday;

  /// No description provided for @scheduleJan.
  ///
  /// In zh, this message translates to:
  /// **'1月'**
  String get scheduleJan;

  /// No description provided for @scheduleFeb.
  ///
  /// In zh, this message translates to:
  /// **'2月'**
  String get scheduleFeb;

  /// No description provided for @scheduleMar.
  ///
  /// In zh, this message translates to:
  /// **'3月'**
  String get scheduleMar;

  /// No description provided for @scheduleApr.
  ///
  /// In zh, this message translates to:
  /// **'4月'**
  String get scheduleApr;

  /// No description provided for @scheduleMay.
  ///
  /// In zh, this message translates to:
  /// **'5月'**
  String get scheduleMay;

  /// No description provided for @scheduleJun.
  ///
  /// In zh, this message translates to:
  /// **'6月'**
  String get scheduleJun;

  /// No description provided for @scheduleJul.
  ///
  /// In zh, this message translates to:
  /// **'7月'**
  String get scheduleJul;

  /// No description provided for @scheduleAug.
  ///
  /// In zh, this message translates to:
  /// **'8月'**
  String get scheduleAug;

  /// No description provided for @scheduleSep.
  ///
  /// In zh, this message translates to:
  /// **'9月'**
  String get scheduleSep;

  /// No description provided for @scheduleOct.
  ///
  /// In zh, this message translates to:
  /// **'10月'**
  String get scheduleOct;

  /// No description provided for @scheduleNov.
  ///
  /// In zh, this message translates to:
  /// **'11月'**
  String get scheduleNov;

  /// No description provided for @scheduleDec.
  ///
  /// In zh, this message translates to:
  /// **'12月'**
  String get scheduleDec;

  /// No description provided for @scheduleSpring.
  ///
  /// In zh, this message translates to:
  /// **'春'**
  String get scheduleSpring;

  /// No description provided for @scheduleSummer.
  ///
  /// In zh, this message translates to:
  /// **'夏'**
  String get scheduleSummer;

  /// No description provided for @scheduleAutumn.
  ///
  /// In zh, this message translates to:
  /// **'秋'**
  String get scheduleAutumn;

  /// No description provided for @scheduleWinter.
  ///
  /// In zh, this message translates to:
  /// **'冬'**
  String get scheduleWinter;

  /// No description provided for @scheduleNoData.
  ///
  /// In zh, this message translates to:
  /// **'暫無資料'**
  String get scheduleNoData;

  /// No description provided for @scheduleLoadError.
  ///
  /// In zh, this message translates to:
  /// **'載入錯誤'**
  String get scheduleLoadError;

  /// No description provided for @scheduleRetry.
  ///
  /// In zh, this message translates to:
  /// **'重試'**
  String get scheduleRetry;

  /// No description provided for @scheduleRefresh.
  ///
  /// In zh, this message translates to:
  /// **'重新整理'**
  String get scheduleRefresh;

  /// No description provided for @scheduleFilter.
  ///
  /// In zh, this message translates to:
  /// **'篩選'**
  String get scheduleFilter;

  /// No description provided for @scheduleSort.
  ///
  /// In zh, this message translates to:
  /// **'排序'**
  String get scheduleSort;

  /// No description provided for @scheduleSearch.
  ///
  /// In zh, this message translates to:
  /// **'搜尋'**
  String get scheduleSearch;

  /// No description provided for @scheduleGenre.
  ///
  /// In zh, this message translates to:
  /// **'類型'**
  String get scheduleGenre;

  /// No description provided for @scheduleStudio.
  ///
  /// In zh, this message translates to:
  /// **'製作公司'**
  String get scheduleStudio;

  /// No description provided for @scheduleSource.
  ///
  /// In zh, this message translates to:
  /// **'原作'**
  String get scheduleSource;

  /// No description provided for @scheduleEpisodes.
  ///
  /// In zh, this message translates to:
  /// **'集數'**
  String get scheduleEpisodes;

  /// No description provided for @scheduleStatus.
  ///
  /// In zh, this message translates to:
  /// **'狀態'**
  String get scheduleStatus;

  /// No description provided for @scheduleRating.
  ///
  /// In zh, this message translates to:
  /// **'評分'**
  String get scheduleRating;

  /// No description provided for @scheduleYear.
  ///
  /// In zh, this message translates to:
  /// **'年份'**
  String get scheduleYear;

  /// No description provided for @scheduleSeason.
  ///
  /// In zh, this message translates to:
  /// **'季度'**
  String get scheduleSeason;

  /// No description provided for @userProfile.
  ///
  /// In zh, this message translates to:
  /// **'個人資料'**
  String get userProfile;

  /// No description provided for @userDashboard.
  ///
  /// In zh, this message translates to:
  /// **'數據統計'**
  String get userDashboard;

  /// No description provided for @userQuickActions.
  ///
  /// In zh, this message translates to:
  /// **'快速操作'**
  String get userQuickActions;

  /// No description provided for @userSettings.
  ///
  /// In zh, this message translates to:
  /// **'個人設定'**
  String get userSettings;

  /// No description provided for @userName.
  ///
  /// In zh, this message translates to:
  /// **'使用者名稱'**
  String get userName;

  /// No description provided for @userEmail.
  ///
  /// In zh, this message translates to:
  /// **'電子郵件'**
  String get userEmail;

  /// No description provided for @editProfile.
  ///
  /// In zh, this message translates to:
  /// **'編輯個人資料'**
  String get editProfile;

  /// No description provided for @userStats.
  ///
  /// In zh, this message translates to:
  /// **'統計數據'**
  String get userStats;

  /// No description provided for @totalFavorites.
  ///
  /// In zh, this message translates to:
  /// **'總收藏'**
  String get totalFavorites;

  /// No description provided for @animeWatched.
  ///
  /// In zh, this message translates to:
  /// **'已觀看動畫'**
  String get animeWatched;

  /// No description provided for @booksRead.
  ///
  /// In zh, this message translates to:
  /// **'已閱讀書籍'**
  String get booksRead;

  /// No description provided for @averageRating.
  ///
  /// In zh, this message translates to:
  /// **'平均評分'**
  String get averageRating;

  /// No description provided for @watchTime.
  ///
  /// In zh, this message translates to:
  /// **'觀看時間'**
  String get watchTime;

  /// No description provided for @taggedWorks.
  ///
  /// In zh, this message translates to:
  /// **'已標籤作品'**
  String get taggedWorks;

  /// No description provided for @achievements.
  ///
  /// In zh, this message translates to:
  /// **'成就'**
  String get achievements;

  /// No description provided for @recentActivity.
  ///
  /// In zh, this message translates to:
  /// **'最近活動'**
  String get recentActivity;

  /// No description provided for @continueWatching.
  ///
  /// In zh, this message translates to:
  /// **'繼續觀看'**
  String get continueWatching;

  /// No description provided for @recentViewed.
  ///
  /// In zh, this message translates to:
  /// **'最近查看'**
  String get recentViewed;

  /// No description provided for @watchlist.
  ///
  /// In zh, this message translates to:
  /// **'待看清單'**
  String get watchlist;

  /// No description provided for @recentFavorites.
  ///
  /// In zh, this message translates to:
  /// **'最近收藏'**
  String get recentFavorites;

  /// No description provided for @viewAll.
  ///
  /// In zh, this message translates to:
  /// **'查看全部'**
  String get viewAll;

  /// No description provided for @noRecentActivity.
  ///
  /// In zh, this message translates to:
  /// **'暫無最近活動'**
  String get noRecentActivity;

  /// No description provided for @noContinueWatching.
  ///
  /// In zh, this message translates to:
  /// **'暫無繼續觀看'**
  String get noContinueWatching;

  /// No description provided for @noWatchlist.
  ///
  /// In zh, this message translates to:
  /// **'待看清單為空'**
  String get noWatchlist;

  /// No description provided for @accountSettings.
  ///
  /// In zh, this message translates to:
  /// **'帳戶設定'**
  String get accountSettings;

  /// No description provided for @dataBackup.
  ///
  /// In zh, this message translates to:
  /// **'資料備份'**
  String get dataBackup;

  /// No description provided for @helpCenter.
  ///
  /// In zh, this message translates to:
  /// **'幫助中心'**
  String get helpCenter;

  /// No description provided for @aboutApp.
  ///
  /// In zh, this message translates to:
  /// **'關於應用'**
  String get aboutApp;

  /// No description provided for @signOut.
  ///
  /// In zh, this message translates to:
  /// **'登出'**
  String get signOut;

  /// No description provided for @hours.
  ///
  /// In zh, this message translates to:
  /// **'小時'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In zh, this message translates to:
  /// **'分鐘'**
  String get minutes;

  /// No description provided for @episodes.
  ///
  /// In zh, this message translates to:
  /// **'集'**
  String get episodes;

  /// No description provided for @chapters.
  ///
  /// In zh, this message translates to:
  /// **'章'**
  String get chapters;

  /// No description provided for @level.
  ///
  /// In zh, this message translates to:
  /// **'等級'**
  String get level;

  /// No description provided for @exp.
  ///
  /// In zh, this message translates to:
  /// **'經驗值'**
  String get exp;

  /// No description provided for @nextLevel.
  ///
  /// In zh, this message translates to:
  /// **'下一等級'**
  String get nextLevel;

  /// No description provided for @userLevel.
  ///
  /// In zh, this message translates to:
  /// **'用戶等級'**
  String get userLevel;

  /// No description provided for @beginner.
  ///
  /// In zh, this message translates to:
  /// **'新手'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In zh, this message translates to:
  /// **'進階'**
  String get intermediate;

  /// No description provided for @advanced.
  ///
  /// In zh, this message translates to:
  /// **'高級'**
  String get advanced;

  /// No description provided for @expert.
  ///
  /// In zh, this message translates to:
  /// **'專家'**
  String get expert;

  /// No description provided for @master.
  ///
  /// In zh, this message translates to:
  /// **'大師'**
  String get master;

  /// No description provided for @editProfileTitle.
  ///
  /// In zh, this message translates to:
  /// **'編輯個人資料'**
  String get editProfileTitle;

  /// No description provided for @profilePicture.
  ///
  /// In zh, this message translates to:
  /// **'個人頭像'**
  String get profilePicture;

  /// No description provided for @changePicture.
  ///
  /// In zh, this message translates to:
  /// **'更換頭像'**
  String get changePicture;

  /// No description provided for @selectFromGallery.
  ///
  /// In zh, this message translates to:
  /// **'從相簿選擇'**
  String get selectFromGallery;

  /// No description provided for @selectFromCamera.
  ///
  /// In zh, this message translates to:
  /// **'拍攝照片'**
  String get selectFromCamera;

  /// No description provided for @removePhoto.
  ///
  /// In zh, this message translates to:
  /// **'移除照片'**
  String get removePhoto;

  /// No description provided for @personalInfo.
  ///
  /// In zh, this message translates to:
  /// **'個人資訊'**
  String get personalInfo;

  /// No description provided for @displayName.
  ///
  /// In zh, this message translates to:
  /// **'顯示名稱'**
  String get displayName;

  /// No description provided for @email.
  ///
  /// In zh, this message translates to:
  /// **'電子郵件'**
  String get email;

  /// No description provided for @bio.
  ///
  /// In zh, this message translates to:
  /// **'個人簡介'**
  String get bio;

  /// No description provided for @bioHint.
  ///
  /// In zh, this message translates to:
  /// **'介紹一下自己...'**
  String get bioHint;

  /// No description provided for @preferences.
  ///
  /// In zh, this message translates to:
  /// **'偏好設定'**
  String get preferences;

  /// No description provided for @favoriteGenre.
  ///
  /// In zh, this message translates to:
  /// **'喜愛類型'**
  String get favoriteGenre;

  /// No description provided for @animeGenre.
  ///
  /// In zh, this message translates to:
  /// **'動畫類型'**
  String get animeGenre;

  /// No description provided for @novelGenre.
  ///
  /// In zh, this message translates to:
  /// **'小說類型'**
  String get novelGenre;

  /// No description provided for @comicsGenre.
  ///
  /// In zh, this message translates to:
  /// **'漫畫類型'**
  String get comicsGenre;

  /// No description provided for @saveProfile.
  ///
  /// In zh, this message translates to:
  /// **'儲存資料'**
  String get saveProfile;

  /// No description provided for @saveSuccess.
  ///
  /// In zh, this message translates to:
  /// **'資料儲存成功'**
  String get saveSuccess;

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'儲存失敗'**
  String get saveFailed;

  /// No description provided for @nameRequired.
  ///
  /// In zh, this message translates to:
  /// **'請輸入顯示名稱'**
  String get nameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In zh, this message translates to:
  /// **'請輸入電子郵件'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In zh, this message translates to:
  /// **'請輸入有效的電子郵件'**
  String get emailInvalid;

  /// No description provided for @nameTooLong.
  ///
  /// In zh, this message translates to:
  /// **'名稱過長（最多20字）'**
  String get nameTooLong;

  /// No description provided for @bioTooLong.
  ///
  /// In zh, this message translates to:
  /// **'個人簡介過長（最多200字）'**
  String get bioTooLong;

  /// No description provided for @discardChanges.
  ///
  /// In zh, this message translates to:
  /// **'放棄變更'**
  String get discardChanges;

  /// No description provided for @discardMessage.
  ///
  /// In zh, this message translates to:
  /// **'確定要放棄變更嗎？'**
  String get discardMessage;

  /// No description provided for @pickImage.
  ///
  /// In zh, this message translates to:
  /// **'選擇圖片'**
  String get pickImage;

  /// No description provided for @imagePickerError.
  ///
  /// In zh, this message translates to:
  /// **'圖片選擇失敗'**
  String get imagePickerError;

  /// No description provided for @compressImage.
  ///
  /// In zh, this message translates to:
  /// **'壓縮圖片中...'**
  String get compressImage;

  /// No description provided for @profileUpdated.
  ///
  /// In zh, this message translates to:
  /// **'個人資料已更新'**
  String get profileUpdated;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

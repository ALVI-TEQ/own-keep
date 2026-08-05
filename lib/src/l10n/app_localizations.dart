import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ta'),
    Locale('te'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'OwnKeep'**
  String get appTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to OwnKeep'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Secure, private, and localized data storage.'**
  String get welcomeSubtitle;

  /// No description provided for @btnNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get btnNext;

  /// No description provided for @btnGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get btnGetStarted;

  /// No description provided for @btnCreateVault.
  ///
  /// In en, this message translates to:
  /// **'Create Vault'**
  String get btnCreateVault;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @btnSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get btnSkip;

  /// No description provided for @btnVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get btnVerify;

  /// No description provided for @btnEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get btnEnable;

  /// No description provided for @btnNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get btnNotNow;

  /// No description provided for @btnDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get btnDone;

  /// No description provided for @feature1Title.
  ///
  /// In en, this message translates to:
  /// **'Total Privacy'**
  String get feature1Title;

  /// No description provided for @feature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on your device.'**
  String get feature1Desc;

  /// No description provided for @feature2Title.
  ///
  /// In en, this message translates to:
  /// **'Local AI'**
  String get feature2Title;

  /// No description provided for @feature2Desc.
  ///
  /// In en, this message translates to:
  /// **'Smart organization without the cloud.'**
  String get feature2Desc;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Zero Knowledge'**
  String get feature3Title;

  /// No description provided for @feature3Desc.
  ///
  /// In en, this message translates to:
  /// **'Encrypted with your unique key.'**
  String get feature3Desc;

  /// No description provided for @createVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your Vault'**
  String get createVaultTitle;

  /// No description provided for @createVaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Set up a secure vault to store all your important documents.'**
  String get createVaultDesc;

  /// No description provided for @setPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your PIN'**
  String get setPinTitle;

  /// No description provided for @setPinDesc.
  ///
  /// In en, this message translates to:
  /// **'This PIN encrypts your vault. Do not forget it.'**
  String get setPinDesc;

  /// No description provided for @confirmPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get confirmPinTitle;

  /// No description provided for @confirmPinDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN again to verify.'**
  String get confirmPinDesc;

  /// No description provided for @pinMismatchError.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match. Try again.'**
  String get pinMismatchError;

  /// No description provided for @recoveryPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery Phrase'**
  String get recoveryPhraseTitle;

  /// No description provided for @recoveryPhraseDesc.
  ///
  /// In en, this message translates to:
  /// **'Write down these 12 words. They are the only way to recover your vault.'**
  String get recoveryPhraseDesc;

  /// No description provided for @verifyPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Recovery Phrase'**
  String get verifyPhraseTitle;

  /// No description provided for @verifyPhraseDesc.
  ///
  /// In en, this message translates to:
  /// **'Select the words in the correct order to verify.'**
  String get verifyPhraseDesc;

  /// No description provided for @enableBiometricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometrics'**
  String get enableBiometricsTitle;

  /// No description provided for @enableBiometricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID or Touch ID for faster access.'**
  String get enableBiometricsDesc;

  /// No description provided for @setupCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup Complete'**
  String get setupCompleteTitle;

  /// No description provided for @setupCompleteDesc.
  ///
  /// In en, this message translates to:
  /// **'Your vault is ready. Let\'s go!'**
  String get setupCompleteDesc;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCollections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get navCollections;

  /// No description provided for @navAllFiles.
  ///
  /// In en, this message translates to:
  /// **'All Files'**
  String get navAllFiles;

  /// No description provided for @navRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get navRecent;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @filterAndSort.
  ///
  /// In en, this message translates to:
  /// **'Filter & Sort'**
  String get filterAndSort;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search your vault...'**
  String get searchPlaceholder;

  /// No description provided for @quickStats.
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get quickStats;

  /// No description provided for @totalFiles.
  ///
  /// In en, this message translates to:
  /// **'Total Files'**
  String get totalFiles;

  /// No description provided for @spaceUsed.
  ///
  /// In en, this message translates to:
  /// **'Space Used'**
  String get spaceUsed;

  /// No description provided for @s01_brand_name.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep'**
  String get s01_brand_name;

  /// No description provided for @s01_tagline_line_1.
  ///
  /// In en, this message translates to:
  /// **'Keep What Matters.'**
  String get s01_tagline_line_1;

  /// No description provided for @s01_tagline_line_2.
  ///
  /// In en, this message translates to:
  /// **'Own Your Data.'**
  String get s01_tagline_line_2;

  /// No description provided for @s01_security_badge.
  ///
  /// In en, this message translates to:
  /// **'100% Offline • End-to-End Encrypted'**
  String get s01_security_badge;

  /// No description provided for @s01_action_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get s01_action_get_started;

  /// No description provided for @s01_action_existing_account.
  ///
  /// In en, this message translates to:
  /// **'I have an account'**
  String get s01_action_existing_account;

  /// No description provided for @s02_title_line_1.
  ///
  /// In en, this message translates to:
  /// **'Your data.'**
  String get s02_title_line_1;

  /// No description provided for @s02_title_line_2.
  ///
  /// In en, this message translates to:
  /// **'Your control.'**
  String get s02_title_line_2;

  /// No description provided for @s02_offline_title.
  ///
  /// In en, this message translates to:
  /// **'100% Offline'**
  String get s02_offline_title;

  /// No description provided for @s02_offline_body.
  ///
  /// In en, this message translates to:
  /// **'No servers. Ever.'**
  String get s02_offline_body;

  /// No description provided for @s02_encrypted_title.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encrypted'**
  String get s02_encrypted_title;

  /// No description provided for @s02_encrypted_body.
  ///
  /// In en, this message translates to:
  /// **'Only you have the key.'**
  String get s02_encrypted_body;

  /// No description provided for @s02_forever_title.
  ///
  /// In en, this message translates to:
  /// **'Yours Forever'**
  String get s02_forever_title;

  /// No description provided for @s02_forever_body.
  ///
  /// In en, this message translates to:
  /// **'No tracking. No ads.'**
  String get s02_forever_body;

  /// No description provided for @s02_action_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get s02_action_continue;

  /// No description provided for @s02_action_learn_more.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get s02_action_learn_more;

  /// No description provided for @s03_title.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to keep safe'**
  String get s03_title;

  /// No description provided for @s03_store_title.
  ///
  /// In en, this message translates to:
  /// **'Store Everything'**
  String get s03_store_title;

  /// No description provided for @s03_store_body.
  ///
  /// In en, this message translates to:
  /// **'Documents, photos, files & more'**
  String get s03_store_body;

  /// No description provided for @s03_ai_title.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered'**
  String get s03_ai_title;

  /// No description provided for @s03_ai_body.
  ///
  /// In en, this message translates to:
  /// **'Smart search, insights & suggestions'**
  String get s03_ai_body;

  /// No description provided for @s03_organized_title.
  ///
  /// In en, this message translates to:
  /// **'Organized'**
  String get s03_organized_title;

  /// No description provided for @s03_organized_body.
  ///
  /// In en, this message translates to:
  /// **'Smart collections & tags'**
  String get s03_organized_body;

  /// No description provided for @s03_secure_title.
  ///
  /// In en, this message translates to:
  /// **'Secure by Design'**
  String get s03_secure_title;

  /// No description provided for @s03_secure_body.
  ///
  /// In en, this message translates to:
  /// **'Military-grade encryption'**
  String get s03_secure_body;

  /// No description provided for @s03_action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get s03_action_next;

  /// No description provided for @s04_title.
  ///
  /// In en, this message translates to:
  /// **'Let\'s create your vault'**
  String get s04_title;

  /// No description provided for @s04_body.
  ///
  /// In en, this message translates to:
  /// **'Your vault is a secure space on this device. No data leaves your phone.'**
  String get s04_body;

  /// No description provided for @s04_action_create.
  ///
  /// In en, this message translates to:
  /// **'Create Vault'**
  String get s04_action_create;

  /// No description provided for @s04_action_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get s04_action_skip;

  /// No description provided for @s05_title.
  ///
  /// In en, this message translates to:
  /// **'Set a strong PIN'**
  String get s05_title;

  /// No description provided for @s05_body.
  ///
  /// In en, this message translates to:
  /// **'You\'ll use this to unlock your vault'**
  String get s05_body;

  /// No description provided for @s06_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get s06_title;

  /// No description provided for @s06_body.
  ///
  /// In en, this message translates to:
  /// **'Enter the same PIN again'**
  String get s06_body;

  /// No description provided for @s07_title.
  ///
  /// In en, this message translates to:
  /// **'Your recovery phrase'**
  String get s07_title;

  /// No description provided for @s07_body.
  ///
  /// In en, this message translates to:
  /// **'Write these words down in order and keep them safe.'**
  String get s07_body;

  /// No description provided for @s07_word_01.
  ///
  /// In en, this message translates to:
  /// **'mango'**
  String get s07_word_01;

  /// No description provided for @s07_word_02.
  ///
  /// In en, this message translates to:
  /// **'desert'**
  String get s07_word_02;

  /// No description provided for @s07_word_03.
  ///
  /// In en, this message translates to:
  /// **'trust'**
  String get s07_word_03;

  /// No description provided for @s07_word_04.
  ///
  /// In en, this message translates to:
  /// **'polar'**
  String get s07_word_04;

  /// No description provided for @s07_word_05.
  ///
  /// In en, this message translates to:
  /// **'kitten'**
  String get s07_word_05;

  /// No description provided for @s07_word_06.
  ///
  /// In en, this message translates to:
  /// **'guitar'**
  String get s07_word_06;

  /// No description provided for @s07_word_07.
  ///
  /// In en, this message translates to:
  /// **'planet'**
  String get s07_word_07;

  /// No description provided for @s07_word_08.
  ///
  /// In en, this message translates to:
  /// **'purple'**
  String get s07_word_08;

  /// No description provided for @s07_word_09.
  ///
  /// In en, this message translates to:
  /// **'silver'**
  String get s07_word_09;

  /// No description provided for @s07_word_10.
  ///
  /// In en, this message translates to:
  /// **'eagle'**
  String get s07_word_10;

  /// No description provided for @s07_word_11.
  ///
  /// In en, this message translates to:
  /// **'bridge'**
  String get s07_word_11;

  /// No description provided for @s07_word_12.
  ///
  /// In en, this message translates to:
  /// **'fitness'**
  String get s07_word_12;

  /// No description provided for @s07_warning.
  ///
  /// In en, this message translates to:
  /// **'Never share your recovery phrase with anyone.'**
  String get s07_warning;

  /// No description provided for @s07_action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get s07_action_next;

  /// No description provided for @s08_title.
  ///
  /// In en, this message translates to:
  /// **'Verify your phrase'**
  String get s08_title;

  /// No description provided for @s08_body.
  ///
  /// In en, this message translates to:
  /// **'Tap the words in the correct order'**
  String get s08_body;

  /// No description provided for @s08_action_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get s08_action_verify;

  /// No description provided for @s08_action_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear Selection'**
  String get s08_action_clear;

  /// No description provided for @s08_error_incomplete.
  ///
  /// In en, this message translates to:
  /// **'Please select all 12 words.'**
  String get s08_error_incomplete;

  /// No description provided for @s08_error_incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect order. Please try again.'**
  String get s08_error_incorrect;

  /// No description provided for @s09_title.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometrics'**
  String get s09_title;

  /// No description provided for @s09_body.
  ///
  /// In en, this message translates to:
  /// **'Use your fingerprint or face to unlock your vault quickly.'**
  String get s09_body;

  /// No description provided for @s09_fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Use Fingerprint'**
  String get s09_fingerprint;

  /// No description provided for @s09_face_id.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID'**
  String get s09_face_id;

  /// No description provided for @s09_action_enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get s09_action_enable;

  /// No description provided for @s09_action_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get s09_action_skip;

  /// No description provided for @s10_title.
  ///
  /// In en, this message translates to:
  /// **'Everything is set up.'**
  String get s10_title;

  /// No description provided for @s10_body.
  ///
  /// In en, this message translates to:
  /// **'You can start adding your important data.'**
  String get s10_body;

  /// No description provided for @s10_action_home.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get s10_action_home;

  /// No description provided for @s11_greeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening, Arjun 👋'**
  String get s11_greeting;

  /// No description provided for @s11_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything important is safe and organized'**
  String get s11_subtitle;

  /// No description provided for @s11_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search anything...'**
  String get s11_search_hint;

  /// No description provided for @s11_action_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get s11_action_scan;

  /// No description provided for @s11_action_add_new.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get s11_action_add_new;

  /// No description provided for @s11_action_ai_assistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get s11_action_ai_assistant;

  /// No description provided for @s11_action_quick_note.
  ///
  /// In en, this message translates to:
  /// **'Quick Note'**
  String get s11_action_quick_note;

  /// No description provided for @s11_recent_items.
  ///
  /// In en, this message translates to:
  /// **'Recent Items'**
  String get s11_recent_items;

  /// No description provided for @common_view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get common_view_all;

  /// No description provided for @s11_recent_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s11_recent_passport;

  /// No description provided for @s11_recent_passport_time.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM'**
  String get s11_recent_passport_time;

  /// No description provided for @s11_recent_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s11_recent_insurance;

  /// No description provided for @s11_recent_insurance_time.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get s11_recent_insurance_time;

  /// No description provided for @s11_recent_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get s11_recent_licence;

  /// No description provided for @s11_recent_licence_time.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get s11_recent_licence_time;

  /// No description provided for @s11_smart_collections.
  ///
  /// In en, this message translates to:
  /// **'Smart Collections'**
  String get s11_smart_collections;

  /// No description provided for @collection_personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get collection_personal;

  /// No description provided for @collection_finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get collection_finance;

  /// No description provided for @collection_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get collection_health;

  /// No description provided for @collection_property.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get collection_property;

  /// No description provided for @s11_personal_count.
  ///
  /// In en, this message translates to:
  /// **'28 items'**
  String get s11_personal_count;

  /// No description provided for @s11_finance_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s11_finance_count;

  /// No description provided for @s11_health_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s11_health_count;

  /// No description provided for @s11_property_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s11_property_count;

  /// No description provided for @s11_today_reminder.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Reminder'**
  String get s11_today_reminder;

  /// No description provided for @s11_reminder_text.
  ///
  /// In en, this message translates to:
  /// **'Vehicle insurance expires in 15 days'**
  String get s11_reminder_text;

  /// No description provided for @s11_storage_overview.
  ///
  /// In en, this message translates to:
  /// **'Storage Overview'**
  String get s11_storage_overview;

  /// No description provided for @s11_storage_value.
  ///
  /// In en, this message translates to:
  /// **'2.4 GB of 10 GB used'**
  String get s11_storage_value;

  /// No description provided for @s11_storage_percent.
  ///
  /// In en, this message translates to:
  /// **'24%'**
  String get s11_storage_percent;

  /// No description provided for @s12_title.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get s12_title;

  /// No description provided for @s12_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything in its place'**
  String get s12_subtitle;

  /// No description provided for @s12_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search collections...'**
  String get s12_search_hint;

  /// No description provided for @s12_total_collections.
  ///
  /// In en, this message translates to:
  /// **'Total Collections'**
  String get s12_total_collections;

  /// No description provided for @s12_collection_total.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s12_collection_total;

  /// No description provided for @s12_item_total.
  ///
  /// In en, this message translates to:
  /// **'128 items'**
  String get s12_item_total;

  /// No description provided for @collection_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get collection_vehicle;

  /// No description provided for @collection_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get collection_education;

  /// No description provided for @collection_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get collection_others;

  /// No description provided for @s12_personal_count.
  ///
  /// In en, this message translates to:
  /// **'28 items'**
  String get s12_personal_count;

  /// No description provided for @s12_finance_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s12_finance_count;

  /// No description provided for @s12_health_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s12_health_count;

  /// No description provided for @s12_property_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s12_property_count;

  /// No description provided for @s12_vehicle_count.
  ///
  /// In en, this message translates to:
  /// **'8 items'**
  String get s12_vehicle_count;

  /// No description provided for @s12_education_count.
  ///
  /// In en, this message translates to:
  /// **'6 items'**
  String get s12_education_count;

  /// No description provided for @s12_others_count.
  ///
  /// In en, this message translates to:
  /// **'7 items'**
  String get s12_others_count;

  /// No description provided for @s13_title.
  ///
  /// In en, this message translates to:
  /// **'All Files'**
  String get s13_title;

  /// No description provided for @s13_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything stored in your vault'**
  String get s13_subtitle;

  /// No description provided for @s13_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search all files...'**
  String get s13_search_hint;

  /// No description provided for @filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filter_all;

  /// No description provided for @filter_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get filter_documents;

  /// No description provided for @filter_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get filter_images;

  /// No description provided for @filter_videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get filter_videos;

  /// No description provided for @filter_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get filter_others;

  /// No description provided for @s13_all_count.
  ///
  /// In en, this message translates to:
  /// **'128'**
  String get s13_all_count;

  /// No description provided for @s13_passport_title.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s13_passport_title;

  /// No description provided for @s13_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 1.2 MB • Today, 10:30 AM'**
  String get s13_passport_meta;

  /// No description provided for @s13_insurance_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s13_insurance_title;

  /// No description provided for @s13_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 2.4 MB • Yesterday'**
  String get s13_insurance_meta;

  /// No description provided for @s13_licence_title.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence.jpg'**
  String get s13_licence_title;

  /// No description provided for @s13_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG • 860 KB • 2 days ago'**
  String get s13_licence_meta;

  /// No description provided for @s13_bank_title.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement.pdf'**
  String get s13_bank_title;

  /// No description provided for @s13_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 3.1 MB • 3 days ago'**
  String get s13_bank_meta;

  /// No description provided for @s13_family_photo_title.
  ///
  /// In en, this message translates to:
  /// **'Family Photo.jpg'**
  String get s13_family_photo_title;

  /// No description provided for @s13_family_photo_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG • 4.6 MB • 5 days ago'**
  String get s13_family_photo_meta;

  /// No description provided for @s13_investment_title.
  ///
  /// In en, this message translates to:
  /// **'Investment Summary.xlsx'**
  String get s13_investment_title;

  /// No description provided for @s13_investment_meta.
  ///
  /// In en, this message translates to:
  /// **'XLSX • 540 KB • 7 days ago'**
  String get s13_investment_meta;

  /// No description provided for @s13_property_title.
  ///
  /// In en, this message translates to:
  /// **'Property Papers.pdf'**
  String get s13_property_title;

  /// No description provided for @s13_property_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 4.8 MB • 8 days ago'**
  String get s13_property_meta;

  /// No description provided for @s13_project_title.
  ///
  /// In en, this message translates to:
  /// **'Project Plan.docx'**
  String get s13_project_title;

  /// No description provided for @s13_project_meta.
  ///
  /// In en, this message translates to:
  /// **'DOCX • 520 KB • 9 days ago'**
  String get s13_project_meta;

  /// No description provided for @s14_title.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get s14_title;

  /// No description provided for @s14_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your latest vault activity'**
  String get s14_subtitle;

  /// No description provided for @filter_viewed.
  ///
  /// In en, this message translates to:
  /// **'Viewed'**
  String get filter_viewed;

  /// No description provided for @filter_added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get filter_added;

  /// No description provided for @filter_updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get filter_updated;

  /// No description provided for @common_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get common_today;

  /// No description provided for @common_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get common_yesterday;

  /// No description provided for @s14_insurance_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s14_insurance_title;

  /// No description provided for @s14_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'Viewed • 10:30 AM'**
  String get s14_insurance_meta;

  /// No description provided for @s14_passport_title.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s14_passport_title;

  /// No description provided for @s14_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'Viewed • 9:15 AM'**
  String get s14_passport_meta;

  /// No description provided for @s14_vehicle_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get s14_vehicle_title;

  /// No description provided for @s14_vehicle_meta.
  ///
  /// In en, this message translates to:
  /// **'Added • 8:45 AM'**
  String get s14_vehicle_meta;

  /// No description provided for @s14_licence_title.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get s14_licence_title;

  /// No description provided for @s14_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'Updated • 7:30 PM'**
  String get s14_licence_meta;

  /// No description provided for @s14_bank_title.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement'**
  String get s14_bank_title;

  /// No description provided for @s14_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'Added • 4:20 PM'**
  String get s14_bank_meta;

  /// No description provided for @s14_aadhaar_title.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get s14_aadhaar_title;

  /// No description provided for @s14_aadhaar_meta.
  ///
  /// In en, this message translates to:
  /// **'Viewed • 11:10 AM'**
  String get s14_aadhaar_meta;

  /// No description provided for @s14_lic_title.
  ///
  /// In en, this message translates to:
  /// **'LIC Policy'**
  String get s14_lic_title;

  /// No description provided for @s14_lic_meta.
  ///
  /// In en, this message translates to:
  /// **'Added • 10:05 AM'**
  String get s14_lic_meta;

  /// No description provided for @s15_title.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get s15_title;

  /// No description provided for @s15_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All your important items in one place'**
  String get s15_subtitle;

  /// No description provided for @s15_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search favorites...'**
  String get s15_search_hint;

  /// No description provided for @s15_passport_title.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s15_passport_title;

  /// No description provided for @s15_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 1.2 MB • Today'**
  String get s15_passport_meta;

  /// No description provided for @s15_insurance_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s15_insurance_title;

  /// No description provided for @s15_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 2.4 MB • Yesterday'**
  String get s15_insurance_meta;

  /// No description provided for @s15_family_photo_title.
  ///
  /// In en, this message translates to:
  /// **'Family Photo'**
  String get s15_family_photo_title;

  /// No description provided for @s15_family_photo_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG • 3.6 MB • 2 days ago'**
  String get s15_family_photo_meta;

  /// No description provided for @s15_aadhaar_title.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get s15_aadhaar_title;

  /// No description provided for @s15_aadhaar_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 1.1 MB • 3 days ago'**
  String get s15_aadhaar_meta;

  /// No description provided for @s15_licence_title.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get s15_licence_title;

  /// No description provided for @s15_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 1.0 MB • 5 days ago'**
  String get s15_licence_meta;

  /// No description provided for @s15_bank_title.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement'**
  String get s15_bank_title;

  /// No description provided for @s15_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 3.2 MB • 7 days ago'**
  String get s15_bank_meta;

  /// No description provided for @s15_itr_title.
  ///
  /// In en, this message translates to:
  /// **'Income Tax Return 2024'**
  String get s15_itr_title;

  /// No description provided for @s15_itr_meta.
  ///
  /// In en, this message translates to:
  /// **'XLSX • 540 KB • 10 days ago'**
  String get s15_itr_meta;

  /// No description provided for @s16_title.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get s16_title;

  /// No description provided for @s16_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse by type'**
  String get s16_subtitle;

  /// No description provided for @s16_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search categories...'**
  String get s16_search_hint;

  /// No description provided for @collection_identity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get collection_identity;

  /// No description provided for @collection_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get collection_insurance;

  /// No description provided for @collection_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get collection_work;

  /// No description provided for @collection_travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get collection_travel;

  /// No description provided for @collection_family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get collection_family;

  /// No description provided for @collection_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get collection_important;

  /// No description provided for @s16_identity_count.
  ///
  /// In en, this message translates to:
  /// **'24 items'**
  String get s16_identity_count;

  /// No description provided for @s16_finance_count.
  ///
  /// In en, this message translates to:
  /// **'38 items'**
  String get s16_finance_count;

  /// No description provided for @s16_insurance_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s16_insurance_count;

  /// No description provided for @s16_health_count.
  ///
  /// In en, this message translates to:
  /// **'22 items'**
  String get s16_health_count;

  /// No description provided for @s16_property_count.
  ///
  /// In en, this message translates to:
  /// **'18 items'**
  String get s16_property_count;

  /// No description provided for @s16_vehicle_count.
  ///
  /// In en, this message translates to:
  /// **'14 items'**
  String get s16_vehicle_count;

  /// No description provided for @s16_education_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s16_education_count;

  /// No description provided for @s16_work_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s16_work_count;

  /// No description provided for @s16_personal_count.
  ///
  /// In en, this message translates to:
  /// **'27 items'**
  String get s16_personal_count;

  /// No description provided for @s16_travel_count.
  ///
  /// In en, this message translates to:
  /// **'6 items'**
  String get s16_travel_count;

  /// No description provided for @s16_family_count.
  ///
  /// In en, this message translates to:
  /// **'11 items'**
  String get s16_family_count;

  /// No description provided for @s16_important_count.
  ///
  /// In en, this message translates to:
  /// **'10 items'**
  String get s16_important_count;

  /// No description provided for @s17_title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get s17_title;

  /// No description provided for @s17_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Find anything in your vault'**
  String get s17_subtitle;

  /// No description provided for @s17_query.
  ///
  /// In en, this message translates to:
  /// **'insurance'**
  String get s17_query;

  /// No description provided for @filter_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get filter_notes;

  /// No description provided for @s17_top_result.
  ///
  /// In en, this message translates to:
  /// **'Top Result'**
  String get s17_top_result;

  /// No description provided for @s17_top_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s17_top_title;

  /// No description provided for @s17_top_location.
  ///
  /// In en, this message translates to:
  /// **'Finance › Insurance'**
  String get s17_top_location;

  /// No description provided for @s17_top_meta.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM  •  1.8 MB'**
  String get s17_top_meta;

  /// No description provided for @s17_other_results.
  ///
  /// In en, this message translates to:
  /// **'Other Results'**
  String get s17_other_results;

  /// No description provided for @s17_vehicle_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get s17_vehicle_title;

  /// No description provided for @s17_vehicle_meta.
  ///
  /// In en, this message translates to:
  /// **'Vehicle › Documents • 2 days ago'**
  String get s17_vehicle_meta;

  /// No description provided for @s17_health_title.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance Card'**
  String get s17_health_title;

  /// No description provided for @s17_health_meta.
  ///
  /// In en, this message translates to:
  /// **'Health › Cards • 5 days ago'**
  String get s17_health_meta;

  /// No description provided for @s17_claim_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Claim Form'**
  String get s17_claim_title;

  /// No description provided for @s17_claim_meta.
  ///
  /// In en, this message translates to:
  /// **'Finance › Forms • 12 Apr 2024'**
  String get s17_claim_meta;

  /// No description provided for @s17_receipts_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Receipts'**
  String get s17_receipts_title;

  /// No description provided for @s17_receipts_meta.
  ///
  /// In en, this message translates to:
  /// **'Finance › Receipts • 3 Apr 2024'**
  String get s17_receipts_meta;

  /// No description provided for @s17_not_found.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find what you\'re looking for?'**
  String get s17_not_found;

  /// No description provided for @s17_try_ai.
  ///
  /// In en, this message translates to:
  /// **'Try AI Search'**
  String get s17_try_ai;

  /// No description provided for @s18_title.
  ///
  /// In en, this message translates to:
  /// **'Global Search'**
  String get s18_title;

  /// No description provided for @s18_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Search documents, notes, tags and reminders'**
  String get s18_subtitle;

  /// No description provided for @s18_query.
  ///
  /// In en, this message translates to:
  /// **'passport'**
  String get s18_query;

  /// No description provided for @s18_search_everywhere.
  ///
  /// In en, this message translates to:
  /// **'Search Everywhere'**
  String get s18_search_everywhere;

  /// No description provided for @filter_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get filter_tags;

  /// No description provided for @filter_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get filter_reminders;

  /// No description provided for @s18_passport_title.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s18_passport_title;

  /// No description provided for @s18_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'Identity • 1.2 MB'**
  String get s18_passport_meta;

  /// No description provided for @s18_passport_copy_title.
  ///
  /// In en, this message translates to:
  /// **'Passport Copy.pdf'**
  String get s18_passport_copy_title;

  /// No description provided for @s18_passport_copy_meta.
  ///
  /// In en, this message translates to:
  /// **'Identity • 860 KB'**
  String get s18_passport_copy_meta;

  /// No description provided for @s18_note_title.
  ///
  /// In en, this message translates to:
  /// **'Passport renewal checklist'**
  String get s18_note_title;

  /// No description provided for @s18_note_meta.
  ///
  /// In en, this message translates to:
  /// **'Updated 2 days ago'**
  String get s18_note_meta;

  /// No description provided for @s18_tag_passport.
  ///
  /// In en, this message translates to:
  /// **'#passport'**
  String get s18_tag_passport;

  /// No description provided for @s18_tag_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'4 linked items'**
  String get s18_tag_passport_meta;

  /// No description provided for @s18_tag_identity.
  ///
  /// In en, this message translates to:
  /// **'#identity'**
  String get s18_tag_identity;

  /// No description provided for @s18_tag_identity_meta.
  ///
  /// In en, this message translates to:
  /// **'24 linked items'**
  String get s18_tag_identity_meta;

  /// No description provided for @s18_reminder_title.
  ///
  /// In en, this message translates to:
  /// **'Passport expires in 2028'**
  String get s18_reminder_title;

  /// No description provided for @s18_reminder_date.
  ///
  /// In en, this message translates to:
  /// **'15 Jun 2028'**
  String get s18_reminder_date;

  /// No description provided for @s19_title.
  ///
  /// In en, this message translates to:
  /// **'Filter & Sort'**
  String get s19_title;

  /// No description provided for @s19_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Refine your results'**
  String get s19_subtitle;

  /// No description provided for @s19_file_type.
  ///
  /// In en, this message translates to:
  /// **'File Type'**
  String get s19_file_type;

  /// No description provided for @filter_all_files.
  ///
  /// In en, this message translates to:
  /// **'All Files'**
  String get filter_all_files;

  /// No description provided for @s19_date_added.
  ///
  /// In en, this message translates to:
  /// **'Date Added'**
  String get s19_date_added;

  /// No description provided for @filter_any_time.
  ///
  /// In en, this message translates to:
  /// **'Any Time'**
  String get filter_any_time;

  /// No description provided for @filter_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get filter_today;

  /// No description provided for @filter_this_week.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get filter_this_week;

  /// No description provided for @filter_this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get filter_this_month;

  /// No description provided for @s19_sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get s19_sort_by;

  /// No description provided for @sort_newest.
  ///
  /// In en, this message translates to:
  /// **'Newest First'**
  String get sort_newest;

  /// No description provided for @sort_oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest First'**
  String get sort_oldest;

  /// No description provided for @sort_name_az.
  ///
  /// In en, this message translates to:
  /// **'Name A–Z'**
  String get sort_name_az;

  /// No description provided for @sort_name_za.
  ///
  /// In en, this message translates to:
  /// **'Name Z–A'**
  String get sort_name_za;

  /// No description provided for @sort_largest.
  ///
  /// In en, this message translates to:
  /// **'Largest First'**
  String get sort_largest;

  /// No description provided for @sort_smallest.
  ///
  /// In en, this message translates to:
  /// **'Smallest First'**
  String get sort_smallest;

  /// No description provided for @s19_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get s19_apply;

  /// No description provided for @s19_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset all filters'**
  String get s19_reset;

  /// No description provided for @s20_profile_name.
  ///
  /// In en, this message translates to:
  /// **'Arjun Sharma'**
  String get s20_profile_name;

  /// No description provided for @s20_vault_name.
  ///
  /// In en, this message translates to:
  /// **'My Personal Vault'**
  String get s20_vault_name;

  /// No description provided for @s20_vault_summary.
  ///
  /// In en, this message translates to:
  /// **'128 items • 2.4 GB'**
  String get s20_vault_summary;

  /// No description provided for @s20_navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get s20_navigation;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_home_body.
  ///
  /// In en, this message translates to:
  /// **'Your dashboard'**
  String get nav_home_body;

  /// No description provided for @nav_collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get nav_collections;

  /// No description provided for @nav_collections_body.
  ///
  /// In en, this message translates to:
  /// **'Browse organized items'**
  String get nav_collections_body;

  /// No description provided for @nav_ai.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get nav_ai;

  /// No description provided for @nav_ai_body.
  ///
  /// In en, this message translates to:
  /// **'Private on-device assistant'**
  String get nav_ai_body;

  /// No description provided for @nav_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get nav_reminders;

  /// No description provided for @nav_reminders_body.
  ///
  /// In en, this message translates to:
  /// **'Important dates and expiries'**
  String get nav_reminders_body;

  /// No description provided for @nav_activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get nav_activity;

  /// No description provided for @nav_activity_body.
  ///
  /// In en, this message translates to:
  /// **'Recent changes'**
  String get nav_activity_body;

  /// No description provided for @nav_backup.
  ///
  /// In en, this message translates to:
  /// **'Backup & Export'**
  String get nav_backup;

  /// No description provided for @nav_backup_body.
  ///
  /// In en, this message translates to:
  /// **'Create encrypted backups'**
  String get nav_backup_body;

  /// No description provided for @nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// No description provided for @nav_settings_body.
  ///
  /// In en, this message translates to:
  /// **'Security and preferences'**
  String get nav_settings_body;

  /// No description provided for @nav_help.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get nav_help;

  /// No description provided for @nav_help_body.
  ///
  /// In en, this message translates to:
  /// **'Guides and troubleshooting'**
  String get nav_help_body;

  /// No description provided for @nav_lock.
  ///
  /// In en, this message translates to:
  /// **'Lock Vault'**
  String get nav_lock;

  /// No description provided for @nav_lock_body.
  ///
  /// In en, this message translates to:
  /// **'Lock immediately'**
  String get nav_lock_body;

  /// No description provided for @s41_title.
  ///
  /// In en, this message translates to:
  /// **'Import & Export'**
  String get s41_title;

  /// No description provided for @s41_import_section.
  ///
  /// In en, this message translates to:
  /// **'Import Into OwnKeep'**
  String get s41_import_section;

  /// No description provided for @s41_import_files.
  ///
  /// In en, this message translates to:
  /// **'Import from Files'**
  String get s41_import_files;

  /// No description provided for @s41_import_files_body.
  ///
  /// In en, this message translates to:
  /// **'From your device storage'**
  String get s41_import_files_body;

  /// No description provided for @s41_import_gallery.
  ///
  /// In en, this message translates to:
  /// **'Import from Gallery'**
  String get s41_import_gallery;

  /// No description provided for @s41_import_gallery_body.
  ///
  /// In en, this message translates to:
  /// **'Photos and videos'**
  String get s41_import_gallery_body;

  /// No description provided for @s41_import_cloud.
  ///
  /// In en, this message translates to:
  /// **'Import from Cloud'**
  String get s41_import_cloud;

  /// No description provided for @s41_import_cloud_body.
  ///
  /// In en, this message translates to:
  /// **'Google Drive, Dropbox (Download first)'**
  String get s41_import_cloud_body;

  /// No description provided for @s41_import_computer.
  ///
  /// In en, this message translates to:
  /// **'Import from Computer'**
  String get s41_import_computer;

  /// No description provided for @s41_import_computer_body.
  ///
  /// In en, this message translates to:
  /// **'Via USB or local network'**
  String get s41_import_computer_body;

  /// No description provided for @s41_export_section.
  ///
  /// In en, this message translates to:
  /// **'Export From OwnKeep'**
  String get s41_export_section;

  /// No description provided for @s41_export_backup.
  ///
  /// In en, this message translates to:
  /// **'Export Vault Backup'**
  String get s41_export_backup;

  /// No description provided for @s41_export_backup_body.
  ///
  /// In en, this message translates to:
  /// **'Create .cvault backup file'**
  String get s41_export_backup_body;

  /// No description provided for @s41_export_documents.
  ///
  /// In en, this message translates to:
  /// **'Export Documents'**
  String get s41_export_documents;

  /// No description provided for @s41_export_documents_body.
  ///
  /// In en, this message translates to:
  /// **'As PDF or original files'**
  String get s41_export_documents_body;

  /// No description provided for @s41_export_media.
  ///
  /// In en, this message translates to:
  /// **'Export Photos & Videos'**
  String get s41_export_media;

  /// No description provided for @s41_export_media_body.
  ///
  /// In en, this message translates to:
  /// **'As original files'**
  String get s41_export_media_body;

  /// No description provided for @s41_export_report.
  ///
  /// In en, this message translates to:
  /// **'Export Report'**
  String get s41_export_report;

  /// No description provided for @s41_export_report_body.
  ///
  /// In en, this message translates to:
  /// **'Inventory and summary report'**
  String get s41_export_report_body;

  /// No description provided for @s41_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Keep regular backups of your vault in multiple locations.'**
  String get s41_tip;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;

  /// No description provided for @s42_title.
  ///
  /// In en, this message translates to:
  /// **'Data Usage'**
  String get s42_title;

  /// No description provided for @s42_vault_storage.
  ///
  /// In en, this message translates to:
  /// **'Vault Storage'**
  String get s42_vault_storage;

  /// No description provided for @s42_total.
  ///
  /// In en, this message translates to:
  /// **'128 GB'**
  String get s42_total;

  /// No description provided for @s42_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s42_documents;

  /// No description provided for @s42_documents_size.
  ///
  /// In en, this message translates to:
  /// **'48.5 GB'**
  String get s42_documents_size;

  /// No description provided for @s42_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get s42_images;

  /// No description provided for @s42_images_size.
  ///
  /// In en, this message translates to:
  /// **'32.4 GB'**
  String get s42_images_size;

  /// No description provided for @s42_videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get s42_videos;

  /// No description provided for @s42_videos_size.
  ///
  /// In en, this message translates to:
  /// **'22.1 GB'**
  String get s42_videos_size;

  /// No description provided for @s42_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get s42_others;

  /// No description provided for @s42_others_size.
  ///
  /// In en, this message translates to:
  /// **'25.0 GB'**
  String get s42_others_size;

  /// No description provided for @s42_used.
  ///
  /// In en, this message translates to:
  /// **'Used: 103 GB'**
  String get s42_used;

  /// No description provided for @s42_free.
  ///
  /// In en, this message translates to:
  /// **'Free: 25 GB'**
  String get s42_free;

  /// No description provided for @s42_storage_type.
  ///
  /// In en, this message translates to:
  /// **'Storage by Type'**
  String get s42_storage_type;

  /// No description provided for @s42_documents_percent.
  ///
  /// In en, this message translates to:
  /// **'38%'**
  String get s42_documents_percent;

  /// No description provided for @s42_images_percent.
  ///
  /// In en, this message translates to:
  /// **'25%'**
  String get s42_images_percent;

  /// No description provided for @s42_videos_percent.
  ///
  /// In en, this message translates to:
  /// **'17%'**
  String get s42_videos_percent;

  /// No description provided for @s42_others_percent.
  ///
  /// In en, this message translates to:
  /// **'20%'**
  String get s42_others_percent;

  /// No description provided for @s42_large_files.
  ///
  /// In en, this message translates to:
  /// **'Large Files'**
  String get s42_large_files;

  /// No description provided for @common_see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get common_see_all;

  /// No description provided for @s42_video_file.
  ///
  /// In en, this message translates to:
  /// **'Vacation Video.mp4'**
  String get s42_video_file;

  /// No description provided for @s42_video_file_size.
  ///
  /// In en, this message translates to:
  /// **'2.4 GB'**
  String get s42_video_file_size;

  /// No description provided for @s42_project_file.
  ///
  /// In en, this message translates to:
  /// **'Project Files.zip'**
  String get s42_project_file;

  /// No description provided for @s42_project_file_size.
  ///
  /// In en, this message translates to:
  /// **'1.2 GB'**
  String get s42_project_file_size;

  /// No description provided for @s42_raw_file.
  ///
  /// In en, this message translates to:
  /// **'Family Photos RAW.dng'**
  String get s42_raw_file;

  /// No description provided for @s42_raw_file_size.
  ///
  /// In en, this message translates to:
  /// **'1.0 GB'**
  String get s42_raw_file_size;

  /// No description provided for @s42_optimization.
  ///
  /// In en, this message translates to:
  /// **'Storage Optimization'**
  String get s42_optimization;

  /// No description provided for @s42_duplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Files'**
  String get s42_duplicates;

  /// No description provided for @s42_duplicates_size.
  ///
  /// In en, this message translates to:
  /// **'2.48 GB'**
  String get s42_duplicates_size;

  /// No description provided for @s42_unneeded.
  ///
  /// In en, this message translates to:
  /// **'Unneeded Files'**
  String get s42_unneeded;

  /// No description provided for @s42_unneeded_size.
  ///
  /// In en, this message translates to:
  /// **'1.13 GB'**
  String get s42_unneeded_size;

  /// No description provided for @s43_title.
  ///
  /// In en, this message translates to:
  /// **'About OwnKeep'**
  String get s43_title;

  /// No description provided for @s43_app_name.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep'**
  String get s43_app_name;

  /// No description provided for @s43_tagline.
  ///
  /// In en, this message translates to:
  /// **'Keep What Matters. Own Your Data.'**
  String get s43_tagline;

  /// No description provided for @s43_version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.3.0'**
  String get s43_version;

  /// No description provided for @s43_whats_new.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get s43_whats_new;

  /// No description provided for @s43_whats_new_body.
  ///
  /// In en, this message translates to:
  /// **'See what\'s new in this version'**
  String get s43_whats_new_body;

  /// No description provided for @s43_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy First'**
  String get s43_privacy;

  /// No description provided for @s43_privacy_body.
  ///
  /// In en, this message translates to:
  /// **'100% offline. Your data stays on your device.'**
  String get s43_privacy_body;

  /// No description provided for @s43_legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get s43_legal;

  /// No description provided for @s43_legal_body.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use, Privacy Policy and Licenses'**
  String get s43_legal_body;

  /// No description provided for @s43_acknowledgements.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgements'**
  String get s43_acknowledgements;

  /// No description provided for @s43_acknowledgements_body.
  ///
  /// In en, this message translates to:
  /// **'Open source libraries and credits'**
  String get s43_acknowledgements_body;

  /// No description provided for @s43_website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get s43_website;

  /// No description provided for @s43_website_value.
  ///
  /// In en, this message translates to:
  /// **'www.ownkeep.app'**
  String get s43_website_value;

  /// No description provided for @s43_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get s43_contact;

  /// No description provided for @s43_contact_value.
  ///
  /// In en, this message translates to:
  /// **'support@ownkeep.app'**
  String get s43_contact_value;

  /// No description provided for @s43_copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 OwnKeep'**
  String get s43_copyright;

  /// No description provided for @s43_rights.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get s43_rights;

  /// No description provided for @s44_title.
  ///
  /// In en, this message translates to:
  /// **'Tutorials'**
  String get s44_title;

  /// No description provided for @s44_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search tutorials...'**
  String get s44_search_hint;

  /// No description provided for @s44_getting_started.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get s44_getting_started;

  /// No description provided for @s44_tutorial_01.
  ///
  /// In en, this message translates to:
  /// **'01. Welcome to OwnKeep'**
  String get s44_tutorial_01;

  /// No description provided for @s44_tutorial_01_body.
  ///
  /// In en, this message translates to:
  /// **'Overview and key features'**
  String get s44_tutorial_01_body;

  /// No description provided for @s44_tutorial_01_duration.
  ///
  /// In en, this message translates to:
  /// **'2:45'**
  String get s44_tutorial_01_duration;

  /// No description provided for @s44_tutorial_02.
  ///
  /// In en, this message translates to:
  /// **'02. Create Your First Vault'**
  String get s44_tutorial_02;

  /// No description provided for @s44_tutorial_02_body.
  ///
  /// In en, this message translates to:
  /// **'Secure your data in minutes'**
  String get s44_tutorial_02_body;

  /// No description provided for @s44_tutorial_02_duration.
  ///
  /// In en, this message translates to:
  /// **'4:12'**
  String get s44_tutorial_02_duration;

  /// No description provided for @s44_tutorial_03.
  ///
  /// In en, this message translates to:
  /// **'03. Add Documents & Photos'**
  String get s44_tutorial_03;

  /// No description provided for @s44_tutorial_03_body.
  ///
  /// In en, this message translates to:
  /// **'Import and organize your files'**
  String get s44_tutorial_03_body;

  /// No description provided for @s44_tutorial_03_duration.
  ///
  /// In en, this message translates to:
  /// **'3:38'**
  String get s44_tutorial_03_duration;

  /// No description provided for @s44_tutorial_04.
  ///
  /// In en, this message translates to:
  /// **'04. Set Reminders'**
  String get s44_tutorial_04;

  /// No description provided for @s44_tutorial_04_body.
  ///
  /// In en, this message translates to:
  /// **'Never miss important things'**
  String get s44_tutorial_04_body;

  /// No description provided for @s44_tutorial_04_duration.
  ///
  /// In en, this message translates to:
  /// **'3:05'**
  String get s44_tutorial_04_duration;

  /// No description provided for @s44_manage_vault.
  ///
  /// In en, this message translates to:
  /// **'Manage Your Vault'**
  String get s44_manage_vault;

  /// No description provided for @s44_tutorial_05.
  ///
  /// In en, this message translates to:
  /// **'05. Tags and Collections'**
  String get s44_tutorial_05;

  /// No description provided for @s44_tutorial_05_body.
  ///
  /// In en, this message translates to:
  /// **'Organize with ease'**
  String get s44_tutorial_05_body;

  /// No description provided for @s44_tutorial_05_duration.
  ///
  /// In en, this message translates to:
  /// **'2:50'**
  String get s44_tutorial_05_duration;

  /// No description provided for @s44_tutorial_06.
  ///
  /// In en, this message translates to:
  /// **'06. Backup Your Vault'**
  String get s44_tutorial_06;

  /// No description provided for @s44_tutorial_06_body.
  ///
  /// In en, this message translates to:
  /// **'Keep your data safe'**
  String get s44_tutorial_06_body;

  /// No description provided for @s44_tutorial_06_duration.
  ///
  /// In en, this message translates to:
  /// **'3:20'**
  String get s44_tutorial_06_duration;

  /// No description provided for @s44_tutorial_07.
  ///
  /// In en, this message translates to:
  /// **'07. Export and Share'**
  String get s44_tutorial_07;

  /// No description provided for @s44_tutorial_07_body.
  ///
  /// In en, this message translates to:
  /// **'Share securely'**
  String get s44_tutorial_07_body;

  /// No description provided for @s44_tutorial_07_duration.
  ///
  /// In en, this message translates to:
  /// **'2:35'**
  String get s44_tutorial_07_duration;

  /// No description provided for @s44_advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get s44_advanced;

  /// No description provided for @s44_tutorial_08.
  ///
  /// In en, this message translates to:
  /// **'08. Security Features'**
  String get s44_tutorial_08;

  /// No description provided for @s44_tutorial_08_body.
  ///
  /// In en, this message translates to:
  /// **'All about encryption & more'**
  String get s44_tutorial_08_body;

  /// No description provided for @s44_tutorial_08_duration.
  ///
  /// In en, this message translates to:
  /// **'4:18'**
  String get s44_tutorial_08_duration;

  /// No description provided for @s45_title.
  ///
  /// In en, this message translates to:
  /// **'Rate OwnKeep'**
  String get s45_title;

  /// No description provided for @s45_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Enjoying OwnKeep?'**
  String get s45_hero_title;

  /// No description provided for @s45_hero_body.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps us build a better app for you.'**
  String get s45_hero_body;

  /// No description provided for @s45_rate_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap a star to rate'**
  String get s45_rate_hint;

  /// No description provided for @s45_comment_hint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you love about OwnKeep...'**
  String get s45_comment_hint;

  /// No description provided for @s45_optional.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get s45_optional;

  /// No description provided for @s45_counter.
  ///
  /// In en, this message translates to:
  /// **'0/500'**
  String get s45_counter;

  /// No description provided for @s45_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get s45_submit;

  /// No description provided for @s45_share.
  ///
  /// In en, this message translates to:
  /// **'Share OwnKeep'**
  String get s45_share;

  /// No description provided for @s45_share_body.
  ///
  /// In en, this message translates to:
  /// **'Recommend to your friends'**
  String get s45_share_body;

  /// No description provided for @s45_feedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get s45_feedback;

  /// No description provided for @s45_feedback_body.
  ///
  /// In en, this message translates to:
  /// **'We\'d love to hear from you'**
  String get s45_feedback_body;

  /// No description provided for @s46_title.
  ///
  /// In en, this message translates to:
  /// **'Wipe Data'**
  String get s46_title;

  /// No description provided for @s46_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently erase this vault'**
  String get s46_subtitle;

  /// No description provided for @s46_warning_title.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get s46_warning_title;

  /// No description provided for @s46_warning_body.
  ///
  /// In en, this message translates to:
  /// **'All documents, notes, reminders, tags, recovery settings and encryption keys in this vault will be permanently removed from this device.'**
  String get s46_warning_body;

  /// No description provided for @s46_before.
  ///
  /// In en, this message translates to:
  /// **'Before continuing'**
  String get s46_before;

  /// No description provided for @s46_backup_check.
  ///
  /// In en, this message translates to:
  /// **'I have created an encrypted backup'**
  String get s46_backup_check;

  /// No description provided for @s46_recovery_check.
  ///
  /// In en, this message translates to:
  /// **'I understand recovery will be impossible'**
  String get s46_recovery_check;

  /// No description provided for @s46_device_check.
  ///
  /// In en, this message translates to:
  /// **'I want to erase this vault from this device'**
  String get s46_device_check;

  /// No description provided for @s46_confirm_hint.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm'**
  String get s46_confirm_hint;

  /// No description provided for @s46_delete.
  ///
  /// In en, this message translates to:
  /// **'Permanently Delete Vault'**
  String get s46_delete;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @s47_title.
  ///
  /// In en, this message translates to:
  /// **'Data Check'**
  String get s47_title;

  /// No description provided for @s47_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify vault integrity'**
  String get s47_subtitle;

  /// No description provided for @s47_status.
  ///
  /// In en, this message translates to:
  /// **'Everything looks good'**
  String get s47_status;

  /// No description provided for @s47_last_checked.
  ///
  /// In en, this message translates to:
  /// **'Last checked today at 9:20 AM'**
  String get s47_last_checked;

  /// No description provided for @s47_items_value.
  ///
  /// In en, this message translates to:
  /// **'248'**
  String get s47_items_value;

  /// No description provided for @s47_items_label.
  ///
  /// In en, this message translates to:
  /// **'Items checked'**
  String get s47_items_label;

  /// No description provided for @s47_corrupt_value.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get s47_corrupt_value;

  /// No description provided for @s47_corrupt_label.
  ///
  /// In en, this message translates to:
  /// **'Corrupt files'**
  String get s47_corrupt_label;

  /// No description provided for @s47_missing_value.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get s47_missing_value;

  /// No description provided for @s47_missing_label.
  ///
  /// In en, this message translates to:
  /// **'Missing files'**
  String get s47_missing_label;

  /// No description provided for @s47_integrity_value.
  ///
  /// In en, this message translates to:
  /// **'100%'**
  String get s47_integrity_value;

  /// No description provided for @s47_integrity_label.
  ///
  /// In en, this message translates to:
  /// **'Integrity'**
  String get s47_integrity_label;

  /// No description provided for @s47_checks.
  ///
  /// In en, this message translates to:
  /// **'Checks Performed'**
  String get s47_checks;

  /// No description provided for @s47_file_integrity.
  ///
  /// In en, this message translates to:
  /// **'File integrity'**
  String get s47_file_integrity;

  /// No description provided for @s47_file_integrity_body.
  ///
  /// In en, this message translates to:
  /// **'All file hashes match'**
  String get s47_file_integrity_body;

  /// No description provided for @s47_manifests.
  ///
  /// In en, this message translates to:
  /// **'Encrypted manifests'**
  String get s47_manifests;

  /// No description provided for @s47_manifests_body.
  ///
  /// In en, this message translates to:
  /// **'Valid and readable'**
  String get s47_manifests_body;

  /// No description provided for @s47_document_index.
  ///
  /// In en, this message translates to:
  /// **'Document index'**
  String get s47_document_index;

  /// No description provided for @s47_document_index_body.
  ///
  /// In en, this message translates to:
  /// **'No missing entries'**
  String get s47_document_index_body;

  /// No description provided for @s47_recovery_metadata.
  ///
  /// In en, this message translates to:
  /// **'Recovery metadata'**
  String get s47_recovery_metadata;

  /// No description provided for @s47_recovery_metadata_body.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s47_recovery_metadata_body;

  /// No description provided for @s47_storage_consistency.
  ///
  /// In en, this message translates to:
  /// **'Storage consistency'**
  String get s47_storage_consistency;

  /// No description provided for @s47_storage_consistency_body.
  ///
  /// In en, this message translates to:
  /// **'No orphaned files'**
  String get s47_storage_consistency_body;

  /// No description provided for @s47_run_again.
  ///
  /// In en, this message translates to:
  /// **'Run Data Check Again'**
  String get s47_run_again;

  /// No description provided for @s48_title.
  ///
  /// In en, this message translates to:
  /// **'File Details'**
  String get s48_title;

  /// No description provided for @s48_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s48_subtitle;

  /// No description provided for @s48_preview_title.
  ///
  /// In en, this message translates to:
  /// **'PASSPORT'**
  String get s48_preview_title;

  /// No description provided for @s48_preview_body.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get s48_preview_body;

  /// No description provided for @s48_general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get s48_general;

  /// No description provided for @s48_file_name_label.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get s48_file_name_label;

  /// No description provided for @s48_file_name.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s48_file_name;

  /// No description provided for @s48_type_label.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get s48_type_label;

  /// No description provided for @s48_type.
  ///
  /// In en, this message translates to:
  /// **'PDF document'**
  String get s48_type;

  /// No description provided for @s48_size_label.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get s48_size_label;

  /// No description provided for @s48_size.
  ///
  /// In en, this message translates to:
  /// **'1.2 MB'**
  String get s48_size;

  /// No description provided for @s48_added_label.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get s48_added_label;

  /// No description provided for @s48_added.
  ///
  /// In en, this message translates to:
  /// **'10 May 2025, 10:30 AM'**
  String get s48_added;

  /// No description provided for @s48_modified_label.
  ///
  /// In en, this message translates to:
  /// **'Modified'**
  String get s48_modified_label;

  /// No description provided for @s48_modified.
  ///
  /// In en, this message translates to:
  /// **'10 May 2025, 10:31 AM'**
  String get s48_modified;

  /// No description provided for @s48_location_label.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get s48_location_label;

  /// No description provided for @s48_location.
  ///
  /// In en, this message translates to:
  /// **'Personal › Identity'**
  String get s48_location;

  /// No description provided for @s48_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get s48_security;

  /// No description provided for @s48_encryption_label.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get s48_encryption_label;

  /// No description provided for @s48_encryption.
  ///
  /// In en, this message translates to:
  /// **'AES-256-GCM'**
  String get s48_encryption;

  /// No description provided for @s48_integrity_label.
  ///
  /// In en, this message translates to:
  /// **'Integrity'**
  String get s48_integrity_label;

  /// No description provided for @s48_integrity.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s48_integrity;

  /// No description provided for @s48_local_id_label.
  ///
  /// In en, this message translates to:
  /// **'Local file ID'**
  String get s48_local_id_label;

  /// No description provided for @s48_local_id.
  ///
  /// In en, this message translates to:
  /// **'7FA2-91C8-48D2'**
  String get s48_local_id;

  /// No description provided for @s48_open.
  ///
  /// In en, this message translates to:
  /// **'Open Document'**
  String get s48_open;

  /// No description provided for @s49_title.
  ///
  /// In en, this message translates to:
  /// **'Version History'**
  String get s49_title;

  /// No description provided for @s49_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s49_subtitle;

  /// No description provided for @s49_current.
  ///
  /// In en, this message translates to:
  /// **'Current version'**
  String get s49_current;

  /// No description provided for @s49_version_4.
  ///
  /// In en, this message translates to:
  /// **'Version 4'**
  String get s49_version_4;

  /// No description provided for @s49_version_4_time.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:31 AM'**
  String get s49_version_4_time;

  /// No description provided for @s49_previous.
  ///
  /// In en, this message translates to:
  /// **'Previous Versions'**
  String get s49_previous;

  /// No description provided for @s49_version_3.
  ///
  /// In en, this message translates to:
  /// **'Version 3'**
  String get s49_version_3;

  /// No description provided for @s49_version_3_body.
  ///
  /// In en, this message translates to:
  /// **'Metadata updated'**
  String get s49_version_3_body;

  /// No description provided for @s49_version_3_time.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM'**
  String get s49_version_3_time;

  /// No description provided for @s49_version_2.
  ///
  /// In en, this message translates to:
  /// **'Version 2'**
  String get s49_version_2;

  /// No description provided for @s49_version_2_body.
  ///
  /// In en, this message translates to:
  /// **'Tags changed'**
  String get s49_version_2_body;

  /// No description provided for @s49_version_2_time.
  ///
  /// In en, this message translates to:
  /// **'9 May 2025, 4:20 PM'**
  String get s49_version_2_time;

  /// No description provided for @s49_version_1.
  ///
  /// In en, this message translates to:
  /// **'Version 1'**
  String get s49_version_1;

  /// No description provided for @s49_version_1_body.
  ///
  /// In en, this message translates to:
  /// **'Original document added'**
  String get s49_version_1_body;

  /// No description provided for @s49_version_1_time.
  ///
  /// In en, this message translates to:
  /// **'8 May 2025, 2:15 PM'**
  String get s49_version_1_time;

  /// No description provided for @common_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get common_restore;

  /// No description provided for @s49_storage.
  ///
  /// In en, this message translates to:
  /// **'Version storage'**
  String get s49_storage;

  /// No description provided for @s49_storage_value.
  ///
  /// In en, this message translates to:
  /// **'3 previous versions • 4.8 MB'**
  String get s49_storage_value;

  /// No description provided for @s49_how.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get s49_how;

  /// No description provided for @s49_how_body.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep stores local encrypted snapshots when you edit metadata or replace a file. Versions never leave your device and can be removed at any time.'**
  String get s49_how_body;

  /// No description provided for @s49_delete_old.
  ///
  /// In en, this message translates to:
  /// **'Delete Old Versions'**
  String get s49_delete_old;

  /// No description provided for @s50_title.
  ///
  /// In en, this message translates to:
  /// **'Move or Copy'**
  String get s50_title;

  /// No description provided for @s50_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose destination'**
  String get s50_subtitle;

  /// No description provided for @s50_selected.
  ///
  /// In en, this message translates to:
  /// **'Selected item'**
  String get s50_selected;

  /// No description provided for @s50_file_name.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s50_file_name;

  /// No description provided for @s50_file_size.
  ///
  /// In en, this message translates to:
  /// **'1.2 MB'**
  String get s50_file_size;

  /// No description provided for @s50_destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get s50_destination;

  /// No description provided for @s50_personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get s50_personal;

  /// No description provided for @s50_personal_count.
  ///
  /// In en, this message translates to:
  /// **'28 items'**
  String get s50_personal_count;

  /// No description provided for @s50_finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get s50_finance;

  /// No description provided for @s50_finance_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s50_finance_count;

  /// No description provided for @s50_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get s50_health;

  /// No description provided for @s50_health_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s50_health_count;

  /// No description provided for @s50_property.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get s50_property;

  /// No description provided for @s50_property_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s50_property_count;

  /// No description provided for @s50_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get s50_vehicle;

  /// No description provided for @s50_vehicle_count.
  ///
  /// In en, this message translates to:
  /// **'8 items'**
  String get s50_vehicle_count;

  /// No description provided for @s50_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s50_education;

  /// No description provided for @s50_education_count.
  ///
  /// In en, this message translates to:
  /// **'6 items'**
  String get s50_education_count;

  /// No description provided for @s50_new_folder.
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get s50_new_folder;

  /// No description provided for @s50_new_folder_body.
  ///
  /// In en, this message translates to:
  /// **'Create a new destination'**
  String get s50_new_folder_body;

  /// No description provided for @common_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get common_copy;

  /// No description provided for @common_move.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get common_move;

  /// No description provided for @s50_keep_original.
  ///
  /// In en, this message translates to:
  /// **'Keep original location'**
  String get s50_keep_original;

  /// No description provided for @s21_title.
  ///
  /// In en, this message translates to:
  /// **'Share & Export'**
  String get s21_title;

  /// No description provided for @s21_share_securely.
  ///
  /// In en, this message translates to:
  /// **'Share Securely'**
  String get s21_share_securely;

  /// No description provided for @s21_share_securely_body.
  ///
  /// In en, this message translates to:
  /// **'Your data stays encrypted. You\'re in control.'**
  String get s21_share_securely_body;

  /// No description provided for @s21_ownkeep_user.
  ///
  /// In en, this message translates to:
  /// **'Share with OwnKeep User'**
  String get s21_ownkeep_user;

  /// No description provided for @s21_ownkeep_user_body.
  ///
  /// In en, this message translates to:
  /// **'Share vault items with another OwnKeep user via encrypted link'**
  String get s21_ownkeep_user_body;

  /// No description provided for @s21_secure_link.
  ///
  /// In en, this message translates to:
  /// **'Generate Secure Link'**
  String get s21_secure_link;

  /// No description provided for @s21_secure_link_body.
  ///
  /// In en, this message translates to:
  /// **'Create a time-limited encrypted link to share'**
  String get s21_secure_link_body;

  /// No description provided for @s21_encrypted_file.
  ///
  /// In en, this message translates to:
  /// **'Export Encrypted File'**
  String get s21_encrypted_file;

  /// No description provided for @s21_encrypted_file_body.
  ///
  /// In en, this message translates to:
  /// **'Export as encrypted .cvault file to share via any medium'**
  String get s21_encrypted_file_body;

  /// No description provided for @s21_export_pdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get s21_export_pdf;

  /// No description provided for @s21_export_pdf_body.
  ///
  /// In en, this message translates to:
  /// **'Export documents as PDF files'**
  String get s21_export_pdf_body;

  /// No description provided for @s21_export_zip.
  ///
  /// In en, this message translates to:
  /// **'Export as ZIP'**
  String get s21_export_zip;

  /// No description provided for @s21_export_zip_body.
  ///
  /// In en, this message translates to:
  /// **'Export original files in ZIP (Encrypted)'**
  String get s21_export_zip_body;

  /// No description provided for @s21_security_note.
  ///
  /// In en, this message translates to:
  /// **'Shared items can only be opened in OwnKeep and cannot be accessed by anyone else.'**
  String get s21_security_note;

  /// No description provided for @s22_title.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get s22_title;

  /// No description provided for @common_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get common_all;

  /// No description provided for @common_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get common_documents;

  /// No description provided for @common_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get common_images;

  /// No description provided for @common_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get common_others;

  /// No description provided for @s22_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s22_passport;

  /// No description provided for @s22_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  1.2 MB'**
  String get s22_passport_meta;

  /// No description provided for @s22_passport_date.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM'**
  String get s22_passport_date;

  /// No description provided for @s22_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s22_insurance;

  /// No description provided for @s22_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  2.4 MB'**
  String get s22_insurance_meta;

  /// No description provided for @s22_family_photo.
  ///
  /// In en, this message translates to:
  /// **'Family Photo'**
  String get s22_family_photo;

  /// No description provided for @s22_family_photo_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG  •  3.6 MB'**
  String get s22_family_photo_meta;

  /// No description provided for @s22_family_photo_date.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get s22_family_photo_date;

  /// No description provided for @s22_aadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get s22_aadhaar;

  /// No description provided for @s22_aadhaar_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  1.1 MB'**
  String get s22_aadhaar_meta;

  /// No description provided for @s22_aadhaar_date.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get s22_aadhaar_date;

  /// No description provided for @s22_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get s22_licence;

  /// No description provided for @s22_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  1.0 MB'**
  String get s22_licence_meta;

  /// No description provided for @s22_licence_date.
  ///
  /// In en, this message translates to:
  /// **'5 days ago'**
  String get s22_licence_date;

  /// No description provided for @s22_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement'**
  String get s22_bank;

  /// No description provided for @s22_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  3.2 MB'**
  String get s22_bank_meta;

  /// No description provided for @s22_bank_date.
  ///
  /// In en, this message translates to:
  /// **'7 days ago'**
  String get s22_bank_date;

  /// No description provided for @s22_itr.
  ///
  /// In en, this message translates to:
  /// **'Income Tax Return 2024'**
  String get s22_itr;

  /// No description provided for @s22_itr_meta.
  ///
  /// In en, this message translates to:
  /// **'XLSX  •  540 KB'**
  String get s22_itr_meta;

  /// No description provided for @s22_itr_date.
  ///
  /// In en, this message translates to:
  /// **'10 May 2025'**
  String get s22_itr_date;

  /// No description provided for @s22_property.
  ///
  /// In en, this message translates to:
  /// **'Property Papers'**
  String get s22_property;

  /// No description provided for @s22_property_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  4.8 MB'**
  String get s22_property_meta;

  /// No description provided for @s22_property_date.
  ///
  /// In en, this message translates to:
  /// **'8 May 2025'**
  String get s22_property_date;

  /// No description provided for @s23_title.
  ///
  /// In en, this message translates to:
  /// **'Recently Deleted'**
  String get s23_title;

  /// No description provided for @s23_select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get s23_select;

  /// No description provided for @s23_trash_notice.
  ///
  /// In en, this message translates to:
  /// **'Items in trash are stored locally'**
  String get s23_trash_notice;

  /// No description provided for @s23_trash_notice_body.
  ///
  /// In en, this message translates to:
  /// **'You can restore or permanently delete them.'**
  String get s23_trash_notice_body;

  /// No description provided for @s23_item_count.
  ///
  /// In en, this message translates to:
  /// **'30 items'**
  String get s23_item_count;

  /// No description provided for @s23_sort.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get s23_sort;

  /// No description provided for @s23_old_insurance.
  ///
  /// In en, this message translates to:
  /// **'Old Insurance Policy'**
  String get s23_old_insurance;

  /// No description provided for @s23_old_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  1.8 MB'**
  String get s23_old_insurance_meta;

  /// No description provided for @s23_old_insurance_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted 1 hour ago'**
  String get s23_old_insurance_date;

  /// No description provided for @s23_screenshot.
  ///
  /// In en, this message translates to:
  /// **'Screenshot_2025...'**
  String get s23_screenshot;

  /// No description provided for @s23_screenshot_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG  •  1.2 MB'**
  String get s23_screenshot_meta;

  /// No description provided for @s23_screenshot_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted 3 hours ago'**
  String get s23_screenshot_date;

  /// No description provided for @s23_bank.
  ///
  /// In en, this message translates to:
  /// **'Old Bank Statement'**
  String get s23_bank;

  /// No description provided for @s23_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  2.3 MB'**
  String get s23_bank_meta;

  /// No description provided for @s23_bank_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted Yesterday'**
  String get s23_bank_date;

  /// No description provided for @s23_image.
  ///
  /// In en, this message translates to:
  /// **'IMG_20240115_1205'**
  String get s23_image;

  /// No description provided for @s23_image_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG  •  3.7 MB'**
  String get s23_image_meta;

  /// No description provided for @s23_image_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted 2 days ago'**
  String get s23_image_date;

  /// No description provided for @s23_tax.
  ///
  /// In en, this message translates to:
  /// **'Tax Receipt 2023'**
  String get s23_tax;

  /// No description provided for @s23_tax_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF  •  1.1 MB'**
  String get s23_tax_meta;

  /// No description provided for @s23_tax_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted 5 days ago'**
  String get s23_tax_date;

  /// No description provided for @s23_project.
  ///
  /// In en, this message translates to:
  /// **'Project Plan.docx'**
  String get s23_project;

  /// No description provided for @s23_project_meta.
  ///
  /// In en, this message translates to:
  /// **'DOCX  •  520 KB'**
  String get s23_project_meta;

  /// No description provided for @s23_project_date.
  ///
  /// In en, this message translates to:
  /// **'Deleted 7 days ago'**
  String get s23_project_date;

  /// No description provided for @s23_empty_trash.
  ///
  /// In en, this message translates to:
  /// **'Empty Trash'**
  String get s23_empty_trash;

  /// No description provided for @s23_restore_all.
  ///
  /// In en, this message translates to:
  /// **'Restore All'**
  String get s23_restore_all;

  /// No description provided for @s24_title.
  ///
  /// In en, this message translates to:
  /// **'Storage Overview'**
  String get s24_title;

  /// No description provided for @s24_vault_storage.
  ///
  /// In en, this message translates to:
  /// **'Vault Storage'**
  String get s24_vault_storage;

  /// No description provided for @s24_total.
  ///
  /// In en, this message translates to:
  /// **'128 GB Total'**
  String get s24_total;

  /// No description provided for @s24_used_percent.
  ///
  /// In en, this message translates to:
  /// **'73%'**
  String get s24_used_percent;

  /// No description provided for @s24_used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get s24_used;

  /// No description provided for @s24_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s24_documents;

  /// No description provided for @s24_documents_size.
  ///
  /// In en, this message translates to:
  /// **'48.5 GB'**
  String get s24_documents_size;

  /// No description provided for @s24_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get s24_images;

  /// No description provided for @s24_images_size.
  ///
  /// In en, this message translates to:
  /// **'28.3 GB'**
  String get s24_images_size;

  /// No description provided for @s24_videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get s24_videos;

  /// No description provided for @s24_videos_size.
  ///
  /// In en, this message translates to:
  /// **'22.1 GB'**
  String get s24_videos_size;

  /// No description provided for @s24_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get s24_others;

  /// No description provided for @s24_others_size.
  ///
  /// In en, this message translates to:
  /// **'6.2 GB'**
  String get s24_others_size;

  /// No description provided for @s24_usage.
  ///
  /// In en, this message translates to:
  /// **'93.8 GB used of 128 GB'**
  String get s24_usage;

  /// No description provided for @s24_large_items.
  ///
  /// In en, this message translates to:
  /// **'Large Items'**
  String get s24_large_items;

  /// No description provided for @s24_video.
  ///
  /// In en, this message translates to:
  /// **'Vacation Video.mp4'**
  String get s24_video;

  /// No description provided for @s24_video_size.
  ///
  /// In en, this message translates to:
  /// **'2.4 GB'**
  String get s24_video_size;

  /// No description provided for @s24_raw_photo.
  ///
  /// In en, this message translates to:
  /// **'Family Photo RAW.dng'**
  String get s24_raw_photo;

  /// No description provided for @s24_raw_photo_size.
  ///
  /// In en, this message translates to:
  /// **'1.8 GB'**
  String get s24_raw_photo_size;

  /// No description provided for @s24_project_zip.
  ///
  /// In en, this message translates to:
  /// **'Project Files.zip'**
  String get s24_project_zip;

  /// No description provided for @s24_project_zip_size.
  ///
  /// In en, this message translates to:
  /// **'1.2 GB'**
  String get s24_project_zip_size;

  /// No description provided for @s24_cleanup.
  ///
  /// In en, this message translates to:
  /// **'Cleanup Suggestions'**
  String get s24_cleanup;

  /// No description provided for @s24_duplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Photos'**
  String get s24_duplicates;

  /// No description provided for @s24_duplicates_meta.
  ///
  /// In en, this message translates to:
  /// **'367 files  •  2.1 GB'**
  String get s24_duplicates_meta;

  /// No description provided for @s24_large_videos.
  ///
  /// In en, this message translates to:
  /// **'Large Videos'**
  String get s24_large_videos;

  /// No description provided for @s24_large_videos_meta.
  ///
  /// In en, this message translates to:
  /// **'12 files  •  9.8 GB'**
  String get s24_large_videos_meta;

  /// No description provided for @s24_unopened.
  ///
  /// In en, this message translates to:
  /// **'Unopened Documents'**
  String get s24_unopened;

  /// No description provided for @s24_unopened_meta.
  ///
  /// In en, this message translates to:
  /// **'23 files  •  1.3 GB'**
  String get s24_unopened_meta;

  /// No description provided for @s24_last_scan.
  ///
  /// In en, this message translates to:
  /// **'Last scanned: Today, 9:20 AM'**
  String get s24_last_scan;

  /// No description provided for @s24_scan_again.
  ///
  /// In en, this message translates to:
  /// **'Scan Again'**
  String get s24_scan_again;

  /// No description provided for @s25_title.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get s25_title;

  /// No description provided for @s25_create_new.
  ///
  /// In en, this message translates to:
  /// **'Create New'**
  String get s25_create_new;

  /// No description provided for @s25_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan Document'**
  String get s25_scan;

  /// No description provided for @s25_photo.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get s25_photo;

  /// No description provided for @s25_add_files.
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get s25_add_files;

  /// No description provided for @s25_voice.
  ///
  /// In en, this message translates to:
  /// **'Voice Note'**
  String get s25_voice;

  /// No description provided for @s25_note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get s25_note;

  /// No description provided for @s25_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get s25_contact;

  /// No description provided for @s25_import_from.
  ///
  /// In en, this message translates to:
  /// **'Import From'**
  String get s25_import_from;

  /// No description provided for @s25_gallery.
  ///
  /// In en, this message translates to:
  /// **'Import from Gallery'**
  String get s25_gallery;

  /// No description provided for @s25_files.
  ///
  /// In en, this message translates to:
  /// **'Import from Files'**
  String get s25_files;

  /// No description provided for @s25_cloud.
  ///
  /// In en, this message translates to:
  /// **'Import from Cloud'**
  String get s25_cloud;

  /// No description provided for @s25_cloud_note.
  ///
  /// In en, this message translates to:
  /// **'(Requires download first)'**
  String get s25_cloud_note;

  /// No description provided for @s25_create_folder.
  ///
  /// In en, this message translates to:
  /// **'Create New Folder'**
  String get s25_create_folder;

  /// No description provided for @s25_new_folder.
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get s25_new_folder;

  /// No description provided for @s25_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Keep your vault organized by adding items to collections.'**
  String get s25_tip;

  /// No description provided for @s26_title.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s26_title;

  /// No description provided for @s26_page.
  ///
  /// In en, this message translates to:
  /// **'1 / 2'**
  String get s26_page;

  /// No description provided for @s26_file.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s26_file;

  /// No description provided for @s26_type.
  ///
  /// In en, this message translates to:
  /// **'PDF Document • 1.2 MB'**
  String get s26_type;

  /// No description provided for @s26_added.
  ///
  /// In en, this message translates to:
  /// **'Added:  10 May 2025, 10:30 AM'**
  String get s26_added;

  /// No description provided for @s26_location.
  ///
  /// In en, this message translates to:
  /// **'Location:  Personal  ›  IDs'**
  String get s26_location;

  /// No description provided for @s26_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags:'**
  String get s26_tags;

  /// No description provided for @s26_tag_identity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get s26_tag_identity;

  /// No description provided for @s26_tag_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get s26_tag_important;

  /// No description provided for @s26_tag_personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get s26_tag_personal;

  /// No description provided for @s26_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes:  My valid passport document.'**
  String get s26_notes;

  /// No description provided for @s26_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get s26_share;

  /// No description provided for @s26_favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get s26_favorite;

  /// No description provided for @s26_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get s26_download;

  /// No description provided for @s26_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get s26_more;

  /// No description provided for @s27_title.
  ///
  /// In en, this message translates to:
  /// **'AI Organize'**
  String get s27_title;

  /// No description provided for @s27_scan_complete.
  ///
  /// In en, this message translates to:
  /// **'AI Scan Complete'**
  String get s27_scan_complete;

  /// No description provided for @s27_scan_complete_body.
  ///
  /// In en, this message translates to:
  /// **'I found 28 items that can be better organized.'**
  String get s27_scan_complete_body;

  /// No description provided for @s27_review.
  ///
  /// In en, this message translates to:
  /// **'Review Suggestions'**
  String get s27_review;

  /// No description provided for @s27_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions (12)'**
  String get s27_suggestions;

  /// No description provided for @s27_uncategorized.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized Documents'**
  String get s27_uncategorized;

  /// No description provided for @s27_uncategorized_count.
  ///
  /// In en, this message translates to:
  /// **'8 items'**
  String get s27_uncategorized_count;

  /// No description provided for @s27_uncategorized_body.
  ///
  /// In en, this message translates to:
  /// **'Move to appropriate collections'**
  String get s27_uncategorized_body;

  /// No description provided for @s27_duplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Items'**
  String get s27_duplicates;

  /// No description provided for @s27_duplicates_count.
  ///
  /// In en, this message translates to:
  /// **'5 items'**
  String get s27_duplicates_count;

  /// No description provided for @s27_duplicates_body.
  ///
  /// In en, this message translates to:
  /// **'Review and remove duplicates'**
  String get s27_duplicates_body;

  /// No description provided for @s27_missing_tags.
  ///
  /// In en, this message translates to:
  /// **'Missing Tags'**
  String get s27_missing_tags;

  /// No description provided for @s27_missing_tags_count.
  ///
  /// In en, this message translates to:
  /// **'7 items'**
  String get s27_missing_tags_count;

  /// No description provided for @s27_missing_tags_body.
  ///
  /// In en, this message translates to:
  /// **'Add relevant tags automatically'**
  String get s27_missing_tags_body;

  /// No description provided for @s27_similar.
  ///
  /// In en, this message translates to:
  /// **'Similar Documents'**
  String get s27_similar;

  /// No description provided for @s27_similar_count.
  ///
  /// In en, this message translates to:
  /// **'4 groups'**
  String get s27_similar_count;

  /// No description provided for @s27_similar_body.
  ///
  /// In en, this message translates to:
  /// **'Organize similar documents together'**
  String get s27_similar_body;

  /// No description provided for @s27_auto.
  ///
  /// In en, this message translates to:
  /// **'Auto Organization'**
  String get s27_auto;

  /// No description provided for @s27_auto_body.
  ///
  /// In en, this message translates to:
  /// **'Let AI organize new items automatically'**
  String get s27_auto_body;

  /// No description provided for @s28_title.
  ///
  /// In en, this message translates to:
  /// **'Tag Manager'**
  String get s28_title;

  /// No description provided for @s28_search.
  ///
  /// In en, this message translates to:
  /// **'Search tags...'**
  String get s28_search;

  /// No description provided for @s28_smart_tags.
  ///
  /// In en, this message translates to:
  /// **'Smart Tags'**
  String get s28_smart_tags;

  /// No description provided for @s28_smart_count.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get s28_smart_count;

  /// No description provided for @s28_identity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get s28_identity;

  /// No description provided for @s28_identity_count.
  ///
  /// In en, this message translates to:
  /// **'24'**
  String get s28_identity_count;

  /// No description provided for @s28_finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get s28_finance;

  /// No description provided for @s28_finance_count.
  ///
  /// In en, this message translates to:
  /// **'18'**
  String get s28_finance_count;

  /// No description provided for @s28_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get s28_insurance;

  /// No description provided for @s28_insurance_count.
  ///
  /// In en, this message translates to:
  /// **'16'**
  String get s28_insurance_count;

  /// No description provided for @s28_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get s28_health;

  /// No description provided for @s28_health_count.
  ///
  /// In en, this message translates to:
  /// **'14'**
  String get s28_health_count;

  /// No description provided for @s28_property.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get s28_property;

  /// No description provided for @s28_property_count.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s28_property_count;

  /// No description provided for @s28_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get s28_vehicle;

  /// No description provided for @s28_vehicle_count.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get s28_vehicle_count;

  /// No description provided for @s28_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get s28_work;

  /// No description provided for @s28_work_count.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get s28_work_count;

  /// No description provided for @s28_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get s28_important;

  /// No description provided for @s28_important_count.
  ///
  /// In en, this message translates to:
  /// **'20'**
  String get s28_important_count;

  /// No description provided for @s28_custom_tags.
  ///
  /// In en, this message translates to:
  /// **'Custom Tags'**
  String get s28_custom_tags;

  /// No description provided for @s28_custom_count.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s28_custom_count;

  /// No description provided for @s28_travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get s28_travel;

  /// No description provided for @s28_travel_count.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s28_travel_count;

  /// No description provided for @s28_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s28_education;

  /// No description provided for @s28_education_count.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get s28_education_count;

  /// No description provided for @s28_personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get s28_personal;

  /// No description provided for @s28_personal_count.
  ///
  /// In en, this message translates to:
  /// **'15'**
  String get s28_personal_count;

  /// No description provided for @s28_family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get s28_family;

  /// No description provided for @s28_family_count.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get s28_family_count;

  /// No description provided for @s29_title.
  ///
  /// In en, this message translates to:
  /// **'Vault Information'**
  String get s29_title;

  /// No description provided for @s29_vault_name.
  ///
  /// In en, this message translates to:
  /// **'My First Vault'**
  String get s29_vault_name;

  /// No description provided for @s29_created_summary.
  ///
  /// In en, this message translates to:
  /// **'Created on 12 May 2025'**
  String get s29_created_summary;

  /// No description provided for @s29_vault_id_label.
  ///
  /// In en, this message translates to:
  /// **'Vault ID'**
  String get s29_vault_id_label;

  /// No description provided for @s29_vault_id.
  ///
  /// In en, this message translates to:
  /// **'VK-7F3A-9D2B'**
  String get s29_vault_id;

  /// No description provided for @s29_version_label.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get s29_version_label;

  /// No description provided for @s29_version.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get s29_version;

  /// No description provided for @s29_encryption_label.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get s29_encryption_label;

  /// No description provided for @s29_encryption.
  ///
  /// In en, this message translates to:
  /// **'AES-256-GCM'**
  String get s29_encryption;

  /// No description provided for @s29_kdf_label.
  ///
  /// In en, this message translates to:
  /// **'Key Derivation'**
  String get s29_kdf_label;

  /// No description provided for @s29_kdf.
  ///
  /// In en, this message translates to:
  /// **'Argon2id'**
  String get s29_kdf;

  /// No description provided for @s29_created_label.
  ///
  /// In en, this message translates to:
  /// **'Created On'**
  String get s29_created_label;

  /// No description provided for @s29_created.
  ///
  /// In en, this message translates to:
  /// **'12 May 2025, 10:20 AM'**
  String get s29_created;

  /// No description provided for @s29_modified_label.
  ///
  /// In en, this message translates to:
  /// **'Last Modified'**
  String get s29_modified_label;

  /// No description provided for @s29_modified.
  ///
  /// In en, this message translates to:
  /// **'15 May 2025, 09:15 AM'**
  String get s29_modified;

  /// No description provided for @s29_items_label.
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get s29_items_label;

  /// No description provided for @s29_items.
  ///
  /// In en, this message translates to:
  /// **'248 items'**
  String get s29_items;

  /// No description provided for @s29_size_label.
  ///
  /// In en, this message translates to:
  /// **'Total Size'**
  String get s29_size_label;

  /// No description provided for @s29_size.
  ///
  /// In en, this message translates to:
  /// **'128 GB'**
  String get s29_size;

  /// No description provided for @s29_backup_label.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get s29_backup_label;

  /// No description provided for @s29_backup.
  ///
  /// In en, this message translates to:
  /// **'Not Created'**
  String get s29_backup;

  /// No description provided for @s29_export.
  ///
  /// In en, this message translates to:
  /// **'Export Vault Info'**
  String get s29_export;

  /// No description provided for @s30_title.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get s30_title;

  /// No description provided for @s30_help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get s30_help_center;

  /// No description provided for @s30_user_guide.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get s30_user_guide;

  /// No description provided for @s30_user_guide_body.
  ///
  /// In en, this message translates to:
  /// **'Learn how to use OwnKeep'**
  String get s30_user_guide_body;

  /// No description provided for @s30_faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get s30_faq;

  /// No description provided for @s30_faq_body.
  ///
  /// In en, this message translates to:
  /// **'Find answers to common questions'**
  String get s30_faq_body;

  /// No description provided for @s30_video.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get s30_video;

  /// No description provided for @s30_video_body.
  ///
  /// In en, this message translates to:
  /// **'Step by step video guides'**
  String get s30_video_body;

  /// No description provided for @s30_support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get s30_support;

  /// No description provided for @s30_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get s30_contact;

  /// No description provided for @s30_contact_body.
  ///
  /// In en, this message translates to:
  /// **'We\'ll respond as soon as possible'**
  String get s30_contact_body;

  /// No description provided for @s30_report.
  ///
  /// In en, this message translates to:
  /// **'Report an Issue'**
  String get s30_report;

  /// No description provided for @s30_report_body.
  ///
  /// In en, this message translates to:
  /// **'Help us improve OwnKeep'**
  String get s30_report_body;

  /// No description provided for @s30_about_section.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get s30_about_section;

  /// No description provided for @s30_about.
  ///
  /// In en, this message translates to:
  /// **'About OwnKeep'**
  String get s30_about;

  /// No description provided for @s30_version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get s30_version;

  /// No description provided for @s30_privacy_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: All your data is stored only on your device. We never collect or transmit your information.'**
  String get s30_privacy_tip;

  /// No description provided for @s31_title.
  ///
  /// In en, this message translates to:
  /// **'Recovery Center'**
  String get s31_title;

  /// No description provided for @s31_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Your Recovery Phrase'**
  String get s31_hero_title;

  /// No description provided for @s31_hero_body.
  ///
  /// In en, this message translates to:
  /// **'is your ultimate access'**
  String get s31_hero_body;

  /// No description provided for @s31_status_title.
  ///
  /// In en, this message translates to:
  /// **'Recovery Phrase Status'**
  String get s31_status_title;

  /// No description provided for @s31_status_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s31_status_verified;

  /// No description provided for @s31_last_verified.
  ///
  /// In en, this message translates to:
  /// **'Last verified: 12 May 2025, 10:30 AM'**
  String get s31_last_verified;

  /// No description provided for @s31_view_title.
  ///
  /// In en, this message translates to:
  /// **'View Recovery Phrase'**
  String get s31_view_title;

  /// No description provided for @s31_view_body.
  ///
  /// In en, this message translates to:
  /// **'View your 24-word recovery phrase'**
  String get s31_view_body;

  /// No description provided for @s31_verify_title.
  ///
  /// In en, this message translates to:
  /// **'Verify Recovery Phrase'**
  String get s31_verify_title;

  /// No description provided for @s31_verify_body.
  ///
  /// In en, this message translates to:
  /// **'Re-verify to make sure it\'s safe'**
  String get s31_verify_body;

  /// No description provided for @s31_instructions_title.
  ///
  /// In en, this message translates to:
  /// **'Recovery Instructions'**
  String get s31_instructions_title;

  /// No description provided for @s31_instructions_body.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step guide to recover vault'**
  String get s31_instructions_body;

  /// No description provided for @s31_emergency_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Access'**
  String get s31_emergency_title;

  /// No description provided for @s31_emergency_body.
  ///
  /// In en, this message translates to:
  /// **'Access your vault in critical situations'**
  String get s31_emergency_body;

  /// No description provided for @s31_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Store your recovery phrase offline in a safe place. Never share it with anyone.'**
  String get s31_tip;

  /// No description provided for @s32_title.
  ///
  /// In en, this message translates to:
  /// **'Health Reminders'**
  String get s32_title;

  /// No description provided for @s32_medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get s32_medicines;

  /// No description provided for @s32_appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get s32_appointments;

  /// No description provided for @s32_reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get s32_reports;

  /// No description provided for @s32_vitamin.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D3'**
  String get s32_vitamin;

  /// No description provided for @s32_vitamin_body.
  ///
  /// In en, this message translates to:
  /// **'1 Tablet after breakfast'**
  String get s32_vitamin_body;

  /// No description provided for @s32_vitamin_time.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM'**
  String get s32_vitamin_time;

  /// No description provided for @s32_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get s32_upcoming;

  /// No description provided for @s32_doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor Appointment'**
  String get s32_doctor;

  /// No description provided for @s32_doctor_name.
  ///
  /// In en, this message translates to:
  /// **'Dr. K. Sharma'**
  String get s32_doctor_name;

  /// No description provided for @s32_doctor_time.
  ///
  /// In en, this message translates to:
  /// **'15 May 2025, 04:00 PM'**
  String get s32_doctor_time;

  /// No description provided for @s32_blood.
  ///
  /// In en, this message translates to:
  /// **'Blood Test'**
  String get s32_blood;

  /// No description provided for @s32_blood_body.
  ///
  /// In en, this message translates to:
  /// **'Complete Blood Count'**
  String get s32_blood_body;

  /// No description provided for @s32_blood_time.
  ///
  /// In en, this message translates to:
  /// **'17 May 2025, 08:00 AM'**
  String get s32_blood_time;

  /// No description provided for @s32_refill.
  ///
  /// In en, this message translates to:
  /// **'Medicine Refill'**
  String get s32_refill;

  /// No description provided for @s32_refill_body.
  ///
  /// In en, this message translates to:
  /// **'Your medicines are running low'**
  String get s32_refill_body;

  /// No description provided for @s32_refill_time.
  ///
  /// In en, this message translates to:
  /// **'20 May 2025'**
  String get s32_refill_time;

  /// No description provided for @s32_summary.
  ///
  /// In en, this message translates to:
  /// **'Health Summary'**
  String get s32_summary;

  /// No description provided for @s32_medicines_count.
  ///
  /// In en, this message translates to:
  /// **'8 Active'**
  String get s32_medicines_count;

  /// No description provided for @s32_appointments_count.
  ///
  /// In en, this message translates to:
  /// **'3 Upcoming'**
  String get s32_appointments_count;

  /// No description provided for @s32_reports_count.
  ///
  /// In en, this message translates to:
  /// **'12 Stored'**
  String get s32_reports_count;

  /// No description provided for @s32_add.
  ///
  /// In en, this message translates to:
  /// **'Add New Reminder'**
  String get s32_add;

  /// No description provided for @s33_title.
  ///
  /// In en, this message translates to:
  /// **'Expiry Calendar'**
  String get s33_title;

  /// No description provided for @s33_month.
  ///
  /// In en, this message translates to:
  /// **'May 2025'**
  String get s33_month;

  /// No description provided for @weekday_sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekday_sun;

  /// No description provided for @weekday_mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekday_mon;

  /// No description provided for @weekday_tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekday_tue;

  /// No description provided for @weekday_wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekday_wed;

  /// No description provided for @weekday_thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekday_thu;

  /// No description provided for @weekday_fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekday_fri;

  /// No description provided for @weekday_sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekday_sat;

  /// No description provided for @s33_insurance_filter.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get s33_insurance_filter;

  /// No description provided for @s33_licenses_filter.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get s33_licenses_filter;

  /// No description provided for @s33_this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get s33_this_month;

  /// No description provided for @s33_driving_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get s33_driving_licence;

  /// No description provided for @s33_driving_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires on 28 May 2025'**
  String get s33_driving_expiry;

  /// No description provided for @s33_driving_days.
  ///
  /// In en, this message translates to:
  /// **'13 Days Left'**
  String get s33_driving_days;

  /// No description provided for @s33_health_policy.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance Policy'**
  String get s33_health_policy;

  /// No description provided for @s33_health_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires on 31 May 2025'**
  String get s33_health_expiry;

  /// No description provided for @s33_health_days.
  ///
  /// In en, this message translates to:
  /// **'16 Days Left'**
  String get s33_health_days;

  /// No description provided for @s33_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s33_passport;

  /// No description provided for @s33_passport_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires on 10 Jun 2025'**
  String get s33_passport_expiry;

  /// No description provided for @s33_passport_days.
  ///
  /// In en, this message translates to:
  /// **'26 Days Left'**
  String get s33_passport_days;

  /// No description provided for @s33_car.
  ///
  /// In en, this message translates to:
  /// **'Car Insurance'**
  String get s33_car;

  /// No description provided for @s33_car_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires on 20 Jun 2025'**
  String get s33_car_expiry;

  /// No description provided for @s33_car_days.
  ///
  /// In en, this message translates to:
  /// **'36 Days Left'**
  String get s33_car_days;

  /// No description provided for @s34_title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get s34_title;

  /// No description provided for @s34_query.
  ///
  /// In en, this message translates to:
  /// **'insurance policy'**
  String get s34_query;

  /// No description provided for @s34_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All (24)'**
  String get s34_filter_all;

  /// No description provided for @s34_filter_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents (8)'**
  String get s34_filter_documents;

  /// No description provided for @s34_filter_images.
  ///
  /// In en, this message translates to:
  /// **'Images (6)'**
  String get s34_filter_images;

  /// No description provided for @s34_filter_others.
  ///
  /// In en, this message translates to:
  /// **'Others (10)'**
  String get s34_filter_others;

  /// No description provided for @s34_top_results.
  ///
  /// In en, this message translates to:
  /// **'Top Results'**
  String get s34_top_results;

  /// No description provided for @s34_health.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance Policy'**
  String get s34_health;

  /// No description provided for @s34_health_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF   •   2.4 MB   •   31 May 2025'**
  String get s34_health_meta;

  /// No description provided for @s34_car.
  ///
  /// In en, this message translates to:
  /// **'Car Insurance Policy'**
  String get s34_car;

  /// No description provided for @s34_car_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF   •   1.8 MB   •   20 Jun 2025'**
  String get s34_car_meta;

  /// No description provided for @s34_life.
  ///
  /// In en, this message translates to:
  /// **'Life Insurance Policy'**
  String get s34_life;

  /// No description provided for @s34_life_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF   •   1.2 MB   •   15 Aug 2025'**
  String get s34_life_meta;

  /// No description provided for @s34_other_results.
  ///
  /// In en, this message translates to:
  /// **'Other Results'**
  String get s34_other_results;

  /// No description provided for @s34_receipt.
  ///
  /// In en, this message translates to:
  /// **'Insurance Premium Receipt'**
  String get s34_receipt;

  /// No description provided for @s34_receipt_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG   •   845 KB   •   15 May 2025'**
  String get s34_receipt_meta;

  /// No description provided for @s34_claim.
  ///
  /// In en, this message translates to:
  /// **'Insurance Claim Form'**
  String get s34_claim;

  /// No description provided for @s34_claim_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF   •   1.1 MB   •   10 Apr 2025'**
  String get s34_claim_meta;

  /// No description provided for @s34_folder.
  ///
  /// In en, this message translates to:
  /// **'Policy Documents'**
  String get s34_folder;

  /// No description provided for @s34_folder_meta.
  ///
  /// In en, this message translates to:
  /// **'Folder   •   8 Items'**
  String get s34_folder_meta;

  /// No description provided for @s34_copy.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy Copy'**
  String get s34_copy;

  /// No description provided for @s34_copy_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF   •   2.0 MB   •   5 Jan 2025'**
  String get s34_copy_meta;

  /// No description provided for @s34_not_found.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find what you\'re looking for?'**
  String get s34_not_found;

  /// No description provided for @s34_try_ai.
  ///
  /// In en, this message translates to:
  /// **'Try AI Search'**
  String get s34_try_ai;

  /// No description provided for @s34_ai_button.
  ///
  /// In en, this message translates to:
  /// **'AI Search'**
  String get s34_ai_button;

  /// No description provided for @s35_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to OwnKeep'**
  String get s35_title;

  /// No description provided for @s35_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get s35_skip;

  /// No description provided for @s35_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Your Data. Your Control.'**
  String get s35_hero_title;

  /// No description provided for @s35_hero_body.
  ///
  /// In en, this message translates to:
  /// **'100% Offline. End-to-End Encrypted.'**
  String get s35_hero_body;

  /// No description provided for @s35_private_title.
  ///
  /// In en, this message translates to:
  /// **'Keep everything private'**
  String get s35_private_title;

  /// No description provided for @s35_private_body.
  ///
  /// In en, this message translates to:
  /// **'Your data never leaves your device.'**
  String get s35_private_body;

  /// No description provided for @s35_organize_title.
  ///
  /// In en, this message translates to:
  /// **'Organize with ease'**
  String get s35_organize_title;

  /// No description provided for @s35_organize_body.
  ///
  /// In en, this message translates to:
  /// **'Smart tags and AI suggestions.'**
  String get s35_organize_body;

  /// No description provided for @s35_reminders_title.
  ///
  /// In en, this message translates to:
  /// **'Never miss important things'**
  String get s35_reminders_title;

  /// No description provided for @s35_reminders_body.
  ///
  /// In en, this message translates to:
  /// **'Reminders for expiries and events.'**
  String get s35_reminders_body;

  /// No description provided for @s35_secure_title.
  ///
  /// In en, this message translates to:
  /// **'Secure forever'**
  String get s35_secure_title;

  /// No description provided for @s35_secure_body.
  ///
  /// In en, this message translates to:
  /// **'Your vault, your rules.'**
  String get s35_secure_body;

  /// No description provided for @s35_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get s35_get_started;

  /// No description provided for @s36_title.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Finder'**
  String get s36_title;

  /// No description provided for @s36_duplicates.
  ///
  /// In en, this message translates to:
  /// **'873'**
  String get s36_duplicates;

  /// No description provided for @s36_found.
  ///
  /// In en, this message translates to:
  /// **'Duplicates Found'**
  String get s36_found;

  /// No description provided for @s36_photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get s36_photos;

  /// No description provided for @s36_photos_count.
  ///
  /// In en, this message translates to:
  /// **'623'**
  String get s36_photos_count;

  /// No description provided for @s36_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s36_documents;

  /// No description provided for @s36_documents_count.
  ///
  /// In en, this message translates to:
  /// **'186'**
  String get s36_documents_count;

  /// No description provided for @s36_videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get s36_videos;

  /// No description provided for @s36_videos_count.
  ///
  /// In en, this message translates to:
  /// **'64'**
  String get s36_videos_count;

  /// No description provided for @s36_free_up.
  ///
  /// In en, this message translates to:
  /// **'You can free up'**
  String get s36_free_up;

  /// No description provided for @s36_free_up_value.
  ///
  /// In en, this message translates to:
  /// **'2.48 GB'**
  String get s36_free_up_value;

  /// No description provided for @s36_review.
  ///
  /// In en, this message translates to:
  /// **'Review Duplicates'**
  String get s36_review;

  /// No description provided for @s36_groups.
  ///
  /// In en, this message translates to:
  /// **'Smart Groups'**
  String get s36_groups;

  /// No description provided for @s36_similar_photos.
  ///
  /// In en, this message translates to:
  /// **'Similar Photos'**
  String get s36_similar_photos;

  /// No description provided for @s36_similar_photos_meta.
  ///
  /// In en, this message translates to:
  /// **'452 items  •  1.36 GB'**
  String get s36_similar_photos_meta;

  /// No description provided for @s36_similar_documents.
  ///
  /// In en, this message translates to:
  /// **'Similar Documents'**
  String get s36_similar_documents;

  /// No description provided for @s36_similar_documents_meta.
  ///
  /// In en, this message translates to:
  /// **'214 items  •  680 MB'**
  String get s36_similar_documents_meta;

  /// No description provided for @s36_similar_videos.
  ///
  /// In en, this message translates to:
  /// **'Similar Videos'**
  String get s36_similar_videos;

  /// No description provided for @s36_similar_videos_meta.
  ///
  /// In en, this message translates to:
  /// **'64 items  •  450 MB'**
  String get s36_similar_videos_meta;

  /// No description provided for @s36_screenshots.
  ///
  /// In en, this message translates to:
  /// **'Screenshots'**
  String get s36_screenshots;

  /// No description provided for @s36_screenshots_meta.
  ///
  /// In en, this message translates to:
  /// **'143 items  •  280 MB'**
  String get s36_screenshots_meta;

  /// No description provided for @s37_title.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get s37_title;

  /// No description provided for @s37_overview.
  ///
  /// In en, this message translates to:
  /// **'Vault Overview'**
  String get s37_overview;

  /// No description provided for @common_this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get common_this_month;

  /// No description provided for @s37_total_storage.
  ///
  /// In en, this message translates to:
  /// **'128 GB'**
  String get s37_total_storage;

  /// No description provided for @s37_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s37_documents;

  /// No description provided for @s37_documents_size.
  ///
  /// In en, this message translates to:
  /// **'48.5 GB'**
  String get s37_documents_size;

  /// No description provided for @s37_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get s37_images;

  /// No description provided for @s37_images_size.
  ///
  /// In en, this message translates to:
  /// **'32.4 GB'**
  String get s37_images_size;

  /// No description provided for @s37_videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get s37_videos;

  /// No description provided for @s37_videos_size.
  ///
  /// In en, this message translates to:
  /// **'22.1 GB'**
  String get s37_videos_size;

  /// No description provided for @s37_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get s37_others;

  /// No description provided for @s37_others_size.
  ///
  /// In en, this message translates to:
  /// **'25.0 GB'**
  String get s37_others_size;

  /// No description provided for @s37_used.
  ///
  /// In en, this message translates to:
  /// **'Used: 103 GB'**
  String get s37_used;

  /// No description provided for @s37_free.
  ///
  /// In en, this message translates to:
  /// **'Free: 25 GB'**
  String get s37_free;

  /// No description provided for @s37_total_items.
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get s37_total_items;

  /// No description provided for @s37_total_items_value.
  ///
  /// In en, this message translates to:
  /// **'12,547'**
  String get s37_total_items_value;

  /// No description provided for @s37_folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get s37_folders;

  /// No description provided for @s37_folders_value.
  ///
  /// In en, this message translates to:
  /// **'428'**
  String get s37_folders_value;

  /// No description provided for @s37_files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get s37_files;

  /// No description provided for @s37_files_value.
  ///
  /// In en, this message translates to:
  /// **'12,119'**
  String get s37_files_value;

  /// No description provided for @s37_activity.
  ///
  /// In en, this message translates to:
  /// **'Activity Summary'**
  String get s37_activity;

  /// No description provided for @s37_files_added.
  ///
  /// In en, this message translates to:
  /// **'Files Added'**
  String get s37_files_added;

  /// No description provided for @s37_files_added_value.
  ///
  /// In en, this message translates to:
  /// **'+342'**
  String get s37_files_added_value;

  /// No description provided for @s37_files_opened.
  ///
  /// In en, this message translates to:
  /// **'Files Opened'**
  String get s37_files_opened;

  /// No description provided for @s37_files_opened_value.
  ///
  /// In en, this message translates to:
  /// **'+1,842'**
  String get s37_files_opened_value;

  /// No description provided for @s37_space_saved.
  ///
  /// In en, this message translates to:
  /// **'Space Saved'**
  String get s37_space_saved;

  /// No description provided for @s37_space_saved_value.
  ///
  /// In en, this message translates to:
  /// **'2.48 GB'**
  String get s37_space_saved_value;

  /// No description provided for @s37_duplicates_removed.
  ///
  /// In en, this message translates to:
  /// **'Duplicates Removed'**
  String get s37_duplicates_removed;

  /// No description provided for @s37_duplicates_removed_value.
  ///
  /// In en, this message translates to:
  /// **'873'**
  String get s37_duplicates_removed_value;

  /// No description provided for @s38_app_name.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep'**
  String get s38_app_name;

  /// No description provided for @s38_enter_pin.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get s38_enter_pin;

  /// No description provided for @s38_key_2_letters.
  ///
  /// In en, this message translates to:
  /// **'ABC'**
  String get s38_key_2_letters;

  /// No description provided for @s38_key_3_letters.
  ///
  /// In en, this message translates to:
  /// **'DEF'**
  String get s38_key_3_letters;

  /// No description provided for @s38_key_4_letters.
  ///
  /// In en, this message translates to:
  /// **'GHI'**
  String get s38_key_4_letters;

  /// No description provided for @s38_key_5_letters.
  ///
  /// In en, this message translates to:
  /// **'JKL'**
  String get s38_key_5_letters;

  /// No description provided for @s38_key_6_letters.
  ///
  /// In en, this message translates to:
  /// **'MNO'**
  String get s38_key_6_letters;

  /// No description provided for @s38_key_7_letters.
  ///
  /// In en, this message translates to:
  /// **'PQRS'**
  String get s38_key_7_letters;

  /// No description provided for @s38_key_8_letters.
  ///
  /// In en, this message translates to:
  /// **'TUV'**
  String get s38_key_8_letters;

  /// No description provided for @s38_key_9_letters.
  ///
  /// In en, this message translates to:
  /// **'WXYZ'**
  String get s38_key_9_letters;

  /// No description provided for @s38_use_fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Use Fingerprint'**
  String get s38_use_fingerprint;

  /// No description provided for @s38_emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency Access'**
  String get s38_emergency;

  /// No description provided for @s39_title.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get s39_title;

  /// No description provided for @s39_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get s39_edit;

  /// No description provided for @s39_create_new.
  ///
  /// In en, this message translates to:
  /// **'Create New'**
  String get s39_create_new;

  /// No description provided for @s39_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan Document'**
  String get s39_scan;

  /// No description provided for @s39_photo.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get s39_photo;

  /// No description provided for @s39_add_files.
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get s39_add_files;

  /// No description provided for @s39_voice.
  ///
  /// In en, this message translates to:
  /// **'Voice Note'**
  String get s39_voice;

  /// No description provided for @s39_note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get s39_note;

  /// No description provided for @s39_folder.
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get s39_folder;

  /// No description provided for @s39_tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get s39_tools;

  /// No description provided for @s39_ai.
  ///
  /// In en, this message translates to:
  /// **'AI Organize'**
  String get s39_ai;

  /// No description provided for @s39_ai_body.
  ///
  /// In en, this message translates to:
  /// **'Let AI organize your items'**
  String get s39_ai_body;

  /// No description provided for @s39_duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Finder'**
  String get s39_duplicate;

  /// No description provided for @s39_duplicate_body.
  ///
  /// In en, this message translates to:
  /// **'Find and remove duplicates'**
  String get s39_duplicate_body;

  /// No description provided for @s39_export.
  ///
  /// In en, this message translates to:
  /// **'Export Vault'**
  String get s39_export;

  /// No description provided for @s39_export_body.
  ///
  /// In en, this message translates to:
  /// **'Export your data securely'**
  String get s39_export_body;

  /// No description provided for @s39_lock.
  ///
  /// In en, this message translates to:
  /// **'Lock Vault'**
  String get s39_lock;

  /// No description provided for @s39_lock_body.
  ///
  /// In en, this message translates to:
  /// **'Lock immediately'**
  String get s39_lock_body;

  /// No description provided for @s39_shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get s39_shortcuts;

  /// No description provided for @s39_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s39_passport;

  /// No description provided for @s39_passport_path.
  ///
  /// In en, this message translates to:
  /// **'Documents › Personal'**
  String get s39_passport_path;

  /// No description provided for @s39_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s39_insurance;

  /// No description provided for @s39_insurance_path.
  ///
  /// In en, this message translates to:
  /// **'Documents › Insurance'**
  String get s39_insurance_path;

  /// No description provided for @s40_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get s40_title;

  /// No description provided for @s40_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get s40_security;

  /// No description provided for @s40_auto_lock.
  ///
  /// In en, this message translates to:
  /// **'Auto Lock'**
  String get s40_auto_lock;

  /// No description provided for @s40_auto_lock_value.
  ///
  /// In en, this message translates to:
  /// **'5 minutes'**
  String get s40_auto_lock_value;

  /// No description provided for @s40_stealth.
  ///
  /// In en, this message translates to:
  /// **'Stealth Mode'**
  String get s40_stealth;

  /// No description provided for @s40_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get s40_off;

  /// No description provided for @s40_decoy.
  ///
  /// In en, this message translates to:
  /// **'Decoy Vault'**
  String get s40_decoy;

  /// No description provided for @s40_not_set.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get s40_not_set;

  /// No description provided for @s40_biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get s40_biometric;

  /// No description provided for @s40_pin.
  ///
  /// In en, this message translates to:
  /// **'PIN Protection'**
  String get s40_pin;

  /// No description provided for @s40_on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get s40_on;

  /// No description provided for @s40_encryption.
  ///
  /// In en, this message translates to:
  /// **'Vault Encryption'**
  String get s40_encryption;

  /// No description provided for @s40_encryption_value.
  ///
  /// In en, this message translates to:
  /// **'AES-256'**
  String get s40_encryption_value;

  /// No description provided for @s40_data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get s40_data;

  /// No description provided for @s40_backup.
  ///
  /// In en, this message translates to:
  /// **'Backup Reminders'**
  String get s40_backup;

  /// No description provided for @s40_data_check.
  ///
  /// In en, this message translates to:
  /// **'Data Check'**
  String get s40_data_check;

  /// No description provided for @s40_last_check.
  ///
  /// In en, this message translates to:
  /// **'Last check: Today'**
  String get s40_last_check;

  /// No description provided for @s40_wipe.
  ///
  /// In en, this message translates to:
  /// **'Wipe Data'**
  String get s40_wipe;

  /// No description provided for @s40_wipe_body.
  ///
  /// In en, this message translates to:
  /// **'Delete all data permanently'**
  String get s40_wipe_body;

  /// No description provided for @s40_advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get s40_advanced;

  /// No description provided for @s40_developer.
  ///
  /// In en, this message translates to:
  /// **'Developer Options'**
  String get s40_developer;

  /// No description provided for @s40_logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get s40_logs;

  /// No description provided for @s40_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset All Settings'**
  String get s40_reset;

  /// No description provided for @s51_title.
  ///
  /// In en, this message translates to:
  /// **'Select Items'**
  String get s51_title;

  /// No description provided for @s51_selected_count.
  ///
  /// In en, this message translates to:
  /// **'3 selected'**
  String get s51_selected_count;

  /// No description provided for @s51_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s51_passport;

  /// No description provided for @s51_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 1.2 MB'**
  String get s51_passport_meta;

  /// No description provided for @s51_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s51_insurance;

  /// No description provided for @s51_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 2.4 MB'**
  String get s51_insurance_meta;

  /// No description provided for @s51_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence.jpg'**
  String get s51_licence;

  /// No description provided for @s51_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG • 860 KB'**
  String get s51_licence_meta;

  /// No description provided for @s51_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement.pdf'**
  String get s51_bank;

  /// No description provided for @s51_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'PDF • 3.1 MB'**
  String get s51_bank_meta;

  /// No description provided for @s51_photo.
  ///
  /// In en, this message translates to:
  /// **'Family Photo.jpg'**
  String get s51_photo;

  /// No description provided for @s51_photo_meta.
  ///
  /// In en, this message translates to:
  /// **'JPG • 4.6 MB'**
  String get s51_photo_meta;

  /// No description provided for @s51_project.
  ///
  /// In en, this message translates to:
  /// **'Project Plan.docx'**
  String get s51_project;

  /// No description provided for @s51_project_meta.
  ///
  /// In en, this message translates to:
  /// **'DOCX • 520 KB'**
  String get s51_project_meta;

  /// No description provided for @s51_investment.
  ///
  /// In en, this message translates to:
  /// **'Investment Summary.xlsx'**
  String get s51_investment;

  /// No description provided for @s51_investment_meta.
  ///
  /// In en, this message translates to:
  /// **'XLSX • 540 KB'**
  String get s51_investment_meta;

  /// No description provided for @common_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get common_share;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @s52_title.
  ///
  /// In en, this message translates to:
  /// **'Move To'**
  String get s52_title;

  /// No description provided for @s52_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose destination'**
  String get s52_subtitle;

  /// No description provided for @s52_selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get s52_selected;

  /// No description provided for @s52_selected_summary.
  ///
  /// In en, this message translates to:
  /// **'3 files • 6.7 MB'**
  String get s52_selected_summary;

  /// No description provided for @s52_collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get s52_collections;

  /// No description provided for @s52_personal_count.
  ///
  /// In en, this message translates to:
  /// **'28 items'**
  String get s52_personal_count;

  /// No description provided for @s52_finance_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s52_finance_count;

  /// No description provided for @s52_health_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s52_health_count;

  /// No description provided for @s52_property_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s52_property_count;

  /// No description provided for @s52_vehicle_count.
  ///
  /// In en, this message translates to:
  /// **'8 items'**
  String get s52_vehicle_count;

  /// No description provided for @s52_education_count.
  ///
  /// In en, this message translates to:
  /// **'6 items'**
  String get s52_education_count;

  /// No description provided for @s52_create_folder.
  ///
  /// In en, this message translates to:
  /// **'Create New Folder'**
  String get s52_create_folder;

  /// No description provided for @s52_create_folder_body.
  ///
  /// In en, this message translates to:
  /// **'Add destination'**
  String get s52_create_folder_body;

  /// No description provided for @s52_move_here.
  ///
  /// In en, this message translates to:
  /// **'Move Here'**
  String get s52_move_here;

  /// No description provided for @s53_title.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get s53_title;

  /// No description provided for @s53_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Update file name'**
  String get s53_subtitle;

  /// No description provided for @s53_preview_type.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get s53_preview_type;

  /// No description provided for @s53_preview_name.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get s53_preview_name;

  /// No description provided for @s53_file_name.
  ///
  /// In en, this message translates to:
  /// **'File Name'**
  String get s53_file_name;

  /// No description provided for @s53_file_name_value.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy 2025.pdf'**
  String get s53_file_name_value;

  /// No description provided for @s53_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get s53_location;

  /// No description provided for @s53_location_value.
  ///
  /// In en, this message translates to:
  /// **'Finance › Insurance'**
  String get s53_location_value;

  /// No description provided for @s53_tips.
  ///
  /// In en, this message translates to:
  /// **'Naming Tips'**
  String get s53_tips;

  /// No description provided for @s53_tip_clear.
  ///
  /// In en, this message translates to:
  /// **'Use a clear title'**
  String get s53_tip_clear;

  /// No description provided for @s53_tip_year.
  ///
  /// In en, this message translates to:
  /// **'Include a year when useful'**
  String get s53_tip_year;

  /// No description provided for @s53_tip_special.
  ///
  /// In en, this message translates to:
  /// **'Avoid special characters'**
  String get s53_tip_special;

  /// No description provided for @s53_tip_extension.
  ///
  /// In en, this message translates to:
  /// **'File extension stays unchanged'**
  String get s53_tip_extension;

  /// No description provided for @s53_save.
  ///
  /// In en, this message translates to:
  /// **'Save Name'**
  String get s53_save;

  /// No description provided for @s54_title.
  ///
  /// In en, this message translates to:
  /// **'Merge PDF'**
  String get s54_title;

  /// No description provided for @s54_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Combine selected documents'**
  String get s54_subtitle;

  /// No description provided for @s54_arrange.
  ///
  /// In en, this message translates to:
  /// **'Arrange pages'**
  String get s54_arrange;

  /// No description provided for @s54_arrange_hint.
  ///
  /// In en, this message translates to:
  /// **'Drag items to reorder before merging'**
  String get s54_arrange_hint;

  /// No description provided for @s54_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s54_passport;

  /// No description provided for @s54_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'2 pages • 1.2 MB'**
  String get s54_passport_meta;

  /// No description provided for @s54_position_1.
  ///
  /// In en, this message translates to:
  /// **'Position 1'**
  String get s54_position_1;

  /// No description provided for @s54_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s54_insurance;

  /// No description provided for @s54_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'4 pages • 2.4 MB'**
  String get s54_insurance_meta;

  /// No description provided for @s54_position_2.
  ///
  /// In en, this message translates to:
  /// **'Position 2'**
  String get s54_position_2;

  /// No description provided for @s54_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank Statement.pdf'**
  String get s54_bank;

  /// No description provided for @s54_bank_meta.
  ///
  /// In en, this message translates to:
  /// **'6 pages • 3.1 MB'**
  String get s54_bank_meta;

  /// No description provided for @s54_position_3.
  ///
  /// In en, this message translates to:
  /// **'Position 3'**
  String get s54_position_3;

  /// No description provided for @s54_output_file.
  ///
  /// In en, this message translates to:
  /// **'Output File'**
  String get s54_output_file;

  /// No description provided for @s54_output_name.
  ///
  /// In en, this message translates to:
  /// **'Merged Documents.pdf'**
  String get s54_output_name;

  /// No description provided for @s54_estimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated output'**
  String get s54_estimated;

  /// No description provided for @s54_estimated_value.
  ///
  /// In en, this message translates to:
  /// **'12 pages • 6.7 MB'**
  String get s54_estimated_value;

  /// No description provided for @s54_merge.
  ///
  /// In en, this message translates to:
  /// **'Merge 3 PDFs'**
  String get s54_merge;

  /// No description provided for @s55_title.
  ///
  /// In en, this message translates to:
  /// **'Split PDF'**
  String get s55_title;

  /// No description provided for @s55_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose pages to extract'**
  String get s55_subtitle;

  /// No description provided for @s55_file.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s55_file;

  /// No description provided for @s55_file_meta.
  ///
  /// In en, this message translates to:
  /// **'4 pages • 2.4 MB'**
  String get s55_file_meta;

  /// No description provided for @s55_select_pages.
  ///
  /// In en, this message translates to:
  /// **'Select Pages'**
  String get s55_select_pages;

  /// No description provided for @s55_page_1.
  ///
  /// In en, this message translates to:
  /// **'PAGE 1'**
  String get s55_page_1;

  /// No description provided for @s55_page_2.
  ///
  /// In en, this message translates to:
  /// **'PAGE 2'**
  String get s55_page_2;

  /// No description provided for @s55_page_3.
  ///
  /// In en, this message translates to:
  /// **'PAGE 3'**
  String get s55_page_3;

  /// No description provided for @s55_page_4.
  ///
  /// In en, this message translates to:
  /// **'PAGE 4'**
  String get s55_page_4;

  /// No description provided for @s55_page_label.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get s55_page_label;

  /// No description provided for @s55_split_options.
  ///
  /// In en, this message translates to:
  /// **'Split Options'**
  String get s55_split_options;

  /// No description provided for @s55_extract.
  ///
  /// In en, this message translates to:
  /// **'Extract selected pages'**
  String get s55_extract;

  /// No description provided for @s55_extract_body.
  ///
  /// In en, this message translates to:
  /// **'Create one PDF from pages 2–3'**
  String get s55_extract_body;

  /// No description provided for @s55_separate.
  ///
  /// In en, this message translates to:
  /// **'Save pages separately'**
  String get s55_separate;

  /// No description provided for @s55_separate_body.
  ///
  /// In en, this message translates to:
  /// **'Create individual files'**
  String get s55_separate_body;

  /// No description provided for @s55_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove selected pages'**
  String get s55_remove;

  /// No description provided for @s55_remove_body.
  ///
  /// In en, this message translates to:
  /// **'Create PDF without pages 2–3'**
  String get s55_remove_body;

  /// No description provided for @s55_action.
  ///
  /// In en, this message translates to:
  /// **'Split PDF'**
  String get s55_action;

  /// No description provided for @s56_title.
  ///
  /// In en, this message translates to:
  /// **'Scan Text'**
  String get s56_title;

  /// No description provided for @s56_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Extract text from document'**
  String get s56_subtitle;

  /// No description provided for @s56_document_title.
  ///
  /// In en, this message translates to:
  /// **'INSURANCE POLICY'**
  String get s56_document_title;

  /// No description provided for @s56_policy_number.
  ///
  /// In en, this message translates to:
  /// **'Policy Number: POL/AGI/2024/123456789'**
  String get s56_policy_number;

  /// No description provided for @s56_policy_holder.
  ///
  /// In en, this message translates to:
  /// **'Policy Holder: Arjun Sharma'**
  String get s56_policy_holder;

  /// No description provided for @s56_policy_type.
  ///
  /// In en, this message translates to:
  /// **'Policy Type: Health Insurance'**
  String get s56_policy_type;

  /// No description provided for @s56_policy_period.
  ///
  /// In en, this message translates to:
  /// **'Policy Period: 01 Apr 2024 – 31 Mar 2025'**
  String get s56_policy_period;

  /// No description provided for @s56_extracted.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get s56_extracted;

  /// No description provided for @s56_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy Text'**
  String get s56_copy;

  /// No description provided for @s56_save_note.
  ///
  /// In en, this message translates to:
  /// **'Save as Note'**
  String get s56_save_note;

  /// No description provided for @s56_local_notice.
  ///
  /// In en, this message translates to:
  /// **'Text processed only on this device'**
  String get s56_local_notice;

  /// No description provided for @s57_title.
  ///
  /// In en, this message translates to:
  /// **'Compare Documents'**
  String get s57_title;

  /// No description provided for @s57_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Review differences'**
  String get s57_subtitle;

  /// No description provided for @s57_version_a.
  ///
  /// In en, this message translates to:
  /// **'Version A'**
  String get s57_version_a;

  /// No description provided for @s57_version_b.
  ///
  /// In en, this message translates to:
  /// **'Version B'**
  String get s57_version_b;

  /// No description provided for @s57_policy_number_label.
  ///
  /// In en, this message translates to:
  /// **'Policy Number'**
  String get s57_policy_number_label;

  /// No description provided for @s57_policy_number.
  ///
  /// In en, this message translates to:
  /// **'POL/AGI/2024/123'**
  String get s57_policy_number;

  /// No description provided for @s57_policy_holder_label.
  ///
  /// In en, this message translates to:
  /// **'Policy Holder'**
  String get s57_policy_holder_label;

  /// No description provided for @s57_policy_holder.
  ///
  /// In en, this message translates to:
  /// **'Arjun Sharma'**
  String get s57_policy_holder;

  /// No description provided for @s57_premium_label.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get s57_premium_label;

  /// No description provided for @s57_premium_a.
  ///
  /// In en, this message translates to:
  /// **'₹12,500'**
  String get s57_premium_a;

  /// No description provided for @s57_premium_b.
  ///
  /// In en, this message translates to:
  /// **'₹13,250'**
  String get s57_premium_b;

  /// No description provided for @s57_period_label.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get s57_period_label;

  /// No description provided for @s57_period_a.
  ///
  /// In en, this message translates to:
  /// **'2024–2025'**
  String get s57_period_a;

  /// No description provided for @s57_period_b.
  ///
  /// In en, this message translates to:
  /// **'2025–2026'**
  String get s57_period_b;

  /// No description provided for @s57_changes.
  ///
  /// In en, this message translates to:
  /// **'Changes Found'**
  String get s57_changes;

  /// No description provided for @s57_premium_change.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get s57_premium_change;

  /// No description provided for @s57_premium_change_body.
  ///
  /// In en, this message translates to:
  /// **'₹12,500 → ₹13,250'**
  String get s57_premium_change_body;

  /// No description provided for @s57_period_change.
  ///
  /// In en, this message translates to:
  /// **'Policy Period'**
  String get s57_period_change;

  /// No description provided for @s57_period_change_body.
  ///
  /// In en, this message translates to:
  /// **'2024–2025 → 2025–2026'**
  String get s57_period_change_body;

  /// No description provided for @s57_no_other.
  ///
  /// In en, this message translates to:
  /// **'No other changes'**
  String get s57_no_other;

  /// No description provided for @s57_no_other_body.
  ///
  /// In en, this message translates to:
  /// **'Document structure matches'**
  String get s57_no_other_body;

  /// No description provided for @s57_export.
  ///
  /// In en, this message translates to:
  /// **'Export Comparison'**
  String get s57_export;

  /// No description provided for @s58_title.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get s58_title;

  /// No description provided for @s58_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s58_subtitle;

  /// No description provided for @s58_title_label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get s58_title_label;

  /// No description provided for @s58_title_value.
  ///
  /// In en, this message translates to:
  /// **'Renewal Notes'**
  String get s58_title_value;

  /// No description provided for @s58_note_label.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get s58_note_label;

  /// No description provided for @s58_note_line_1.
  ///
  /// In en, this message translates to:
  /// **'Call insurer before 20 March.'**
  String get s58_note_line_1;

  /// No description provided for @s58_note_line_2.
  ///
  /// In en, this message translates to:
  /// **'Ask about family floater upgrade and cashless hospitals near home.'**
  String get s58_note_line_2;

  /// No description provided for @s58_note_line_3.
  ///
  /// In en, this message translates to:
  /// **'Compare premium with last year before renewing.'**
  String get s58_note_line_3;

  /// No description provided for @s58_counter.
  ///
  /// In en, this message translates to:
  /// **'164 / 2000'**
  String get s58_counter;

  /// No description provided for @s58_attach.
  ///
  /// In en, this message translates to:
  /// **'Attach To'**
  String get s58_attach;

  /// No description provided for @s58_attach_value.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s58_attach_value;

  /// No description provided for @s58_reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get s58_reminder;

  /// No description provided for @s58_reminder_body.
  ///
  /// In en, this message translates to:
  /// **'Add reminder for this note'**
  String get s58_reminder_body;

  /// No description provided for @s58_save.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get s58_save;

  /// No description provided for @s59_title.
  ///
  /// In en, this message translates to:
  /// **'Print / Save As'**
  String get s59_title;

  /// No description provided for @s59_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose output option'**
  String get s59_subtitle;

  /// No description provided for @s59_file.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s59_file;

  /// No description provided for @s59_file_meta.
  ///
  /// In en, this message translates to:
  /// **'4 pages • 2.4 MB'**
  String get s59_file_meta;

  /// No description provided for @s59_location.
  ///
  /// In en, this message translates to:
  /// **'Finance › Insurance'**
  String get s59_location;

  /// No description provided for @s59_output.
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get s59_output;

  /// No description provided for @s59_print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get s59_print;

  /// No description provided for @s59_print_body.
  ///
  /// In en, this message translates to:
  /// **'Use a connected printer'**
  String get s59_print_body;

  /// No description provided for @s59_save_pdf.
  ///
  /// In en, this message translates to:
  /// **'Save as PDF'**
  String get s59_save_pdf;

  /// No description provided for @s59_save_pdf_body.
  ///
  /// In en, this message translates to:
  /// **'Create a new PDF copy'**
  String get s59_save_pdf_body;

  /// No description provided for @s59_save_files.
  ///
  /// In en, this message translates to:
  /// **'Save to Files'**
  String get s59_save_files;

  /// No description provided for @s59_save_files_body.
  ///
  /// In en, this message translates to:
  /// **'Choose a local folder'**
  String get s59_save_files_body;

  /// No description provided for @s59_export_images.
  ///
  /// In en, this message translates to:
  /// **'Export Images'**
  String get s59_export_images;

  /// No description provided for @s59_export_images_body.
  ///
  /// In en, this message translates to:
  /// **'Save each page as image'**
  String get s59_export_images_body;

  /// No description provided for @s59_page_range.
  ///
  /// In en, this message translates to:
  /// **'Page Range'**
  String get s59_page_range;

  /// No description provided for @s59_all_pages.
  ///
  /// In en, this message translates to:
  /// **'All pages'**
  String get s59_all_pages;

  /// No description provided for @s59_page_value.
  ///
  /// In en, this message translates to:
  /// **'1–4'**
  String get s59_page_value;

  /// No description provided for @s59_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get s59_privacy;

  /// No description provided for @s59_privacy_body.
  ///
  /// In en, this message translates to:
  /// **'Printing or saving creates an unencrypted copy outside OwnKeep. Continue only when you trust the destination.'**
  String get s59_privacy_body;

  /// No description provided for @common_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get common_continue;

  /// No description provided for @s60_title.
  ///
  /// In en, this message translates to:
  /// **'Secure Scan'**
  String get s60_title;

  /// No description provided for @s60_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Capture and encrypt instantly'**
  String get s60_subtitle;

  /// No description provided for @s60_document.
  ///
  /// In en, this message translates to:
  /// **'DOCUMENT'**
  String get s60_document;

  /// No description provided for @s60_detected.
  ///
  /// In en, this message translates to:
  /// **'Document detected'**
  String get s60_detected;

  /// No description provided for @s60_auto_crop.
  ///
  /// In en, this message translates to:
  /// **'Auto Crop'**
  String get s60_auto_crop;

  /// No description provided for @s60_enhance.
  ///
  /// In en, this message translates to:
  /// **'Enhance'**
  String get s60_enhance;

  /// No description provided for @s60_ocr.
  ///
  /// In en, this message translates to:
  /// **'OCR'**
  String get s60_ocr;

  /// No description provided for @s60_multi_page.
  ///
  /// In en, this message translates to:
  /// **'Multi-page'**
  String get s60_multi_page;

  /// No description provided for @s60_notice.
  ///
  /// In en, this message translates to:
  /// **'Scans are encrypted before saving'**
  String get s60_notice;

  /// No description provided for @s61_title.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get s61_title;

  /// No description provided for @s61_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Medical records and reminders'**
  String get s61_subtitle;

  /// No description provided for @common_search_collection.
  ///
  /// In en, this message translates to:
  /// **'Search this collection...'**
  String get common_search_collection;

  /// No description provided for @s61_item_count.
  ///
  /// In en, this message translates to:
  /// **'22'**
  String get s61_item_count;

  /// No description provided for @s61_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'health items'**
  String get s61_item_count_label;

  /// No description provided for @s61_stat_medicines_value.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get s61_stat_medicines_value;

  /// No description provided for @s61_stat_medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get s61_stat_medicines;

  /// No description provided for @s61_stat_appointments_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s61_stat_appointments_value;

  /// No description provided for @s61_stat_appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get s61_stat_appointments;

  /// No description provided for @s61_stat_reports_value.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s61_stat_reports_value;

  /// No description provided for @s61_stat_reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get s61_stat_reports;

  /// No description provided for @s61_stat_due_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s61_stat_due_value;

  /// No description provided for @s61_stat_due.
  ///
  /// In en, this message translates to:
  /// **'Due Soon'**
  String get s61_stat_due;

  /// No description provided for @s61_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get s61_upcoming;

  /// No description provided for @s61_vitamin.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D3'**
  String get s61_vitamin;

  /// No description provided for @s61_vitamin_meta.
  ///
  /// In en, this message translates to:
  /// **'Today • 8:00 AM'**
  String get s61_vitamin_meta;

  /// No description provided for @s61_vitamin_status.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get s61_vitamin_status;

  /// No description provided for @s61_doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor Appointment'**
  String get s61_doctor;

  /// No description provided for @s61_doctor_meta.
  ///
  /// In en, this message translates to:
  /// **'15 May • 4:00 PM'**
  String get s61_doctor_meta;

  /// No description provided for @s61_doctor_status.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get s61_doctor_status;

  /// No description provided for @s61_blood.
  ///
  /// In en, this message translates to:
  /// **'Blood Test Report'**
  String get s61_blood;

  /// No description provided for @s61_blood_meta.
  ///
  /// In en, this message translates to:
  /// **'Added 2 days ago'**
  String get s61_blood_meta;

  /// No description provided for @s61_blood_status.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get s61_blood_status;

  /// No description provided for @s61_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s61_documents;

  /// No description provided for @s61_insurance_card.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance Card'**
  String get s61_insurance_card;

  /// No description provided for @s61_insurance_card_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 16 days'**
  String get s61_insurance_card_meta;

  /// No description provided for @s61_insurance_card_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s61_insurance_card_status;

  /// No description provided for @s61_prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription - April'**
  String get s61_prescription;

  /// No description provided for @s61_prescription_meta.
  ///
  /// In en, this message translates to:
  /// **'3 medicines listed'**
  String get s61_prescription_meta;

  /// No description provided for @s61_prescription_status.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get s61_prescription_status;

  /// No description provided for @s62_title.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get s62_title;

  /// No description provided for @s62_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Money, tax and investments'**
  String get s62_subtitle;

  /// No description provided for @s62_item_count.
  ///
  /// In en, this message translates to:
  /// **'38'**
  String get s62_item_count;

  /// No description provided for @s62_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'finance items'**
  String get s62_item_count_label;

  /// No description provided for @s62_income_value.
  ///
  /// In en, this message translates to:
  /// **'₹2.4L'**
  String get s62_income_value;

  /// No description provided for @s62_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get s62_income;

  /// No description provided for @s62_expenses_value.
  ///
  /// In en, this message translates to:
  /// **'₹68K'**
  String get s62_expenses_value;

  /// No description provided for @s62_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get s62_expenses;

  /// No description provided for @s62_statements_value.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s62_statements_value;

  /// No description provided for @s62_statements.
  ///
  /// In en, this message translates to:
  /// **'Statements'**
  String get s62_statements;

  /// No description provided for @s62_tax_docs_value.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s62_tax_docs_value;

  /// No description provided for @s62_tax_docs.
  ///
  /// In en, this message translates to:
  /// **'Tax Docs'**
  String get s62_tax_docs;

  /// No description provided for @s62_this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get s62_this_month;

  /// No description provided for @s62_salary.
  ///
  /// In en, this message translates to:
  /// **'Salary Slip - July'**
  String get s62_salary;

  /// No description provided for @s62_salary_meta.
  ///
  /// In en, this message translates to:
  /// **'Income • ₹1,25,000'**
  String get s62_salary_meta;

  /// No description provided for @s62_salary_status.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get s62_salary_status;

  /// No description provided for @s62_card_bill.
  ///
  /// In en, this message translates to:
  /// **'Credit Card Bill'**
  String get s62_card_bill;

  /// No description provided for @s62_card_bill_meta.
  ///
  /// In en, this message translates to:
  /// **'Due in 4 days • ₹18,420'**
  String get s62_card_bill_meta;

  /// No description provided for @s62_card_bill_status.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get s62_card_bill_status;

  /// No description provided for @s62_mutual_fund.
  ///
  /// In en, this message translates to:
  /// **'Mutual Fund Summary'**
  String get s62_mutual_fund;

  /// No description provided for @s62_mutual_fund_meta.
  ///
  /// In en, this message translates to:
  /// **'Updated yesterday'**
  String get s62_mutual_fund_meta;

  /// No description provided for @s62_mutual_fund_status.
  ///
  /// In en, this message translates to:
  /// **'Invest'**
  String get s62_mutual_fund_status;

  /// No description provided for @s62_pinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned Documents'**
  String get s62_pinned;

  /// No description provided for @s62_pan.
  ///
  /// In en, this message translates to:
  /// **'PAN Card'**
  String get s62_pan;

  /// No description provided for @s62_pan_meta.
  ///
  /// In en, this message translates to:
  /// **'Identity • 1.1 MB'**
  String get s62_pan_meta;

  /// No description provided for @s62_pan_status.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get s62_pan_status;

  /// No description provided for @s62_itr.
  ///
  /// In en, this message translates to:
  /// **'Income Tax Return 2025'**
  String get s62_itr;

  /// No description provided for @s62_itr_meta.
  ///
  /// In en, this message translates to:
  /// **'Filed • 2.8 MB'**
  String get s62_itr_meta;

  /// No description provided for @s62_itr_status.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get s62_itr_status;

  /// No description provided for @s63_title.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get s63_title;

  /// No description provided for @s63_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Home, land and ownership'**
  String get s63_subtitle;

  /// No description provided for @s63_item_count.
  ///
  /// In en, this message translates to:
  /// **'18'**
  String get s63_item_count;

  /// No description provided for @s63_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'property items'**
  String get s63_item_count_label;

  /// No description provided for @s63_properties_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s63_properties_value;

  /// No description provided for @s63_properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get s63_properties;

  /// No description provided for @s63_legal_value.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get s63_legal_value;

  /// No description provided for @s63_legal.
  ///
  /// In en, this message translates to:
  /// **'Legal Docs'**
  String get s63_legal;

  /// No description provided for @s63_payments_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s63_payments_value;

  /// No description provided for @s63_payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get s63_payments;

  /// No description provided for @s63_due_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s63_due_value;

  /// No description provided for @s63_due.
  ///
  /// In en, this message translates to:
  /// **'Due Soon'**
  String get s63_due;

  /// No description provided for @s63_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get s63_important;

  /// No description provided for @s63_sale_deed.
  ///
  /// In en, this message translates to:
  /// **'Sale Deed'**
  String get s63_sale_deed;

  /// No description provided for @s63_sale_deed_meta.
  ///
  /// In en, this message translates to:
  /// **'Apartment • 8.4 MB'**
  String get s63_sale_deed_meta;

  /// No description provided for @s63_sale_deed_status.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get s63_sale_deed_status;

  /// No description provided for @s63_tax_receipt.
  ///
  /// In en, this message translates to:
  /// **'Property Tax Receipt'**
  String get s63_tax_receipt;

  /// No description provided for @s63_tax_receipt_meta.
  ///
  /// In en, this message translates to:
  /// **'Paid for 2025'**
  String get s63_tax_receipt_meta;

  /// No description provided for @s63_tax_receipt_status.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get s63_tax_receipt_status;

  /// No description provided for @s63_loan.
  ///
  /// In en, this message translates to:
  /// **'Home Loan Agreement'**
  String get s63_loan;

  /// No description provided for @s63_loan_meta.
  ///
  /// In en, this message translates to:
  /// **'HDFC Bank • 14 pages'**
  String get s63_loan_meta;

  /// No description provided for @s63_loan_status.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get s63_loan_status;

  /// No description provided for @s63_maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get s63_maintenance;

  /// No description provided for @s63_society.
  ///
  /// In en, this message translates to:
  /// **'Society Maintenance'**
  String get s63_society;

  /// No description provided for @s63_society_meta.
  ///
  /// In en, this message translates to:
  /// **'Due 10 Aug • ₹4,500'**
  String get s63_society_meta;

  /// No description provided for @s63_society_status.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get s63_society_status;

  /// No description provided for @s63_home_insurance.
  ///
  /// In en, this message translates to:
  /// **'Home Insurance'**
  String get s63_home_insurance;

  /// No description provided for @s63_home_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 42 days'**
  String get s63_home_insurance_meta;

  /// No description provided for @s63_home_insurance_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s63_home_insurance_status;

  /// No description provided for @s64_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get s64_title;

  /// No description provided for @s64_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Documents, service and expenses'**
  String get s64_subtitle;

  /// No description provided for @s64_item_count.
  ///
  /// In en, this message translates to:
  /// **'14'**
  String get s64_item_count;

  /// No description provided for @s64_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'vehicle items'**
  String get s64_item_count_label;

  /// No description provided for @s64_vehicle_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s64_vehicle_value;

  /// No description provided for @s64_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get s64_vehicle;

  /// No description provided for @s64_documents_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s64_documents_value;

  /// No description provided for @s64_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s64_documents;

  /// No description provided for @s64_reminders_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s64_reminders_value;

  /// No description provided for @s64_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get s64_reminders;

  /// No description provided for @s64_fuel_value.
  ///
  /// In en, this message translates to:
  /// **'₹4.8K'**
  String get s64_fuel_value;

  /// No description provided for @s64_fuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get s64_fuel;

  /// No description provided for @s64_vehicle_documents.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Documents'**
  String get s64_vehicle_documents;

  /// No description provided for @s64_rc.
  ///
  /// In en, this message translates to:
  /// **'Registration Certificate'**
  String get s64_rc;

  /// No description provided for @s64_rc_meta.
  ///
  /// In en, this message translates to:
  /// **'KA 03 MN 4582'**
  String get s64_rc_meta;

  /// No description provided for @s64_rc_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s64_rc_status;

  /// No description provided for @s64_insurance.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get s64_insurance;

  /// No description provided for @s64_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 15 days'**
  String get s64_insurance_meta;

  /// No description provided for @s64_insurance_status.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get s64_insurance_status;

  /// No description provided for @s64_puc.
  ///
  /// In en, this message translates to:
  /// **'PUC Certificate'**
  String get s64_puc;

  /// No description provided for @s64_puc_meta.
  ///
  /// In en, this message translates to:
  /// **'Valid until 30 Sep'**
  String get s64_puc_meta;

  /// No description provided for @s64_puc_status.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get s64_puc_status;

  /// No description provided for @s64_service_expenses.
  ///
  /// In en, this message translates to:
  /// **'Service & Expenses'**
  String get s64_service_expenses;

  /// No description provided for @s64_last_service.
  ///
  /// In en, this message translates to:
  /// **'Last Service'**
  String get s64_last_service;

  /// No description provided for @s64_last_service_meta.
  ///
  /// In en, this message translates to:
  /// **'12 Jul • 18,450 km'**
  String get s64_last_service_meta;

  /// No description provided for @s64_last_service_status.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get s64_last_service_status;

  /// No description provided for @s64_fuel_log.
  ///
  /// In en, this message translates to:
  /// **'Fuel Log'**
  String get s64_fuel_log;

  /// No description provided for @s64_fuel_log_meta.
  ///
  /// In en, this message translates to:
  /// **'₹4,820 this month'**
  String get s64_fuel_log_meta;

  /// No description provided for @s64_fuel_log_status.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get s64_fuel_log_status;

  /// No description provided for @s65_title.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s65_title;

  /// No description provided for @s65_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Certificates and learning'**
  String get s65_subtitle;

  /// No description provided for @s65_item_count.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s65_item_count;

  /// No description provided for @s65_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'education items'**
  String get s65_item_count_label;

  /// No description provided for @s65_certificates_value.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s65_certificates_value;

  /// No description provided for @s65_certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get s65_certificates;

  /// No description provided for @s65_notes_value.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s65_notes_value;

  /// No description provided for @s65_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get s65_notes;

  /// No description provided for @s65_courses_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s65_courses_value;

  /// No description provided for @s65_courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get s65_courses;

  /// No description provided for @s65_reminder_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s65_reminder_value;

  /// No description provided for @s65_reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get s65_reminder;

  /// No description provided for @s65_certificates_section.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get s65_certificates_section;

  /// No description provided for @s65_degree.
  ///
  /// In en, this message translates to:
  /// **'B.Tech Degree'**
  String get s65_degree;

  /// No description provided for @s65_degree_meta.
  ///
  /// In en, this message translates to:
  /// **'Computer Science • 4.2 MB'**
  String get s65_degree_meta;

  /// No description provided for @s65_degree_status.
  ///
  /// In en, this message translates to:
  /// **'Degree'**
  String get s65_degree_status;

  /// No description provided for @s65_class_x.
  ///
  /// In en, this message translates to:
  /// **'Class X Certificate'**
  String get s65_class_x;

  /// No description provided for @s65_class_x_meta.
  ///
  /// In en, this message translates to:
  /// **'CBSE • 1.8 MB'**
  String get s65_class_x_meta;

  /// No description provided for @s65_class_x_status.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get s65_class_x_status;

  /// No description provided for @s65_course.
  ///
  /// In en, this message translates to:
  /// **'Course Certificate'**
  String get s65_course;

  /// No description provided for @s65_course_meta.
  ///
  /// In en, this message translates to:
  /// **'Flutter Advanced • 940 KB'**
  String get s65_course_meta;

  /// No description provided for @s65_course_status.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get s65_course_status;

  /// No description provided for @s65_learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get s65_learning;

  /// No description provided for @s65_study_notes.
  ///
  /// In en, this message translates to:
  /// **'Study Notes'**
  String get s65_study_notes;

  /// No description provided for @s65_study_notes_meta.
  ///
  /// In en, this message translates to:
  /// **'12 notes'**
  String get s65_study_notes_meta;

  /// No description provided for @s65_study_notes_status.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get s65_study_notes_status;

  /// No description provided for @s65_exam.
  ///
  /// In en, this message translates to:
  /// **'Exam Reminder'**
  String get s65_exam;

  /// No description provided for @s65_exam_meta.
  ///
  /// In en, this message translates to:
  /// **'20 Aug • 9:00 AM'**
  String get s65_exam_meta;

  /// No description provided for @s65_exam_status.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get s65_exam_status;

  /// No description provided for @s66_title.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get s66_title;

  /// No description provided for @s66_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your verified identity documents'**
  String get s66_subtitle;

  /// No description provided for @s66_item_count.
  ///
  /// In en, this message translates to:
  /// **'24'**
  String get s66_item_count;

  /// No description provided for @s66_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'identity items'**
  String get s66_item_count_label;

  /// No description provided for @s66_primary_value.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get s66_primary_value;

  /// No description provided for @s66_primary.
  ///
  /// In en, this message translates to:
  /// **'Primary IDs'**
  String get s66_primary;

  /// No description provided for @s66_verified_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s66_verified_value;

  /// No description provided for @s66_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s66_verified;

  /// No description provided for @s66_expiring_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s66_expiring_value;

  /// No description provided for @s66_expiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get s66_expiring;

  /// No description provided for @s66_copies_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s66_copies_value;

  /// No description provided for @s66_copies.
  ///
  /// In en, this message translates to:
  /// **'Copies'**
  String get s66_copies;

  /// No description provided for @s66_government.
  ///
  /// In en, this message translates to:
  /// **'Government IDs'**
  String get s66_government;

  /// No description provided for @s66_aadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get s66_aadhaar;

  /// No description provided for @s66_aadhaar_meta.
  ///
  /// In en, this message translates to:
  /// **'Updated 3 months ago'**
  String get s66_aadhaar_meta;

  /// No description provided for @s66_aadhaar_status.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s66_aadhaar_status;

  /// No description provided for @s66_pan.
  ///
  /// In en, this message translates to:
  /// **'PAN Card'**
  String get s66_pan;

  /// No description provided for @s66_pan_meta.
  ///
  /// In en, this message translates to:
  /// **'Permanent account number'**
  String get s66_pan_meta;

  /// No description provided for @s66_pan_status.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s66_pan_status;

  /// No description provided for @s66_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get s66_passport;

  /// No description provided for @s66_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires 14 Jun 2031'**
  String get s66_passport_meta;

  /// No description provided for @s66_passport_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s66_passport_status;

  /// No description provided for @s66_other.
  ///
  /// In en, this message translates to:
  /// **'Other Identity'**
  String get s66_other;

  /// No description provided for @s66_driving.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get s66_driving;

  /// No description provided for @s66_driving_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 26 days'**
  String get s66_driving_meta;

  /// No description provided for @s66_driving_status.
  ///
  /// In en, this message translates to:
  /// **'Due Soon'**
  String get s66_driving_status;

  /// No description provided for @s66_voter.
  ///
  /// In en, this message translates to:
  /// **'Voter ID'**
  String get s66_voter;

  /// No description provided for @s66_voter_meta.
  ///
  /// In en, this message translates to:
  /// **'Added 12 May'**
  String get s66_voter_meta;

  /// No description provided for @s66_voter_status.
  ///
  /// In en, this message translates to:
  /// **'Stored'**
  String get s66_voter_status;

  /// No description provided for @s67_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get s67_title;

  /// No description provided for @s67_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Policies, claims and renewals'**
  String get s67_subtitle;

  /// No description provided for @s67_item_count.
  ///
  /// In en, this message translates to:
  /// **'16'**
  String get s67_item_count;

  /// No description provided for @s67_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'insurance items'**
  String get s67_item_count_label;

  /// No description provided for @s67_policies_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s67_policies_value;

  /// No description provided for @s67_policies.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get s67_policies;

  /// No description provided for @s67_due_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s67_due_value;

  /// No description provided for @s67_due.
  ///
  /// In en, this message translates to:
  /// **'Due Soon'**
  String get s67_due;

  /// No description provided for @s67_receipts_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s67_receipts_value;

  /// No description provided for @s67_receipts.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get s67_receipts;

  /// No description provided for @s67_claim_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s67_claim_value;

  /// No description provided for @s67_claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get s67_claim;

  /// No description provided for @s67_policies_section.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get s67_policies_section;

  /// No description provided for @s67_health.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance'**
  String get s67_health;

  /// No description provided for @s67_health_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 16 days'**
  String get s67_health_meta;

  /// No description provided for @s67_health_status.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get s67_health_status;

  /// No description provided for @s67_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get s67_vehicle;

  /// No description provided for @s67_vehicle_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 15 days'**
  String get s67_vehicle_meta;

  /// No description provided for @s67_vehicle_status.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get s67_vehicle_status;

  /// No description provided for @s67_life.
  ///
  /// In en, this message translates to:
  /// **'Life Insurance'**
  String get s67_life;

  /// No description provided for @s67_life_meta.
  ///
  /// In en, this message translates to:
  /// **'Premium due 28 Aug'**
  String get s67_life_meta;

  /// No description provided for @s67_life_status.
  ///
  /// In en, this message translates to:
  /// **'Life'**
  String get s67_life_status;

  /// No description provided for @s67_claims.
  ///
  /// In en, this message translates to:
  /// **'Claims & Receipts'**
  String get s67_claims;

  /// No description provided for @s67_claim_form.
  ///
  /// In en, this message translates to:
  /// **'Claim Form'**
  String get s67_claim_form;

  /// No description provided for @s67_claim_form_meta.
  ///
  /// In en, this message translates to:
  /// **'Submitted 12 Apr'**
  String get s67_claim_form_meta;

  /// No description provided for @s67_claim_form_status.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get s67_claim_form_status;

  /// No description provided for @s67_premium.
  ///
  /// In en, this message translates to:
  /// **'Premium Receipt'**
  String get s67_premium;

  /// No description provided for @s67_premium_meta.
  ///
  /// In en, this message translates to:
  /// **'Paid 02 Jul'**
  String get s67_premium_meta;

  /// No description provided for @s67_premium_status.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get s67_premium_status;

  /// No description provided for @s68_title.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get s68_title;

  /// No description provided for @s68_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Trips, tickets and plans'**
  String get s68_subtitle;

  /// No description provided for @s68_item_count.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s68_item_count;

  /// No description provided for @s68_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'travel items'**
  String get s68_item_count_label;

  /// No description provided for @s68_trip_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s68_trip_value;

  /// No description provided for @s68_trip.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Trip'**
  String get s68_trip;

  /// No description provided for @s68_bookings_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s68_bookings_value;

  /// No description provided for @s68_bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get s68_bookings;

  /// No description provided for @s68_documents_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s68_documents_value;

  /// No description provided for @s68_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get s68_documents;

  /// No description provided for @s68_checklist_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s68_checklist_value;

  /// No description provided for @s68_checklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get s68_checklist;

  /// No description provided for @s68_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Trip'**
  String get s68_upcoming;

  /// No description provided for @s68_flight.
  ///
  /// In en, this message translates to:
  /// **'Flight Ticket'**
  String get s68_flight;

  /// No description provided for @s68_flight_meta.
  ///
  /// In en, this message translates to:
  /// **'Bengaluru → Singapore'**
  String get s68_flight_meta;

  /// No description provided for @s68_flight_status.
  ///
  /// In en, this message translates to:
  /// **'12 Sep'**
  String get s68_flight_status;

  /// No description provided for @s68_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel Booking'**
  String get s68_hotel;

  /// No description provided for @s68_hotel_meta.
  ///
  /// In en, this message translates to:
  /// **'Marina Bay • 4 nights'**
  String get s68_hotel_meta;

  /// No description provided for @s68_hotel_status.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get s68_hotel_status;

  /// No description provided for @s68_insurance.
  ///
  /// In en, this message translates to:
  /// **'Travel Insurance'**
  String get s68_insurance;

  /// No description provided for @s68_insurance_meta.
  ///
  /// In en, this message translates to:
  /// **'Valid 11–17 Sep'**
  String get s68_insurance_meta;

  /// No description provided for @s68_insurance_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s68_insurance_status;

  /// No description provided for @s68_travel_documents.
  ///
  /// In en, this message translates to:
  /// **'Travel Documents'**
  String get s68_travel_documents;

  /// No description provided for @s68_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport Copy'**
  String get s68_passport;

  /// No description provided for @s68_passport_meta.
  ///
  /// In en, this message translates to:
  /// **'Encrypted copy'**
  String get s68_passport_meta;

  /// No description provided for @s68_passport_status.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get s68_passport_status;

  /// No description provided for @s68_packing.
  ///
  /// In en, this message translates to:
  /// **'Packing Checklist'**
  String get s68_packing;

  /// No description provided for @s68_packing_meta.
  ///
  /// In en, this message translates to:
  /// **'18 items • 6 completed'**
  String get s68_packing_meta;

  /// No description provided for @s68_packing_status.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get s68_packing_status;

  /// No description provided for @s69_title.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get s69_title;

  /// No description provided for @s69_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Career and professional records'**
  String get s69_subtitle;

  /// No description provided for @s69_item_count.
  ///
  /// In en, this message translates to:
  /// **'9'**
  String get s69_item_count;

  /// No description provided for @s69_item_count_label.
  ///
  /// In en, this message translates to:
  /// **'work items'**
  String get s69_item_count_label;

  /// No description provided for @s69_employers_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s69_employers_value;

  /// No description provided for @s69_employers.
  ///
  /// In en, this message translates to:
  /// **'Employers'**
  String get s69_employers;

  /// No description provided for @s69_contracts_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s69_contracts_value;

  /// No description provided for @s69_contracts.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get s69_contracts;

  /// No description provided for @s69_payslips_value.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s69_payslips_value;

  /// No description provided for @s69_payslips.
  ///
  /// In en, this message translates to:
  /// **'Payslips'**
  String get s69_payslips;

  /// No description provided for @s69_projects_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get s69_projects_value;

  /// No description provided for @s69_projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get s69_projects;

  /// No description provided for @s69_employment.
  ///
  /// In en, this message translates to:
  /// **'Employment'**
  String get s69_employment;

  /// No description provided for @s69_contract.
  ///
  /// In en, this message translates to:
  /// **'Employment Contract'**
  String get s69_contract;

  /// No description provided for @s69_contract_meta.
  ///
  /// In en, this message translates to:
  /// **'CleanDesk AI • 14 pages'**
  String get s69_contract_meta;

  /// No description provided for @s69_contract_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s69_contract_status;

  /// No description provided for @s69_salary.
  ///
  /// In en, this message translates to:
  /// **'Salary Slip - July'**
  String get s69_salary;

  /// No description provided for @s69_salary_meta.
  ///
  /// In en, this message translates to:
  /// **'₹1,25,000 • PDF'**
  String get s69_salary_meta;

  /// No description provided for @s69_salary_status.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get s69_salary_status;

  /// No description provided for @s69_experience.
  ///
  /// In en, this message translates to:
  /// **'Experience Letter'**
  String get s69_experience;

  /// No description provided for @s69_experience_meta.
  ///
  /// In en, this message translates to:
  /// **'Previous employer • 2 pages'**
  String get s69_experience_meta;

  /// No description provided for @s69_experience_status.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get s69_experience_status;

  /// No description provided for @s69_projects_section.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get s69_projects_section;

  /// No description provided for @s69_notes.
  ///
  /// In en, this message translates to:
  /// **'Project Notes'**
  String get s69_notes;

  /// No description provided for @s69_notes_meta.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep • 28 notes'**
  String get s69_notes_meta;

  /// No description provided for @s69_notes_status.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get s69_notes_status;

  /// No description provided for @s69_portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio PDF'**
  String get s69_portfolio;

  /// No description provided for @s69_portfolio_meta.
  ///
  /// In en, this message translates to:
  /// **'Updated last week'**
  String get s69_portfolio_meta;

  /// No description provided for @s69_portfolio_status.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get s69_portfolio_status;

  /// No description provided for @s70_title.
  ///
  /// In en, this message translates to:
  /// **'Custom Collection'**
  String get s70_title;

  /// No description provided for @s70_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your own category'**
  String get s70_subtitle;

  /// No description provided for @s70_collection_name.
  ///
  /// In en, this message translates to:
  /// **'Collection Name'**
  String get s70_collection_name;

  /// No description provided for @s70_collection_value.
  ///
  /// In en, this message translates to:
  /// **'Family Records'**
  String get s70_collection_value;

  /// No description provided for @s70_choose_icon.
  ///
  /// In en, this message translates to:
  /// **'Choose Icon'**
  String get s70_choose_icon;

  /// No description provided for @s70_theme_color.
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get s70_theme_color;

  /// No description provided for @s70_smart_rules.
  ///
  /// In en, this message translates to:
  /// **'Smart Rules'**
  String get s70_smart_rules;

  /// No description provided for @s70_auto_tag.
  ///
  /// In en, this message translates to:
  /// **'Auto-add by tag'**
  String get s70_auto_tag;

  /// No description provided for @s70_auto_tag_body.
  ///
  /// In en, this message translates to:
  /// **'#family'**
  String get s70_auto_tag_body;

  /// No description provided for @s70_suggest.
  ///
  /// In en, this message translates to:
  /// **'Suggest reminders'**
  String get s70_suggest;

  /// No description provided for @s70_suggest_body.
  ///
  /// In en, this message translates to:
  /// **'From detected dates'**
  String get s70_suggest_body;

  /// No description provided for @s70_ai.
  ///
  /// In en, this message translates to:
  /// **'Allow AI organization'**
  String get s70_ai;

  /// No description provided for @s70_ai_body.
  ///
  /// In en, this message translates to:
  /// **'Runs only on device'**
  String get s70_ai_body;

  /// No description provided for @s70_home.
  ///
  /// In en, this message translates to:
  /// **'Show on Home'**
  String get s70_home;

  /// No description provided for @s70_home_body.
  ///
  /// In en, this message translates to:
  /// **'Pin as smart collection'**
  String get s70_home_body;

  /// No description provided for @s70_preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get s70_preview;

  /// No description provided for @s70_preview_name.
  ///
  /// In en, this message translates to:
  /// **'Family Records'**
  String get s70_preview_name;

  /// No description provided for @s70_preview_meta.
  ///
  /// In en, this message translates to:
  /// **'0 items • Ready to use'**
  String get s70_preview_meta;

  /// No description provided for @s70_create.
  ///
  /// In en, this message translates to:
  /// **'Create Collection'**
  String get s70_create;

  /// No description provided for @s71_title.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get s71_title;

  /// No description provided for @s71_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Private • On-device'**
  String get s71_subtitle;

  /// No description provided for @s71_greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Arjun 👋'**
  String get s71_greeting;

  /// No description provided for @s71_prompt.
  ///
  /// In en, this message translates to:
  /// **'How can I help with your vault?'**
  String get s71_prompt;

  /// No description provided for @s71_quick_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Find my vehicle insurance'**
  String get s71_quick_vehicle;

  /// No description provided for @s71_quick_expiring.
  ///
  /// In en, this message translates to:
  /// **'Show documents expiring soon'**
  String get s71_quick_expiring;

  /// No description provided for @s71_quick_health.
  ///
  /// In en, this message translates to:
  /// **'Summarize health reports'**
  String get s71_quick_health;

  /// No description provided for @s71_quick_travel.
  ///
  /// In en, this message translates to:
  /// **'How much did I spend on travel?'**
  String get s71_quick_travel;

  /// No description provided for @s71_ai_label.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get s71_ai_label;

  /// No description provided for @s71_response.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle insurance is in Vehicle › Documents. It expires in 15 days. I found the policy PDF and a renewal reminder.'**
  String get s71_response;

  /// No description provided for @s71_open_policy.
  ///
  /// In en, this message translates to:
  /// **'Open Insurance Policy'**
  String get s71_open_policy;

  /// No description provided for @s71_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Ask anything...'**
  String get s71_input_hint;

  /// No description provided for @s71_local_notice.
  ///
  /// In en, this message translates to:
  /// **'All AI processing happens on this device'**
  String get s71_local_notice;

  /// No description provided for @s72_title.
  ///
  /// In en, this message translates to:
  /// **'AI Insights'**
  String get s72_title;

  /// No description provided for @s72_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns found in your vault'**
  String get s72_subtitle;

  /// No description provided for @s72_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly Vault Insight'**
  String get s72_monthly;

  /// No description provided for @s72_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Your vault is getting healthier'**
  String get s72_hero_title;

  /// No description provided for @s72_hero_body.
  ///
  /// In en, this message translates to:
  /// **'You organized 34 documents, resolved 12 duplicates and added 6 expiry reminders this month.'**
  String get s72_hero_body;

  /// No description provided for @s72_organized_value.
  ///
  /// In en, this message translates to:
  /// **'34'**
  String get s72_organized_value;

  /// No description provided for @s72_organized.
  ///
  /// In en, this message translates to:
  /// **'Organized'**
  String get s72_organized;

  /// No description provided for @s72_duplicates_value.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get s72_duplicates_value;

  /// No description provided for @s72_duplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicates fixed'**
  String get s72_duplicates;

  /// No description provided for @s72_reminders_value.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s72_reminders_value;

  /// No description provided for @s72_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get s72_reminders;

  /// No description provided for @s72_space_value.
  ///
  /// In en, this message translates to:
  /// **'2.8 GB'**
  String get s72_space_value;

  /// No description provided for @s72_space.
  ///
  /// In en, this message translates to:
  /// **'Space saved'**
  String get s72_space;

  /// No description provided for @s72_insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get s72_insights;

  /// No description provided for @s72_tags_title.
  ///
  /// In en, this message translates to:
  /// **'12 documents need tags'**
  String get s72_tags_title;

  /// No description provided for @s72_tags_body.
  ///
  /// In en, this message translates to:
  /// **'Mostly insurance and finance files'**
  String get s72_tags_body;

  /// No description provided for @s72_expiry_title.
  ///
  /// In en, this message translates to:
  /// **'3 documents expire this month'**
  String get s72_expiry_title;

  /// No description provided for @s72_expiry_body.
  ///
  /// In en, this message translates to:
  /// **'Vehicle insurance, licence, health policy'**
  String get s72_expiry_body;

  /// No description provided for @s72_duplicate_title.
  ///
  /// In en, this message translates to:
  /// **'5 duplicate groups detected'**
  String get s72_duplicate_title;

  /// No description provided for @s72_duplicate_body.
  ///
  /// In en, this message translates to:
  /// **'Potentially save 1.4 GB'**
  String get s72_duplicate_body;

  /// No description provided for @s72_uncategorized_title.
  ///
  /// In en, this message translates to:
  /// **'8 files are uncategorized'**
  String get s72_uncategorized_title;

  /// No description provided for @s72_uncategorized_body.
  ///
  /// In en, this message translates to:
  /// **'AI can organize them automatically'**
  String get s72_uncategorized_body;

  /// No description provided for @s72_outdated_title.
  ///
  /// In en, this message translates to:
  /// **'2 reminders may be outdated'**
  String get s72_outdated_title;

  /// No description provided for @s72_outdated_body.
  ///
  /// In en, this message translates to:
  /// **'Review and update due dates'**
  String get s72_outdated_body;

  /// No description provided for @s73_title.
  ///
  /// In en, this message translates to:
  /// **'Smart Suggestions'**
  String get s73_title;

  /// No description provided for @s73_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Review before applying'**
  String get s73_subtitle;

  /// No description provided for @filter_organize.
  ///
  /// In en, this message translates to:
  /// **'Organize'**
  String get filter_organize;

  /// No description provided for @filter_cleanup.
  ///
  /// In en, this message translates to:
  /// **'Cleanup'**
  String get filter_cleanup;

  /// No description provided for @s73_move_title.
  ///
  /// In en, this message translates to:
  /// **'Move 4 files to Insurance'**
  String get s73_move_title;

  /// No description provided for @s73_move_body.
  ///
  /// In en, this message translates to:
  /// **'Detected policy documents in Finance'**
  String get s73_move_body;

  /// No description provided for @common_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get common_apply;

  /// No description provided for @s73_tag_title.
  ///
  /// In en, this message translates to:
  /// **'Add #identity tag to 3 files'**
  String get s73_tag_title;

  /// No description provided for @s73_tag_body.
  ///
  /// In en, this message translates to:
  /// **'Passport, PAN and Aadhaar'**
  String get s73_tag_body;

  /// No description provided for @s73_expiry_title.
  ///
  /// In en, this message translates to:
  /// **'Create expiry reminder'**
  String get s73_expiry_title;

  /// No description provided for @s73_expiry_body.
  ///
  /// In en, this message translates to:
  /// **'Driving licence expires in 26 days'**
  String get s73_expiry_body;

  /// No description provided for @common_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get common_add;

  /// No description provided for @s73_duplicate_title.
  ///
  /// In en, this message translates to:
  /// **'Merge duplicate receipts'**
  String get s73_duplicate_title;

  /// No description provided for @s73_duplicate_body.
  ///
  /// In en, this message translates to:
  /// **'Two identical premium receipts'**
  String get s73_duplicate_body;

  /// No description provided for @common_review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get common_review;

  /// No description provided for @s73_rename_title.
  ///
  /// In en, this message translates to:
  /// **'Rename unclear document'**
  String get s73_rename_title;

  /// No description provided for @s73_rename_body.
  ///
  /// In en, this message translates to:
  /// **'IMG_2045 → Health Report - May'**
  String get s73_rename_body;

  /// No description provided for @common_rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get common_rename;

  /// No description provided for @s73_archive_title.
  ///
  /// In en, this message translates to:
  /// **'Archive old policy'**
  String get s73_archive_title;

  /// No description provided for @s73_archive_body.
  ///
  /// In en, this message translates to:
  /// **'Policy expired 8 months ago'**
  String get s73_archive_body;

  /// No description provided for @common_archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get common_archive;

  /// No description provided for @s73_apply_selected.
  ///
  /// In en, this message translates to:
  /// **'Apply Selected Suggestions'**
  String get s73_apply_selected;

  /// No description provided for @s74_title.
  ///
  /// In en, this message translates to:
  /// **'Similar Documents'**
  String get s74_title;

  /// No description provided for @s74_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Group related files'**
  String get s74_subtitle;

  /// No description provided for @s74_found.
  ///
  /// In en, this message translates to:
  /// **'4 similarity groups found'**
  String get s74_found;

  /// No description provided for @s74_local.
  ///
  /// In en, this message translates to:
  /// **'AI compares text and file structure locally'**
  String get s74_local;

  /// No description provided for @s74_percent.
  ///
  /// In en, this message translates to:
  /// **'92%'**
  String get s74_percent;

  /// No description provided for @s74_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance Policies'**
  String get s74_vehicle;

  /// No description provided for @s74_vehicle_meta.
  ///
  /// In en, this message translates to:
  /// **'3 files • 88–96% similar'**
  String get s74_vehicle_meta;

  /// No description provided for @s74_salary.
  ///
  /// In en, this message translates to:
  /// **'Salary Slips - 2025'**
  String get s74_salary;

  /// No description provided for @s74_salary_meta.
  ///
  /// In en, this message translates to:
  /// **'6 files • Same layout'**
  String get s74_salary_meta;

  /// No description provided for @s74_health.
  ///
  /// In en, this message translates to:
  /// **'Health Reports'**
  String get s74_health;

  /// No description provided for @s74_health_meta.
  ///
  /// In en, this message translates to:
  /// **'4 files • Same hospital'**
  String get s74_health_meta;

  /// No description provided for @s74_property.
  ///
  /// In en, this message translates to:
  /// **'Property Tax Receipts'**
  String get s74_property;

  /// No description provided for @s74_property_meta.
  ///
  /// In en, this message translates to:
  /// **'3 files • Same property'**
  String get s74_property_meta;

  /// No description provided for @common_preview_group.
  ///
  /// In en, this message translates to:
  /// **'Preview Group'**
  String get common_preview_group;

  /// No description provided for @common_organize.
  ///
  /// In en, this message translates to:
  /// **'Organize'**
  String get common_organize;

  /// No description provided for @s75_title.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Resolution'**
  String get s75_title;

  /// No description provided for @s75_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose what to keep'**
  String get s75_subtitle;

  /// No description provided for @s75_group.
  ///
  /// In en, this message translates to:
  /// **'Group 1 of 5'**
  String get s75_group;

  /// No description provided for @s75_group_title.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy duplicates'**
  String get s75_group_title;

  /// No description provided for @s75_group_size.
  ///
  /// In en, this message translates to:
  /// **'2.4 MB'**
  String get s75_group_size;

  /// No description provided for @s75_current_name.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s75_current_name;

  /// No description provided for @s75_current_meta.
  ///
  /// In en, this message translates to:
  /// **'Added today • 2.4 MB'**
  String get s75_current_meta;

  /// No description provided for @s75_current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get s75_current;

  /// No description provided for @s75_duplicate_name.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy Copy.pdf'**
  String get s75_duplicate_name;

  /// No description provided for @s75_duplicate_meta.
  ///
  /// In en, this message translates to:
  /// **'Added 2 days ago • 2.4 MB'**
  String get s75_duplicate_meta;

  /// No description provided for @s75_duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get s75_duplicate;

  /// No description provided for @s75_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get s75_recommended;

  /// No description provided for @s75_recommendation.
  ///
  /// In en, this message translates to:
  /// **'Keep the newer file and delete the copy'**
  String get s75_recommendation;

  /// No description provided for @s75_keep_selected.
  ///
  /// In en, this message translates to:
  /// **'Keep Selected & Delete Duplicate'**
  String get s75_keep_selected;

  /// No description provided for @s75_keep_both.
  ///
  /// In en, this message translates to:
  /// **'Keep Both Files'**
  String get s75_keep_both;

  /// No description provided for @s76_title.
  ///
  /// In en, this message translates to:
  /// **'AI Timeline'**
  String get s76_title;

  /// No description provided for @s76_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A meaningful view of your life'**
  String get s76_subtitle;

  /// No description provided for @filter_events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get filter_events;

  /// No description provided for @filter_insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get filter_insights;

  /// No description provided for @date_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get date_today;

  /// No description provided for @date_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get date_yesterday;

  /// No description provided for @date_12_july.
  ///
  /// In en, this message translates to:
  /// **'12 July'**
  String get date_12_july;

  /// No description provided for @date_10_june.
  ///
  /// In en, this message translates to:
  /// **'10 June'**
  String get date_10_june;

  /// No description provided for @date_15_may.
  ///
  /// In en, this message translates to:
  /// **'15 May'**
  String get date_15_may;

  /// No description provided for @date_03_april.
  ///
  /// In en, this message translates to:
  /// **'03 April'**
  String get date_03_april;

  /// No description provided for @s76_vehicle_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle insurance reminder created'**
  String get s76_vehicle_title;

  /// No description provided for @s76_vehicle_body.
  ///
  /// In en, this message translates to:
  /// **'Expires in 15 days'**
  String get s76_vehicle_body;

  /// No description provided for @s76_health_title.
  ///
  /// In en, this message translates to:
  /// **'Health report added'**
  String get s76_health_title;

  /// No description provided for @s76_health_body.
  ///
  /// In en, this message translates to:
  /// **'AI detected 4 lab values'**
  String get s76_health_body;

  /// No description provided for @s76_service_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle serviced'**
  String get s76_service_title;

  /// No description provided for @s76_service_body.
  ///
  /// In en, this message translates to:
  /// **'Odometer: 18,450 km'**
  String get s76_service_body;

  /// No description provided for @s76_passport_title.
  ///
  /// In en, this message translates to:
  /// **'Passport document updated'**
  String get s76_passport_title;

  /// No description provided for @s76_passport_body.
  ///
  /// In en, this message translates to:
  /// **'New scan replaced older copy'**
  String get s76_passport_body;

  /// No description provided for @s76_doctor_title.
  ///
  /// In en, this message translates to:
  /// **'Doctor appointment'**
  String get s76_doctor_title;

  /// No description provided for @s76_doctor_body.
  ///
  /// In en, this message translates to:
  /// **'Dr. R. Sharma • 4:00 PM'**
  String get s76_doctor_body;

  /// No description provided for @s76_tax_title.
  ///
  /// In en, this message translates to:
  /// **'Income tax return filed'**
  String get s76_tax_title;

  /// No description provided for @s76_tax_body.
  ///
  /// In en, this message translates to:
  /// **'FY 2024–25'**
  String get s76_tax_body;

  /// No description provided for @s77_title.
  ///
  /// In en, this message translates to:
  /// **'Auto Tagging'**
  String get s77_title;

  /// No description provided for @s77_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Review AI tag suggestions'**
  String get s77_subtitle;

  /// No description provided for @s77_ready.
  ///
  /// In en, this message translates to:
  /// **'8 files ready for tagging'**
  String get s77_ready;

  /// No description provided for @s77_ready_body.
  ///
  /// In en, this message translates to:
  /// **'Tags are suggested using on-device text analysis'**
  String get s77_ready_body;

  /// No description provided for @s77_apply_all.
  ///
  /// In en, this message translates to:
  /// **'Apply All'**
  String get s77_apply_all;

  /// No description provided for @s77_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport.pdf'**
  String get s77_passport;

  /// No description provided for @tag_identity.
  ///
  /// In en, this message translates to:
  /// **'#identity'**
  String get tag_identity;

  /// No description provided for @tag_passport.
  ///
  /// In en, this message translates to:
  /// **'#passport'**
  String get tag_passport;

  /// No description provided for @tag_important.
  ///
  /// In en, this message translates to:
  /// **'#important'**
  String get tag_important;

  /// No description provided for @s77_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy.pdf'**
  String get s77_insurance;

  /// No description provided for @tag_insurance.
  ///
  /// In en, this message translates to:
  /// **'#insurance'**
  String get tag_insurance;

  /// No description provided for @tag_health.
  ///
  /// In en, this message translates to:
  /// **'#health'**
  String get tag_health;

  /// No description provided for @tag_expiry.
  ///
  /// In en, this message translates to:
  /// **'#expiry'**
  String get tag_expiry;

  /// No description provided for @s77_salary.
  ///
  /// In en, this message translates to:
  /// **'Salary Slip - July.pdf'**
  String get s77_salary;

  /// No description provided for @tag_finance.
  ///
  /// In en, this message translates to:
  /// **'#finance'**
  String get tag_finance;

  /// No description provided for @tag_salary.
  ///
  /// In en, this message translates to:
  /// **'#salary'**
  String get tag_salary;

  /// No description provided for @tag_2025.
  ///
  /// In en, this message translates to:
  /// **'#2025'**
  String get tag_2025;

  /// No description provided for @s77_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence.jpg'**
  String get s77_licence;

  /// No description provided for @tag_vehicle.
  ///
  /// In en, this message translates to:
  /// **'#vehicle'**
  String get tag_vehicle;

  /// No description provided for @s77_deed.
  ///
  /// In en, this message translates to:
  /// **'Sale Deed.pdf'**
  String get s77_deed;

  /// No description provided for @tag_property.
  ///
  /// In en, this message translates to:
  /// **'#property'**
  String get tag_property;

  /// No description provided for @tag_legal.
  ///
  /// In en, this message translates to:
  /// **'#legal'**
  String get tag_legal;

  /// No description provided for @s77_review_tags.
  ///
  /// In en, this message translates to:
  /// **'Review Tags'**
  String get s77_review_tags;

  /// No description provided for @s78_title.
  ///
  /// In en, this message translates to:
  /// **'AI Search Results'**
  String get s78_title;

  /// No description provided for @s78_question.
  ///
  /// In en, this message translates to:
  /// **'Question: What expires soon?'**
  String get s78_question;

  /// No description provided for @s78_summary_label.
  ///
  /// In en, this message translates to:
  /// **'AI Summary'**
  String get s78_summary_label;

  /// No description provided for @s78_summary.
  ///
  /// In en, this message translates to:
  /// **'Three important documents expire within the next 30 days. Vehicle insurance is the most urgent.'**
  String get s78_summary;

  /// No description provided for @s78_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get s78_vehicle;

  /// No description provided for @s78_vehicle_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 15 days • 20 Aug 2026'**
  String get s78_vehicle_meta;

  /// No description provided for @s78_vehicle_days.
  ///
  /// In en, this message translates to:
  /// **'15 days'**
  String get s78_vehicle_days;

  /// No description provided for @s78_health.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance'**
  String get s78_health;

  /// No description provided for @s78_health_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 16 days • 21 Aug 2026'**
  String get s78_health_meta;

  /// No description provided for @s78_health_days.
  ///
  /// In en, this message translates to:
  /// **'16 days'**
  String get s78_health_days;

  /// No description provided for @s78_licence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get s78_licence;

  /// No description provided for @s78_licence_meta.
  ///
  /// In en, this message translates to:
  /// **'Expires in 26 days • 31 Aug 2026'**
  String get s78_licence_meta;

  /// No description provided for @s78_licence_days.
  ///
  /// In en, this message translates to:
  /// **'26 days'**
  String get s78_licence_days;

  /// No description provided for @s78_suggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested Actions'**
  String get s78_suggested;

  /// No description provided for @s78_create_title.
  ///
  /// In en, this message translates to:
  /// **'Create renewal reminders'**
  String get s78_create_title;

  /// No description provided for @s78_create_body.
  ///
  /// In en, this message translates to:
  /// **'Add reminders 7 days before expiry'**
  String get s78_create_body;

  /// No description provided for @s78_open_title.
  ///
  /// In en, this message translates to:
  /// **'Open vehicle insurance'**
  String get s78_open_title;

  /// No description provided for @s78_open_body.
  ///
  /// In en, this message translates to:
  /// **'Review policy details'**
  String get s78_open_body;

  /// No description provided for @s78_compare_title.
  ///
  /// In en, this message translates to:
  /// **'Compare current policies'**
  String get s78_compare_title;

  /// No description provided for @s78_compare_body.
  ///
  /// In en, this message translates to:
  /// **'See coverage and premium changes'**
  String get s78_compare_body;

  /// No description provided for @s78_create_all.
  ///
  /// In en, this message translates to:
  /// **'Create All Reminders'**
  String get s78_create_all;

  /// No description provided for @s79_title.
  ///
  /// In en, this message translates to:
  /// **'AI Settings'**
  String get s79_title;

  /// No description provided for @s79_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Control local intelligence'**
  String get s79_subtitle;

  /// No description provided for @s79_private_title.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get s79_private_title;

  /// No description provided for @s79_private_body.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep AI runs on your device. Your documents and prompts are never uploaded.'**
  String get s79_private_body;

  /// No description provided for @s79_assistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get s79_assistant;

  /// No description provided for @s79_assistant_body.
  ///
  /// In en, this message translates to:
  /// **'Enable private vault chat'**
  String get s79_assistant_body;

  /// No description provided for @s79_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Smart Suggestions'**
  String get s79_suggestions;

  /// No description provided for @s79_suggestions_body.
  ///
  /// In en, this message translates to:
  /// **'Recommend organization actions'**
  String get s79_suggestions_body;

  /// No description provided for @s79_tagging.
  ///
  /// In en, this message translates to:
  /// **'Auto Tagging'**
  String get s79_tagging;

  /// No description provided for @s79_tagging_body.
  ///
  /// In en, this message translates to:
  /// **'Suggest tags from document text'**
  String get s79_tagging_body;

  /// No description provided for @s79_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry Detection'**
  String get s79_expiry;

  /// No description provided for @s79_expiry_body.
  ///
  /// In en, this message translates to:
  /// **'Find dates and create suggestions'**
  String get s79_expiry_body;

  /// No description provided for @s79_similar.
  ///
  /// In en, this message translates to:
  /// **'Similar Document Groups'**
  String get s79_similar;

  /// No description provided for @s79_similar_body.
  ///
  /// In en, this message translates to:
  /// **'Detect related files'**
  String get s79_similar_body;

  /// No description provided for @s79_history.
  ///
  /// In en, this message translates to:
  /// **'AI Activity History'**
  String get s79_history;

  /// No description provided for @s79_history_body.
  ///
  /// In en, this message translates to:
  /// **'Save local prompt history'**
  String get s79_history_body;

  /// No description provided for @s79_background.
  ///
  /// In en, this message translates to:
  /// **'Background Analysis'**
  String get s79_background;

  /// No description provided for @s79_background_body.
  ///
  /// In en, this message translates to:
  /// **'Analyze while charging'**
  String get s79_background_body;

  /// No description provided for @s79_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear AI History'**
  String get s79_clear;

  /// No description provided for @s79_clear_body.
  ///
  /// In en, this message translates to:
  /// **'Deletes prompts and local AI results'**
  String get s79_clear_body;

  /// No description provided for @s80_title.
  ///
  /// In en, this message translates to:
  /// **'AI History'**
  String get s80_title;

  /// No description provided for @s80_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Local conversations and actions'**
  String get s80_subtitle;

  /// No description provided for @filter_chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get filter_chats;

  /// No description provided for @filter_searches.
  ///
  /// In en, this message translates to:
  /// **'Searches'**
  String get filter_searches;

  /// No description provided for @filter_actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get filter_actions;

  /// No description provided for @s80_vehicle_title.
  ///
  /// In en, this message translates to:
  /// **'Find my vehicle insurance'**
  String get s80_vehicle_title;

  /// No description provided for @s80_vehicle_body.
  ///
  /// In en, this message translates to:
  /// **'Opened policy and expiry reminder'**
  String get s80_vehicle_body;

  /// No description provided for @s80_vehicle_time.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM'**
  String get s80_vehicle_time;

  /// No description provided for @s80_expiry_title.
  ///
  /// In en, this message translates to:
  /// **'What expires this month?'**
  String get s80_expiry_title;

  /// No description provided for @s80_expiry_body.
  ///
  /// In en, this message translates to:
  /// **'Found 3 documents'**
  String get s80_expiry_body;

  /// No description provided for @s80_expiry_time.
  ///
  /// In en, this message translates to:
  /// **'Today, 9:15 AM'**
  String get s80_expiry_time;

  /// No description provided for @s80_finance_title.
  ///
  /// In en, this message translates to:
  /// **'Organize my finance files'**
  String get s80_finance_title;

  /// No description provided for @s80_finance_body.
  ///
  /// In en, this message translates to:
  /// **'Moved 4 files and added 6 tags'**
  String get s80_finance_body;

  /// No description provided for @s80_finance_time.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 7:40 PM'**
  String get s80_finance_time;

  /// No description provided for @s80_health_title.
  ///
  /// In en, this message translates to:
  /// **'Summarize health report'**
  String get s80_health_title;

  /// No description provided for @s80_health_body.
  ///
  /// In en, this message translates to:
  /// **'Generated local summary'**
  String get s80_health_body;

  /// No description provided for @s80_health_time.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 4:20 PM'**
  String get s80_health_time;

  /// No description provided for @s80_duplicate_title.
  ///
  /// In en, this message translates to:
  /// **'Detect duplicate receipts'**
  String get s80_duplicate_title;

  /// No description provided for @s80_duplicate_body.
  ///
  /// In en, this message translates to:
  /// **'Resolved 2 duplicate groups'**
  String get s80_duplicate_body;

  /// No description provided for @s80_duplicate_time.
  ///
  /// In en, this message translates to:
  /// **'12 May, 11:10 AM'**
  String get s80_duplicate_time;

  /// No description provided for @s80_reminder_title.
  ///
  /// In en, this message translates to:
  /// **'Create passport reminder'**
  String get s80_reminder_title;

  /// No description provided for @s80_reminder_body.
  ///
  /// In en, this message translates to:
  /// **'Reminder created for 2031'**
  String get s80_reminder_body;

  /// No description provided for @s80_reminder_time.
  ///
  /// In en, this message translates to:
  /// **'10 May, 8:45 AM'**
  String get s80_reminder_time;

  /// No description provided for @s80_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear AI History'**
  String get s80_clear;

  /// No description provided for @s80_local_notice.
  ///
  /// In en, this message translates to:
  /// **'History is stored only on this device'**
  String get s80_local_notice;

  /// No description provided for @s81_title.
  ///
  /// In en, this message translates to:
  /// **'Family Vault'**
  String get s81_title;

  /// No description provided for @s81_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Private sharing without cloud accounts'**
  String get s81_subtitle;

  /// No description provided for @s81_family.
  ///
  /// In en, this message translates to:
  /// **'Our Family'**
  String get s81_family;

  /// No description provided for @s81_family_summary.
  ///
  /// In en, this message translates to:
  /// **'4 members • 6 shared collections'**
  String get s81_family_summary;

  /// No description provided for @s81_manage_members.
  ///
  /// In en, this message translates to:
  /// **'Manage Members'**
  String get s81_manage_members;

  /// No description provided for @s81_shared_collections.
  ///
  /// In en, this message translates to:
  /// **'Shared Collections'**
  String get s81_shared_collections;

  /// No description provided for @s81_family_documents.
  ///
  /// In en, this message translates to:
  /// **'Family Documents'**
  String get s81_family_documents;

  /// No description provided for @s81_family_documents_count.
  ///
  /// In en, this message translates to:
  /// **'28 items'**
  String get s81_family_documents_count;

  /// No description provided for @s81_family_documents_scope.
  ///
  /// In en, this message translates to:
  /// **'All Members'**
  String get s81_family_documents_scope;

  /// No description provided for @s81_health_records.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get s81_health_records;

  /// No description provided for @s81_health_records_count.
  ///
  /// In en, this message translates to:
  /// **'16 items'**
  String get s81_health_records_count;

  /// No description provided for @s81_health_records_scope.
  ///
  /// In en, this message translates to:
  /// **'Parents'**
  String get s81_health_records_scope;

  /// No description provided for @s81_property_papers.
  ///
  /// In en, this message translates to:
  /// **'Property Papers'**
  String get s81_property_papers;

  /// No description provided for @s81_property_papers_count.
  ///
  /// In en, this message translates to:
  /// **'9 items'**
  String get s81_property_papers_count;

  /// No description provided for @s81_property_papers_scope.
  ///
  /// In en, this message translates to:
  /// **'Adults'**
  String get s81_property_papers_scope;

  /// No description provided for @s81_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s81_education;

  /// No description provided for @s81_education_count.
  ///
  /// In en, this message translates to:
  /// **'12 items'**
  String get s81_education_count;

  /// No description provided for @s81_education_scope.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get s81_education_scope;

  /// No description provided for @s81_emergency_pack.
  ///
  /// In en, this message translates to:
  /// **'Emergency Pack'**
  String get s81_emergency_pack;

  /// No description provided for @s81_emergency_pack_count.
  ///
  /// In en, this message translates to:
  /// **'6 items'**
  String get s81_emergency_pack_count;

  /// No description provided for @s81_emergency_pack_scope.
  ///
  /// In en, this message translates to:
  /// **'Trusted'**
  String get s81_emergency_pack_scope;

  /// No description provided for @s81_offline_sharing.
  ///
  /// In en, this message translates to:
  /// **'Offline sharing'**
  String get s81_offline_sharing;

  /// No description provided for @s81_offline_sharing_body.
  ///
  /// In en, this message translates to:
  /// **'Use QR, nearby transfer, or encrypted package'**
  String get s81_offline_sharing_body;

  /// No description provided for @s81_add_member.
  ///
  /// In en, this message translates to:
  /// **'Add Family Member'**
  String get s81_add_member;

  /// No description provided for @s82_title.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get s82_title;

  /// No description provided for @s82_member_count.
  ///
  /// In en, this message translates to:
  /// **'4 members'**
  String get s82_member_count;

  /// No description provided for @member_arjun.
  ///
  /// In en, this message translates to:
  /// **'Arjun Sharma'**
  String get member_arjun;

  /// No description provided for @s82_arjun_meta.
  ///
  /// In en, this message translates to:
  /// **'Owner • This device'**
  String get s82_arjun_meta;

  /// No description provided for @role_owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get role_owner;

  /// No description provided for @member_harika.
  ///
  /// In en, this message translates to:
  /// **'Harika'**
  String get member_harika;

  /// No description provided for @s82_harika_meta.
  ///
  /// In en, this message translates to:
  /// **'Adult • Full access'**
  String get s82_harika_meta;

  /// No description provided for @status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get status_active;

  /// No description provided for @member_alekhya.
  ///
  /// In en, this message translates to:
  /// **'Alekhya'**
  String get member_alekhya;

  /// No description provided for @s82_alekhya_meta.
  ///
  /// In en, this message translates to:
  /// **'Child • Limited access'**
  String get s82_alekhya_meta;

  /// No description provided for @member_charvika.
  ///
  /// In en, this message translates to:
  /// **'Charvika'**
  String get member_charvika;

  /// No description provided for @s82_charvika_meta.
  ///
  /// In en, this message translates to:
  /// **'Child • Limited access'**
  String get s82_charvika_meta;

  /// No description provided for @s82_access_summary.
  ///
  /// In en, this message translates to:
  /// **'Access Summary'**
  String get s82_access_summary;

  /// No description provided for @s82_members_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get s82_members_value;

  /// No description provided for @s82_members_label.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get s82_members_label;

  /// No description provided for @s82_collections_value.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get s82_collections_value;

  /// No description provided for @s82_collections_label.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get s82_collections_label;

  /// No description provided for @s82_trusted_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get s82_trusted_value;

  /// No description provided for @s82_trusted_label.
  ///
  /// In en, this message translates to:
  /// **'Trusted'**
  String get s82_trusted_label;

  /// No description provided for @s82_pending_value.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get s82_pending_value;

  /// No description provided for @s82_pending_label.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get s82_pending_label;

  /// No description provided for @s82_transfer_options.
  ///
  /// In en, this message translates to:
  /// **'Transfer Options'**
  String get s82_transfer_options;

  /// No description provided for @s82_nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby Transfer'**
  String get s82_nearby;

  /// No description provided for @s82_nearby_body.
  ///
  /// In en, this message translates to:
  /// **'Share encrypted access on local network'**
  String get s82_nearby_body;

  /// No description provided for @s82_qr.
  ///
  /// In en, this message translates to:
  /// **'QR Invitation'**
  String get s82_qr;

  /// No description provided for @s82_qr_body.
  ///
  /// In en, this message translates to:
  /// **'Scan on another device'**
  String get s82_qr_body;

  /// No description provided for @s82_package.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Package'**
  String get s82_package;

  /// No description provided for @s82_package_body.
  ///
  /// In en, this message translates to:
  /// **'Export an offline invitation file'**
  String get s82_package_body;

  /// No description provided for @s83_title.
  ///
  /// In en, this message translates to:
  /// **'Invite Member'**
  String get s83_title;

  /// No description provided for @s83_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an offline encrypted invitation'**
  String get s83_subtitle;

  /// No description provided for @s83_member_name.
  ///
  /// In en, this message translates to:
  /// **'Member Name'**
  String get s83_member_name;

  /// No description provided for @s83_member_name_value.
  ///
  /// In en, this message translates to:
  /// **'Harika'**
  String get s83_member_name_value;

  /// No description provided for @s83_role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get s83_role;

  /// No description provided for @role_adult.
  ///
  /// In en, this message translates to:
  /// **'Adult'**
  String get role_adult;

  /// No description provided for @role_adult_body.
  ///
  /// In en, this message translates to:
  /// **'Full family access'**
  String get role_adult_body;

  /// No description provided for @role_child.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get role_child;

  /// No description provided for @role_child_body.
  ///
  /// In en, this message translates to:
  /// **'Limited by collection'**
  String get role_child_body;

  /// No description provided for @role_trusted.
  ///
  /// In en, this message translates to:
  /// **'Trusted Contact'**
  String get role_trusted;

  /// No description provided for @role_trusted_body.
  ///
  /// In en, this message translates to:
  /// **'Emergency-only access'**
  String get role_trusted_body;

  /// No description provided for @s83_invitation_method.
  ///
  /// In en, this message translates to:
  /// **'Invitation Method'**
  String get s83_invitation_method;

  /// No description provided for @s83_qr.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get s83_qr;

  /// No description provided for @s83_qr_body.
  ///
  /// In en, this message translates to:
  /// **'Scan directly on the second device'**
  String get s83_qr_body;

  /// No description provided for @s83_nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby Transfer'**
  String get s83_nearby;

  /// No description provided for @s83_nearby_body.
  ///
  /// In en, this message translates to:
  /// **'Send over local network'**
  String get s83_nearby_body;

  /// No description provided for @s83_file.
  ///
  /// In en, this message translates to:
  /// **'Encrypted File'**
  String get s83_file;

  /// No description provided for @s83_file_body.
  ///
  /// In en, this message translates to:
  /// **'Save a portable invitation package'**
  String get s83_file_body;

  /// No description provided for @s83_expires_label.
  ///
  /// In en, this message translates to:
  /// **'Invitation expires'**
  String get s83_expires_label;

  /// No description provided for @s83_expires_value.
  ///
  /// In en, this message translates to:
  /// **'24 hours after creation'**
  String get s83_expires_value;

  /// No description provided for @common_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get common_change;

  /// No description provided for @s83_create.
  ///
  /// In en, this message translates to:
  /// **'Create Invitation'**
  String get s83_create;

  /// No description provided for @s84_title.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get s84_title;

  /// No description provided for @s84_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Harika • Adult'**
  String get s84_subtitle;

  /// No description provided for @s84_member_meta.
  ///
  /// In en, this message translates to:
  /// **'Family member • Active'**
  String get s84_member_meta;

  /// No description provided for @s84_general_access.
  ///
  /// In en, this message translates to:
  /// **'General Access'**
  String get s84_general_access;

  /// No description provided for @s84_view.
  ///
  /// In en, this message translates to:
  /// **'View shared collections'**
  String get s84_view;

  /// No description provided for @s84_view_body.
  ///
  /// In en, this message translates to:
  /// **'Can open permitted items'**
  String get s84_view_body;

  /// No description provided for @s84_add.
  ///
  /// In en, this message translates to:
  /// **'Add documents'**
  String get s84_add;

  /// No description provided for @s84_add_body.
  ///
  /// In en, this message translates to:
  /// **'Can add files to shared collections'**
  String get s84_add_body;

  /// No description provided for @s84_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit metadata'**
  String get s84_edit;

  /// No description provided for @s84_edit_body.
  ///
  /// In en, this message translates to:
  /// **'Can rename, tag and add notes'**
  String get s84_edit_body;

  /// No description provided for @s84_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete documents'**
  String get s84_delete;

  /// No description provided for @s84_delete_body.
  ///
  /// In en, this message translates to:
  /// **'Requires owner confirmation'**
  String get s84_delete_body;

  /// No description provided for @s84_export.
  ///
  /// In en, this message translates to:
  /// **'Export shared files'**
  String get s84_export;

  /// No description provided for @s84_export_body.
  ///
  /// In en, this message translates to:
  /// **'Can create encrypted exports'**
  String get s84_export_body;

  /// No description provided for @s84_collection_access.
  ///
  /// In en, this message translates to:
  /// **'Collection Access'**
  String get s84_collection_access;

  /// No description provided for @s84_family_documents.
  ///
  /// In en, this message translates to:
  /// **'Family Documents'**
  String get s84_family_documents;

  /// No description provided for @access_full.
  ///
  /// In en, this message translates to:
  /// **'Full access'**
  String get access_full;

  /// No description provided for @s84_health_records.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get s84_health_records;

  /// No description provided for @access_view_only.
  ///
  /// In en, this message translates to:
  /// **'View only'**
  String get access_view_only;

  /// No description provided for @s84_property_papers.
  ///
  /// In en, this message translates to:
  /// **'Property Papers'**
  String get s84_property_papers;

  /// No description provided for @access_none.
  ///
  /// In en, this message translates to:
  /// **'No access'**
  String get access_none;

  /// No description provided for @s84_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s84_education;

  /// No description provided for @s85_title.
  ///
  /// In en, this message translates to:
  /// **'Trusted Contacts'**
  String get s85_title;

  /// No description provided for @s85_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency recovery helpers'**
  String get s85_subtitle;

  /// No description provided for @s85_info_title.
  ///
  /// In en, this message translates to:
  /// **'What trusted contacts can do'**
  String get s85_info_title;

  /// No description provided for @s85_info_body.
  ///
  /// In en, this message translates to:
  /// **'They cannot see your vault. They can only help unlock an emergency package when your rules are satisfied.'**
  String get s85_info_body;

  /// No description provided for @s85_harika_meta.
  ///
  /// In en, this message translates to:
  /// **'Primary trusted contact'**
  String get s85_harika_meta;

  /// No description provided for @status_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get status_verified;

  /// No description provided for @member_ramesh.
  ///
  /// In en, this message translates to:
  /// **'Ramesh'**
  String get member_ramesh;

  /// No description provided for @s85_ramesh_meta.
  ///
  /// In en, this message translates to:
  /// **'Backup contact'**
  String get s85_ramesh_meta;

  /// No description provided for @s85_rules.
  ///
  /// In en, this message translates to:
  /// **'Emergency Rules'**
  String get s85_rules;

  /// No description provided for @s85_min_approvals.
  ///
  /// In en, this message translates to:
  /// **'Minimum approvals'**
  String get s85_min_approvals;

  /// No description provided for @s85_min_approvals_body.
  ///
  /// In en, this message translates to:
  /// **'2 of 2 trusted contacts'**
  String get s85_min_approvals_body;

  /// No description provided for @s85_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting period'**
  String get s85_waiting;

  /// No description provided for @s85_waiting_body.
  ///
  /// In en, this message translates to:
  /// **'48 hours before access'**
  String get s85_waiting_body;

  /// No description provided for @s85_scope.
  ///
  /// In en, this message translates to:
  /// **'Access scope'**
  String get s85_scope;

  /// No description provided for @s85_scope_body.
  ///
  /// In en, this message translates to:
  /// **'Emergency Pack only'**
  String get s85_scope_body;

  /// No description provided for @s85_lifetime.
  ///
  /// In en, this message translates to:
  /// **'Package lifetime'**
  String get s85_lifetime;

  /// No description provided for @s85_lifetime_body.
  ///
  /// In en, this message translates to:
  /// **'Valid for 24 hours'**
  String get s85_lifetime_body;

  /// No description provided for @s85_add.
  ///
  /// In en, this message translates to:
  /// **'Add Trusted Contact'**
  String get s85_add;

  /// No description provided for @s86_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Access'**
  String get s86_title;

  /// No description provided for @s86_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare a limited recovery package'**
  String get s86_subtitle;

  /// No description provided for @s86_pack.
  ///
  /// In en, this message translates to:
  /// **'Emergency Pack'**
  String get s86_pack;

  /// No description provided for @s86_pack_summary.
  ///
  /// In en, this message translates to:
  /// **'6 selected items'**
  String get s86_pack_summary;

  /// No description provided for @s86_included.
  ///
  /// In en, this message translates to:
  /// **'Included Items'**
  String get s86_included;

  /// No description provided for @s86_identity.
  ///
  /// In en, this message translates to:
  /// **'Identity Card'**
  String get s86_identity;

  /// No description provided for @s86_health.
  ///
  /// In en, this message translates to:
  /// **'Health Summary'**
  String get s86_health;

  /// No description provided for @s86_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Details'**
  String get s86_insurance;

  /// No description provided for @s86_contacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get s86_contacts;

  /// No description provided for @s86_warning.
  ///
  /// In en, this message translates to:
  /// **'Emergency access is limited'**
  String get s86_warning;

  /// No description provided for @s86_warning_body.
  ///
  /// In en, this message translates to:
  /// **'It never unlocks the full vault'**
  String get s86_warning_body;

  /// No description provided for @s86_create.
  ///
  /// In en, this message translates to:
  /// **'Create Emergency Package'**
  String get s86_create;

  /// No description provided for @s87_title.
  ///
  /// In en, this message translates to:
  /// **'Shared Collections'**
  String get s87_title;

  /// No description provided for @s87_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Available to family members'**
  String get s87_subtitle;

  /// No description provided for @s87_family_documents.
  ///
  /// In en, this message translates to:
  /// **'Family Documents'**
  String get s87_family_documents;

  /// No description provided for @s87_family_documents_meta.
  ///
  /// In en, this message translates to:
  /// **'28 items • All members'**
  String get s87_family_documents_meta;

  /// No description provided for @s87_family_documents_members.
  ///
  /// In en, this message translates to:
  /// **'4 members'**
  String get s87_family_documents_members;

  /// No description provided for @s87_health.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get s87_health;

  /// No description provided for @s87_health_meta.
  ///
  /// In en, this message translates to:
  /// **'16 items • Parents only'**
  String get s87_health_meta;

  /// No description provided for @s87_health_members.
  ///
  /// In en, this message translates to:
  /// **'2 members'**
  String get s87_health_members;

  /// No description provided for @s87_property.
  ///
  /// In en, this message translates to:
  /// **'Property Papers'**
  String get s87_property;

  /// No description provided for @s87_property_meta.
  ///
  /// In en, this message translates to:
  /// **'9 items • Adults only'**
  String get s87_property_meta;

  /// No description provided for @s87_property_members.
  ///
  /// In en, this message translates to:
  /// **'2 members'**
  String get s87_property_members;

  /// No description provided for @s87_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s87_education;

  /// No description provided for @s87_education_meta.
  ///
  /// In en, this message translates to:
  /// **'12 items • Children and parents'**
  String get s87_education_meta;

  /// No description provided for @s87_education_members.
  ///
  /// In en, this message translates to:
  /// **'4 members'**
  String get s87_education_members;

  /// No description provided for @s87_emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency Pack'**
  String get s87_emergency;

  /// No description provided for @s87_emergency_meta.
  ///
  /// In en, this message translates to:
  /// **'6 items • Trusted contacts'**
  String get s87_emergency_meta;

  /// No description provided for @s87_emergency_contacts.
  ///
  /// In en, this message translates to:
  /// **'2 contacts'**
  String get s87_emergency_contacts;

  /// No description provided for @s87_method.
  ///
  /// In en, this message translates to:
  /// **'Sharing method'**
  String get s87_method;

  /// No description provided for @s87_method_value.
  ///
  /// In en, this message translates to:
  /// **'Encrypted package or nearby transfer'**
  String get s87_method_value;

  /// No description provided for @s87_create.
  ///
  /// In en, this message translates to:
  /// **'Create Shared Collection'**
  String get s87_create;

  /// No description provided for @s88_title.
  ///
  /// In en, this message translates to:
  /// **'Shared Activity'**
  String get s88_title;

  /// No description provided for @s88_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Local family vault actions'**
  String get s88_subtitle;

  /// No description provided for @s88_time_1.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:30 AM'**
  String get s88_time_1;

  /// No description provided for @s88_event_1.
  ///
  /// In en, this message translates to:
  /// **'Harika added Health Report'**
  String get s88_event_1;

  /// No description provided for @s88_collection_1.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get s88_collection_1;

  /// No description provided for @s88_time_2.
  ///
  /// In en, this message translates to:
  /// **'Today, 9:15 AM'**
  String get s88_time_2;

  /// No description provided for @s88_event_2.
  ///
  /// In en, this message translates to:
  /// **'Arjun updated Insurance Policy'**
  String get s88_event_2;

  /// No description provided for @s88_collection_2.
  ///
  /// In en, this message translates to:
  /// **'Family Documents'**
  String get s88_collection_2;

  /// No description provided for @s88_time_3.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 7:40 PM'**
  String get s88_time_3;

  /// No description provided for @s88_event_3.
  ///
  /// In en, this message translates to:
  /// **'Alekhya viewed Education Certificate'**
  String get s88_event_3;

  /// No description provided for @s88_collection_3.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s88_collection_3;

  /// No description provided for @s88_time_4.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 4:20 PM'**
  String get s88_time_4;

  /// No description provided for @s88_event_4.
  ///
  /// In en, this message translates to:
  /// **'Harika added a reminder'**
  String get s88_event_4;

  /// No description provided for @s88_collection_4.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get s88_collection_4;

  /// No description provided for @s88_time_5.
  ///
  /// In en, this message translates to:
  /// **'12 May, 11:10 AM'**
  String get s88_time_5;

  /// No description provided for @s88_event_5.
  ///
  /// In en, this message translates to:
  /// **'Charvika opened School ID'**
  String get s88_event_5;

  /// No description provided for @s88_collection_5.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get s88_collection_5;

  /// No description provided for @s88_time_6.
  ///
  /// In en, this message translates to:
  /// **'10 May, 8:45 AM'**
  String get s88_time_6;

  /// No description provided for @s88_event_6.
  ///
  /// In en, this message translates to:
  /// **'Arjun created Emergency Pack'**
  String get s88_event_6;

  /// No description provided for @s88_collection_6.
  ///
  /// In en, this message translates to:
  /// **'Emergency Pack'**
  String get s88_collection_6;

  /// No description provided for @s88_location.
  ///
  /// In en, this message translates to:
  /// **'Activity log location'**
  String get s88_location;

  /// No description provided for @s88_location_value.
  ///
  /// In en, this message translates to:
  /// **'Stored only in this family vault'**
  String get s88_location_value;

  /// No description provided for @s89_title.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get s89_title;

  /// No description provided for @s89_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pending offline invitations'**
  String get s89_subtitle;

  /// No description provided for @s89_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get s89_pending;

  /// No description provided for @s89_harika_meta.
  ///
  /// In en, this message translates to:
  /// **'Adult member • QR invitation'**
  String get s89_harika_meta;

  /// No description provided for @s89_harika_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires in 18h'**
  String get s89_harika_expiry;

  /// No description provided for @s89_ramesh_meta.
  ///
  /// In en, this message translates to:
  /// **'Trusted contact • Encrypted file'**
  String get s89_ramesh_meta;

  /// No description provided for @s89_ramesh_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expires in 2d'**
  String get s89_ramesh_expiry;

  /// No description provided for @s89_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get s89_completed;

  /// No description provided for @s89_alekhya_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined 12 May 2026'**
  String get s89_alekhya_joined;

  /// No description provided for @status_accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get status_accepted;

  /// No description provided for @s89_charvika_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined 12 May 2026'**
  String get s89_charvika_joined;

  /// No description provided for @s89_security.
  ///
  /// In en, this message translates to:
  /// **'Invitation Security'**
  String get s89_security;

  /// No description provided for @s89_single_use.
  ///
  /// In en, this message translates to:
  /// **'Single Use'**
  String get s89_single_use;

  /// No description provided for @s89_single_use_body.
  ///
  /// In en, this message translates to:
  /// **'Each invitation can be accepted once'**
  String get s89_single_use_body;

  /// No description provided for @s89_time_limited.
  ///
  /// In en, this message translates to:
  /// **'Time Limited'**
  String get s89_time_limited;

  /// No description provided for @s89_time_limited_body.
  ///
  /// In en, this message translates to:
  /// **'Invitations expire automatically'**
  String get s89_time_limited_body;

  /// No description provided for @s89_device_verified.
  ///
  /// In en, this message translates to:
  /// **'Device Verified'**
  String get s89_device_verified;

  /// No description provided for @s89_device_verified_body.
  ///
  /// In en, this message translates to:
  /// **'Second device confirms local keys'**
  String get s89_device_verified_body;

  /// No description provided for @s90_title.
  ///
  /// In en, this message translates to:
  /// **'Access History'**
  String get s90_title;

  /// No description provided for @s90_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Family vault access log'**
  String get s90_subtitle;

  /// No description provided for @s90_period.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get s90_period;

  /// No description provided for @s90_summary.
  ///
  /// In en, this message translates to:
  /// **'86 family vault actions'**
  String get s90_summary;

  /// No description provided for @s90_warnings.
  ///
  /// In en, this message translates to:
  /// **'No warnings'**
  String get s90_warnings;

  /// No description provided for @s90_event_1.
  ///
  /// In en, this message translates to:
  /// **'Opened Health Report'**
  String get s90_event_1;

  /// No description provided for @s90_time_1.
  ///
  /// In en, this message translates to:
  /// **'Today • 10:32 AM'**
  String get s90_time_1;

  /// No description provided for @status_allowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get status_allowed;

  /// No description provided for @s90_event_2.
  ///
  /// In en, this message translates to:
  /// **'Exported Family Documents'**
  String get s90_event_2;

  /// No description provided for @member_arjun_short.
  ///
  /// In en, this message translates to:
  /// **'Arjun'**
  String get member_arjun_short;

  /// No description provided for @s90_time_2.
  ///
  /// In en, this message translates to:
  /// **'Today • 9:20 AM'**
  String get s90_time_2;

  /// No description provided for @s90_event_3.
  ///
  /// In en, this message translates to:
  /// **'Tried to open Property Papers'**
  String get s90_event_3;

  /// No description provided for @s90_time_3.
  ///
  /// In en, this message translates to:
  /// **'Yesterday • 7:45 PM'**
  String get s90_time_3;

  /// No description provided for @status_blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get status_blocked;

  /// No description provided for @s90_event_4.
  ///
  /// In en, this message translates to:
  /// **'Viewed Education Certificate'**
  String get s90_event_4;

  /// No description provided for @s90_time_4.
  ///
  /// In en, this message translates to:
  /// **'Yesterday • 4:15 PM'**
  String get s90_time_4;

  /// No description provided for @s90_event_5.
  ///
  /// In en, this message translates to:
  /// **'Added doctor reminder'**
  String get s90_event_5;

  /// No description provided for @s90_time_5.
  ///
  /// In en, this message translates to:
  /// **'12 May • 11:10 AM'**
  String get s90_time_5;

  /// No description provided for @s90_event_6.
  ///
  /// In en, this message translates to:
  /// **'Emergency package request'**
  String get s90_event_6;

  /// No description provided for @s90_time_6.
  ///
  /// In en, this message translates to:
  /// **'10 May • 8:45 AM'**
  String get s90_time_6;

  /// No description provided for @status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get status_pending;

  /// No description provided for @s90_export.
  ///
  /// In en, this message translates to:
  /// **'Export access report'**
  String get s90_export;

  /// No description provided for @s90_export_body.
  ///
  /// In en, this message translates to:
  /// **'Create a local encrypted audit file'**
  String get s90_export_body;

  /// No description provided for @s91_title.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep Pro'**
  String get s91_title;

  /// No description provided for @s91_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock advanced local features'**
  String get s91_subtitle;

  /// No description provided for @s91_badge.
  ///
  /// In en, this message translates to:
  /// **'OWNKEEP PRO'**
  String get s91_badge;

  /// No description provided for @s91_hero.
  ///
  /// In en, this message translates to:
  /// **'Everything stays yours'**
  String get s91_hero;

  /// No description provided for @s91_hero_body.
  ///
  /// In en, this message translates to:
  /// **'One premium upgrade for advanced security, AI organization, document tools and family vault features.'**
  String get s91_hero_body;

  /// No description provided for @s91_price.
  ///
  /// In en, this message translates to:
  /// **'₹1,499'**
  String get s91_price;

  /// No description provided for @s91_price_type.
  ///
  /// In en, this message translates to:
  /// **'one-time'**
  String get s91_price_type;

  /// No description provided for @s91_features.
  ///
  /// In en, this message translates to:
  /// **'Included Features'**
  String get s91_features;

  /// No description provided for @s91_document_tools.
  ///
  /// In en, this message translates to:
  /// **'Advanced document tools'**
  String get s91_document_tools;

  /// No description provided for @s91_document_tools_body.
  ///
  /// In en, this message translates to:
  /// **'Merge, split, compare and OCR'**
  String get s91_document_tools_body;

  /// No description provided for @s91_ai.
  ///
  /// In en, this message translates to:
  /// **'On-device AI'**
  String get s91_ai;

  /// No description provided for @s91_ai_body.
  ///
  /// In en, this message translates to:
  /// **'Smart search, tags and insights'**
  String get s91_ai_body;

  /// No description provided for @s91_family.
  ///
  /// In en, this message translates to:
  /// **'Family Vault'**
  String get s91_family;

  /// No description provided for @s91_family_body.
  ///
  /// In en, this message translates to:
  /// **'Offline encrypted sharing'**
  String get s91_family_body;

  /// No description provided for @s91_security.
  ///
  /// In en, this message translates to:
  /// **'Security tools'**
  String get s91_security;

  /// No description provided for @s91_security_body.
  ///
  /// In en, this message translates to:
  /// **'Hidden vault, decoy vault and audit'**
  String get s91_security_body;

  /// No description provided for @s91_collections.
  ///
  /// In en, this message translates to:
  /// **'Unlimited collections'**
  String get s91_collections;

  /// No description provided for @s91_collections_body.
  ///
  /// In en, this message translates to:
  /// **'Create and customize freely'**
  String get s91_collections_body;

  /// No description provided for @s91_upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to OwnKeep Pro'**
  String get s91_upgrade;

  /// No description provided for @s91_offline_note.
  ///
  /// In en, this message translates to:
  /// **'Purchase entitlement is cached for offline use'**
  String get s91_offline_note;

  /// No description provided for @s92_title.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get s92_title;

  /// No description provided for @s92_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize your vault'**
  String get s92_subtitle;

  /// No description provided for @s92_app_theme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get s92_app_theme;

  /// No description provided for @s92_midnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get s92_midnight;

  /// No description provided for @s92_midnight_body.
  ///
  /// In en, this message translates to:
  /// **'Dark premium theme'**
  String get s92_midnight_body;

  /// No description provided for @s92_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get s92_active;

  /// No description provided for @s92_indigo.
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get s92_indigo;

  /// No description provided for @s92_indigo_body.
  ///
  /// In en, this message translates to:
  /// **'Dark premium theme'**
  String get s92_indigo_body;

  /// No description provided for @s92_forest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get s92_forest;

  /// No description provided for @s92_forest_body.
  ///
  /// In en, this message translates to:
  /// **'Dark premium theme'**
  String get s92_forest_body;

  /// No description provided for @s92_graphite.
  ///
  /// In en, this message translates to:
  /// **'Graphite'**
  String get s92_graphite;

  /// No description provided for @s92_graphite_body.
  ///
  /// In en, this message translates to:
  /// **'Dark premium theme'**
  String get s92_graphite_body;

  /// No description provided for @s92_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get s92_appearance;

  /// No description provided for @s92_system_brightness.
  ///
  /// In en, this message translates to:
  /// **'Use system brightness'**
  String get s92_system_brightness;

  /// No description provided for @s92_system_brightness_body.
  ///
  /// In en, this message translates to:
  /// **'Follow device dark/light setting'**
  String get s92_system_brightness_body;

  /// No description provided for @s92_reduce_motion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get s92_reduce_motion;

  /// No description provided for @s92_reduce_motion_body.
  ///
  /// In en, this message translates to:
  /// **'Use simpler transitions'**
  String get s92_reduce_motion_body;

  /// No description provided for @s92_increase_contrast.
  ///
  /// In en, this message translates to:
  /// **'Increase contrast'**
  String get s92_increase_contrast;

  /// No description provided for @s92_increase_contrast_body.
  ///
  /// In en, this message translates to:
  /// **'Stronger text and borders'**
  String get s92_increase_contrast_body;

  /// No description provided for @s93_title.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get s93_title;

  /// No description provided for @s93_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Control when OwnKeep locks'**
  String get s93_subtitle;

  /// No description provided for @s93_status_label.
  ///
  /// In en, this message translates to:
  /// **'Vault Lock Status'**
  String get s93_status_label;

  /// No description provided for @s93_status.
  ///
  /// In en, this message translates to:
  /// **'Protected'**
  String get s93_status;

  /// No description provided for @s93_method_summary.
  ///
  /// In en, this message translates to:
  /// **'Biometric + PIN'**
  String get s93_method_summary;

  /// No description provided for @s93_methods.
  ///
  /// In en, this message translates to:
  /// **'Lock Methods'**
  String get s93_methods;

  /// No description provided for @s93_biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get s93_biometric;

  /// No description provided for @s93_biometric_body.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face unlock'**
  String get s93_biometric_body;

  /// No description provided for @s93_pin.
  ///
  /// In en, this message translates to:
  /// **'PIN fallback'**
  String get s93_pin;

  /// No description provided for @s93_pin_body.
  ///
  /// In en, this message translates to:
  /// **'Required after device restart'**
  String get s93_pin_body;

  /// No description provided for @s93_recovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery phrase'**
  String get s93_recovery;

  /// No description provided for @s93_recovery_body.
  ///
  /// In en, this message translates to:
  /// **'Emergency recovery only'**
  String get s93_recovery_body;

  /// No description provided for @s93_auto_lock.
  ///
  /// In en, this message translates to:
  /// **'Auto Lock'**
  String get s93_auto_lock;

  /// No description provided for @s93_immediately.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get s93_immediately;

  /// No description provided for @s93_after_30.
  ///
  /// In en, this message translates to:
  /// **'After 30 seconds'**
  String get s93_after_30;

  /// No description provided for @s93_after_2.
  ///
  /// In en, this message translates to:
  /// **'After 2 minutes'**
  String get s93_after_2;

  /// No description provided for @s93_background.
  ///
  /// In en, this message translates to:
  /// **'When app goes to background'**
  String get s93_background;

  /// No description provided for @s93_lock_now.
  ///
  /// In en, this message translates to:
  /// **'Lock Now'**
  String get s93_lock_now;

  /// No description provided for @s93_lock_now_body.
  ///
  /// In en, this message translates to:
  /// **'Immediately secure all vault content'**
  String get s93_lock_now_body;

  /// No description provided for @s94_title.
  ///
  /// In en, this message translates to:
  /// **'Hidden Vault'**
  String get s94_title;

  /// No description provided for @s94_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep sensitive items out of sight'**
  String get s94_subtitle;

  /// No description provided for @s94_status.
  ///
  /// In en, this message translates to:
  /// **'Hidden Vault Disabled'**
  String get s94_status;

  /// No description provided for @s94_body.
  ///
  /// In en, this message translates to:
  /// **'Hidden Vault is concealed from the main app and opens only with a separate gesture and PIN.'**
  String get s94_body;

  /// No description provided for @s94_how.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get s94_how;

  /// No description provided for @s94_pin.
  ///
  /// In en, this message translates to:
  /// **'Separate PIN'**
  String get s94_pin;

  /// No description provided for @s94_pin_body.
  ///
  /// In en, this message translates to:
  /// **'Different from your main vault PIN'**
  String get s94_pin_body;

  /// No description provided for @s94_gesture.
  ///
  /// In en, this message translates to:
  /// **'Hidden entry gesture'**
  String get s94_gesture;

  /// No description provided for @s94_gesture_body.
  ///
  /// In en, this message translates to:
  /// **'Access from the lock screen'**
  String get s94_gesture_body;

  /// No description provided for @s94_activity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity'**
  String get s94_activity;

  /// No description provided for @s94_activity_body.
  ///
  /// In en, this message translates to:
  /// **'Hidden files do not appear elsewhere'**
  String get s94_activity_body;

  /// No description provided for @s94_storage.
  ///
  /// In en, this message translates to:
  /// **'Local-only storage'**
  String get s94_storage;

  /// No description provided for @s94_storage_body.
  ///
  /// In en, this message translates to:
  /// **'Never uploaded or synchronized'**
  String get s94_storage_body;

  /// No description provided for @s94_setup.
  ///
  /// In en, this message translates to:
  /// **'Set Up Hidden Vault'**
  String get s94_setup;

  /// No description provided for @s94_note.
  ///
  /// In en, this message translates to:
  /// **'You can remove the hidden vault at any time'**
  String get s94_note;

  /// No description provided for @s95_title.
  ///
  /// In en, this message translates to:
  /// **'Decoy Vault'**
  String get s95_title;

  /// No description provided for @s95_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Open a harmless vault with a separate PIN'**
  String get s95_subtitle;

  /// No description provided for @s95_safety.
  ///
  /// In en, this message translates to:
  /// **'Safety Feature'**
  String get s95_safety;

  /// No description provided for @s95_hero.
  ///
  /// In en, this message translates to:
  /// **'Create a believable alternate vault'**
  String get s95_hero;

  /// No description provided for @s95_hero_body.
  ///
  /// In en, this message translates to:
  /// **'A decoy PIN opens a separate vault containing only the items you choose. Your real vault stays hidden.'**
  String get s95_hero_body;

  /// No description provided for @s95_setup.
  ///
  /// In en, this message translates to:
  /// **'Decoy Setup'**
  String get s95_setup;

  /// No description provided for @s95_step_1.
  ///
  /// In en, this message translates to:
  /// **'Choose decoy PIN'**
  String get s95_step_1;

  /// No description provided for @s95_step_1_body.
  ///
  /// In en, this message translates to:
  /// **'Must differ from your real PIN'**
  String get s95_step_1_body;

  /// No description provided for @s95_step_2.
  ///
  /// In en, this message translates to:
  /// **'Add harmless files'**
  String get s95_step_2;

  /// No description provided for @s95_step_2_body.
  ///
  /// In en, this message translates to:
  /// **'Select ordinary documents or photos'**
  String get s95_step_2_body;

  /// No description provided for @s95_step_3.
  ///
  /// In en, this message translates to:
  /// **'Test decoy unlock'**
  String get s95_step_3;

  /// No description provided for @s95_step_3_body.
  ///
  /// In en, this message translates to:
  /// **'Verify the alternate vault opens'**
  String get s95_step_3_body;

  /// No description provided for @s95_step_4.
  ///
  /// In en, this message translates to:
  /// **'Enable silent mode'**
  String get s95_step_4;

  /// No description provided for @s95_step_4_body.
  ///
  /// In en, this message translates to:
  /// **'No warning appears during unlock'**
  String get s95_step_4_body;

  /// No description provided for @s95_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get s95_important;

  /// No description provided for @s95_important_body.
  ///
  /// In en, this message translates to:
  /// **'Decoy mode does not replace physical safety precautions'**
  String get s95_important_body;

  /// No description provided for @s95_create.
  ///
  /// In en, this message translates to:
  /// **'Create Decoy Vault'**
  String get s95_create;

  /// No description provided for @s96_title.
  ///
  /// In en, this message translates to:
  /// **'Recovery Verification'**
  String get s96_title;

  /// No description provided for @s96_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm you saved the phrase'**
  String get s96_subtitle;

  /// No description provided for @s96_check.
  ///
  /// In en, this message translates to:
  /// **'Recovery check'**
  String get s96_check;

  /// No description provided for @s96_check_body.
  ///
  /// In en, this message translates to:
  /// **'Select the missing words in the correct order. This check happens only on this device.'**
  String get s96_check_body;

  /// No description provided for @s96_phrase.
  ///
  /// In en, this message translates to:
  /// **'Your phrase'**
  String get s96_phrase;

  /// No description provided for @s96_word_1.
  ///
  /// In en, this message translates to:
  /// **'copper'**
  String get s96_word_1;

  /// No description provided for @s96_word_2.
  ///
  /// In en, this message translates to:
  /// **'river'**
  String get s96_word_2;

  /// No description provided for @s96_word_3.
  ///
  /// In en, this message translates to:
  /// **'___'**
  String get s96_word_3;

  /// No description provided for @s96_word_4.
  ///
  /// In en, this message translates to:
  /// **'forest'**
  String get s96_word_4;

  /// No description provided for @s96_word_5.
  ///
  /// In en, this message translates to:
  /// **'silent'**
  String get s96_word_5;

  /// No description provided for @s96_word_6.
  ///
  /// In en, this message translates to:
  /// **'___'**
  String get s96_word_6;

  /// No description provided for @s96_word_7.
  ///
  /// In en, this message translates to:
  /// **'planet'**
  String get s96_word_7;

  /// No description provided for @s96_word_8.
  ///
  /// In en, this message translates to:
  /// **'harbor'**
  String get s96_word_8;

  /// No description provided for @s96_word_9.
  ///
  /// In en, this message translates to:
  /// **'amber'**
  String get s96_word_9;

  /// No description provided for @s96_word_10.
  ///
  /// In en, this message translates to:
  /// **'___'**
  String get s96_word_10;

  /// No description provided for @s96_word_11.
  ///
  /// In en, this message translates to:
  /// **'window'**
  String get s96_word_11;

  /// No description provided for @s96_word_12.
  ///
  /// In en, this message translates to:
  /// **'stone'**
  String get s96_word_12;

  /// No description provided for @s96_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose missing words'**
  String get s96_choose;

  /// No description provided for @s96_option_garden.
  ///
  /// In en, this message translates to:
  /// **'garden'**
  String get s96_option_garden;

  /// No description provided for @s96_option_mirror.
  ///
  /// In en, this message translates to:
  /// **'mirror'**
  String get s96_option_mirror;

  /// No description provided for @s96_option_ocean.
  ///
  /// In en, this message translates to:
  /// **'ocean'**
  String get s96_option_ocean;

  /// No description provided for @s96_option_lantern.
  ///
  /// In en, this message translates to:
  /// **'lantern'**
  String get s96_option_lantern;

  /// No description provided for @s96_option_violet.
  ///
  /// In en, this message translates to:
  /// **'violet'**
  String get s96_option_violet;

  /// No description provided for @s96_option_engine.
  ///
  /// In en, this message translates to:
  /// **'engine'**
  String get s96_option_engine;

  /// No description provided for @s96_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify Recovery Phrase'**
  String get s96_verify;

  /// No description provided for @s96_why.
  ///
  /// In en, this message translates to:
  /// **'Why verify?'**
  String get s96_why;

  /// No description provided for @s96_why_body.
  ///
  /// In en, this message translates to:
  /// **'A verified phrase prevents permanent data loss'**
  String get s96_why_body;

  /// No description provided for @s97_title.
  ///
  /// In en, this message translates to:
  /// **'Encryption Details'**
  String get s97_title;

  /// No description provided for @s97_subtitle.
  ///
  /// In en, this message translates to:
  /// **'How OwnKeep protects your vault'**
  String get s97_subtitle;

  /// No description provided for @s97_status.
  ///
  /// In en, this message translates to:
  /// **'Vault Fully Encrypted'**
  String get s97_status;

  /// No description provided for @s97_status_body.
  ///
  /// In en, this message translates to:
  /// **'All checks passed'**
  String get s97_status_body;

  /// No description provided for @s97_content.
  ///
  /// In en, this message translates to:
  /// **'Content encryption'**
  String get s97_content;

  /// No description provided for @s97_content_value.
  ///
  /// In en, this message translates to:
  /// **'AES-256-GCM'**
  String get s97_content_value;

  /// No description provided for @s97_kdf.
  ///
  /// In en, this message translates to:
  /// **'Key derivation'**
  String get s97_kdf;

  /// No description provided for @s97_kdf_value.
  ///
  /// In en, this message translates to:
  /// **'Argon2id'**
  String get s97_kdf_value;

  /// No description provided for @s97_manifest.
  ///
  /// In en, this message translates to:
  /// **'Manifest format'**
  String get s97_manifest;

  /// No description provided for @s97_manifest_value.
  ///
  /// In en, this message translates to:
  /// **'Canonical CBOR'**
  String get s97_manifest_value;

  /// No description provided for @s97_integrity.
  ///
  /// In en, this message translates to:
  /// **'Integrity'**
  String get s97_integrity;

  /// No description provided for @s97_integrity_value.
  ///
  /// In en, this message translates to:
  /// **'SHA-256 digests'**
  String get s97_integrity_value;

  /// No description provided for @s97_container.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get s97_container;

  /// No description provided for @s97_container_value.
  ///
  /// In en, this message translates to:
  /// **'Encrypted .cvault'**
  String get s97_container_value;

  /// No description provided for @s97_envelope.
  ///
  /// In en, this message translates to:
  /// **'Recovery envelope'**
  String get s97_envelope;

  /// No description provided for @s97_envelope_value.
  ///
  /// In en, this message translates to:
  /// **'Authenticated and local'**
  String get s97_envelope_value;

  /// No description provided for @s97_security_model.
  ///
  /// In en, this message translates to:
  /// **'Security model'**
  String get s97_security_model;

  /// No description provided for @s97_security_model_body.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep cannot read or recover your vault'**
  String get s97_security_model_body;

  /// No description provided for @s98_title.
  ///
  /// In en, this message translates to:
  /// **'Device Migration'**
  String get s98_title;

  /// No description provided for @s98_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Move your vault to another device'**
  String get s98_subtitle;

  /// No description provided for @s98_secure.
  ///
  /// In en, this message translates to:
  /// **'Secure Device-to-Device Transfer'**
  String get s98_secure;

  /// No description provided for @s98_secure_body.
  ///
  /// In en, this message translates to:
  /// **'Transfer through local network or an encrypted migration package. No cloud account is required.'**
  String get s98_secure_body;

  /// No description provided for @s98_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose Method'**
  String get s98_choose;

  /// No description provided for @s98_nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby Transfer'**
  String get s98_nearby;

  /// No description provided for @s98_nearby_body.
  ///
  /// In en, this message translates to:
  /// **'Fast local transfer on the same network'**
  String get s98_nearby_body;

  /// No description provided for @s98_file.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Migration File'**
  String get s98_file;

  /// No description provided for @s98_file_body.
  ///
  /// In en, this message translates to:
  /// **'Move using USB, Files or SD card'**
  String get s98_file_body;

  /// No description provided for @s98_qr.
  ///
  /// In en, this message translates to:
  /// **'QR Pairing'**
  String get s98_qr;

  /// No description provided for @s98_qr_body.
  ///
  /// In en, this message translates to:
  /// **'Pair devices before local transfer'**
  String get s98_qr_body;

  /// No description provided for @s98_checklist.
  ///
  /// In en, this message translates to:
  /// **'Migration Checklist'**
  String get s98_checklist;

  /// No description provided for @s98_backup.
  ///
  /// In en, this message translates to:
  /// **'Create fresh backup'**
  String get s98_backup;

  /// No description provided for @s98_charge.
  ///
  /// In en, this message translates to:
  /// **'Keep both devices charged'**
  String get s98_charge;

  /// No description provided for @s98_storage.
  ///
  /// In en, this message translates to:
  /// **'Verify available storage'**
  String get s98_storage;

  /// No description provided for @s98_keep_old.
  ///
  /// In en, this message translates to:
  /// **'Do not delete old vault yet'**
  String get s98_keep_old;

  /// No description provided for @s98_start.
  ///
  /// In en, this message translates to:
  /// **'Start Device Migration'**
  String get s98_start;

  /// No description provided for @s99_title.
  ///
  /// In en, this message translates to:
  /// **'Restore Vault'**
  String get s99_title;

  /// No description provided for @s99_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Recover from an encrypted backup'**
  String get s99_subtitle;

  /// No description provided for @s99_backup_file.
  ///
  /// In en, this message translates to:
  /// **'Backup File'**
  String get s99_backup_file;

  /// No description provided for @s99_file.
  ///
  /// In en, this message translates to:
  /// **'OwnKeep_Backup_2026-08-03.cvault'**
  String get s99_file;

  /// No description provided for @s99_file_meta.
  ///
  /// In en, this message translates to:
  /// **'2.4 GB • Verified container'**
  String get s99_file_meta;

  /// No description provided for @s99_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get s99_change;

  /// No description provided for @s99_options.
  ///
  /// In en, this message translates to:
  /// **'Restore Options'**
  String get s99_options;

  /// No description provided for @s99_everything.
  ///
  /// In en, this message translates to:
  /// **'Restore everything'**
  String get s99_everything;

  /// No description provided for @s99_everything_body.
  ///
  /// In en, this message translates to:
  /// **'Documents, notes, reminders and settings'**
  String get s99_everything_body;

  /// No description provided for @s99_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents only'**
  String get s99_documents;

  /// No description provided for @s99_documents_body.
  ///
  /// In en, this message translates to:
  /// **'Skip app preferences and activity history'**
  String get s99_documents_body;

  /// No description provided for @s99_collections.
  ///
  /// In en, this message translates to:
  /// **'Choose collections'**
  String get s99_collections;

  /// No description provided for @s99_collections_body.
  ///
  /// In en, this message translates to:
  /// **'Restore selected categories'**
  String get s99_collections_body;

  /// No description provided for @s99_verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get s99_verification;

  /// No description provided for @s99_integrity.
  ///
  /// In en, this message translates to:
  /// **'Container integrity'**
  String get s99_integrity;

  /// No description provided for @s99_integrity_value.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get s99_integrity_value;

  /// No description provided for @s99_envelope.
  ///
  /// In en, this message translates to:
  /// **'Recovery envelope'**
  String get s99_envelope;

  /// No description provided for @s99_envelope_value.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get s99_envelope_value;

  /// No description provided for @s99_storage.
  ///
  /// In en, this message translates to:
  /// **'Available storage'**
  String get s99_storage;

  /// No description provided for @s99_storage_value.
  ///
  /// In en, this message translates to:
  /// **'7.8 GB free'**
  String get s99_storage_value;

  /// No description provided for @s99_version.
  ///
  /// In en, this message translates to:
  /// **'Backup version'**
  String get s99_version;

  /// No description provided for @s99_version_value.
  ///
  /// In en, this message translates to:
  /// **'Compatible'**
  String get s99_version_value;

  /// No description provided for @s99_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore Vault'**
  String get s99_restore;

  /// No description provided for @s100_title.
  ///
  /// In en, this message translates to:
  /// **'Security Audit'**
  String get s100_title;

  /// No description provided for @s100_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Final vault safety review'**
  String get s100_subtitle;

  /// No description provided for @s100_score.
  ///
  /// In en, this message translates to:
  /// **'98'**
  String get s100_score;

  /// No description provided for @s100_score_label.
  ///
  /// In en, this message translates to:
  /// **'Security Score'**
  String get s100_score_label;

  /// No description provided for @s100_rating.
  ///
  /// In en, this message translates to:
  /// **'Excellent protection'**
  String get s100_rating;

  /// No description provided for @s100_last_audit.
  ///
  /// In en, this message translates to:
  /// **'Last audited today at 9:35 AM'**
  String get s100_last_audit;

  /// No description provided for @s100_results.
  ///
  /// In en, this message translates to:
  /// **'Audit Results'**
  String get s100_results;

  /// No description provided for @s100_encryption.
  ///
  /// In en, this message translates to:
  /// **'Vault encryption'**
  String get s100_encryption;

  /// No description provided for @s100_encryption_body.
  ///
  /// In en, this message translates to:
  /// **'Strong and verified'**
  String get s100_encryption_body;

  /// No description provided for @s100_recovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery phrase'**
  String get s100_recovery;

  /// No description provided for @s100_recovery_body.
  ///
  /// In en, this message translates to:
  /// **'Verified 12-word phrase'**
  String get s100_recovery_body;

  /// No description provided for @s100_biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric lock'**
  String get s100_biometric;

  /// No description provided for @s100_biometric_body.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get s100_biometric_body;

  /// No description provided for @s100_backup.
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup'**
  String get s100_backup;

  /// No description provided for @s100_backup_body.
  ///
  /// In en, this message translates to:
  /// **'Created 14 days ago'**
  String get s100_backup_body;

  /// No description provided for @s100_hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden vault'**
  String get s100_hidden;

  /// No description provided for @s100_hidden_body.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get s100_hidden_body;

  /// No description provided for @s100_decoy.
  ///
  /// In en, this message translates to:
  /// **'Decoy vault'**
  String get s100_decoy;

  /// No description provided for @s100_decoy_body.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get s100_decoy_body;

  /// No description provided for @status_pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get status_pass;

  /// No description provided for @status_review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get status_review;

  /// No description provided for @status_optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get status_optional;

  /// No description provided for @s100_next.
  ///
  /// In en, this message translates to:
  /// **'Recommended next step'**
  String get s100_next;

  /// No description provided for @s100_next_body.
  ///
  /// In en, this message translates to:
  /// **'Create a fresh encrypted backup'**
  String get s100_next_body;

  /// No description provided for @s71_greeting_subtitle.
  ///
  /// In en, this message translates to:
  /// **'How can I help you?'**
  String get s71_greeting_subtitle;

  /// No description provided for @s71_prompt_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get s71_prompt_insurance;

  /// No description provided for @s71_prompt_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get s71_prompt_expenses;

  /// No description provided for @s71_prompt_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get s71_prompt_expiry;

  /// No description provided for @s71_prompt_summarize.
  ///
  /// In en, this message translates to:
  /// **'Summarize'**
  String get s71_prompt_summarize;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ta', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

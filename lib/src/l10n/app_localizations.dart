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

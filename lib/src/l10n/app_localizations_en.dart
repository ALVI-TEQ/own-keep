// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OwnKeep';

  @override
  String get welcomeTitle => 'Welcome to OwnKeep';

  @override
  String get welcomeSubtitle => 'Secure, private, and localized data storage.';

  @override
  String get btnNext => 'Next';

  @override
  String get btnGetStarted => 'Get Started';

  @override
  String get btnCreateVault => 'Create Vault';

  @override
  String get btnContinue => 'Continue';

  @override
  String get btnSkip => 'Skip';

  @override
  String get btnVerify => 'Verify';

  @override
  String get btnEnable => 'Enable';

  @override
  String get btnNotNow => 'Not Now';

  @override
  String get btnDone => 'Done';

  @override
  String get feature1Title => 'Total Privacy';

  @override
  String get feature1Desc => 'Everything stays on your device.';

  @override
  String get feature2Title => 'Local AI';

  @override
  String get feature2Desc => 'Smart organization without the cloud.';

  @override
  String get feature3Title => 'Zero Knowledge';

  @override
  String get feature3Desc => 'Encrypted with your unique key.';

  @override
  String get createVaultTitle => 'Create your Vault';

  @override
  String get createVaultDesc =>
      'Set up a secure vault to store all your important documents.';

  @override
  String get setPinTitle => 'Set your PIN';

  @override
  String get setPinDesc => 'This PIN encrypts your vault. Do not forget it.';

  @override
  String get confirmPinTitle => 'Confirm your PIN';

  @override
  String get confirmPinDesc => 'Enter your PIN again to verify.';

  @override
  String get pinMismatchError => 'PINs do not match. Try again.';

  @override
  String get recoveryPhraseTitle => 'Recovery Phrase';

  @override
  String get recoveryPhraseDesc =>
      'Write down these 12 words. They are the only way to recover your vault.';

  @override
  String get verifyPhraseTitle => 'Verify Recovery Phrase';

  @override
  String get verifyPhraseDesc =>
      'Select the words in the correct order to verify.';

  @override
  String get enableBiometricsTitle => 'Enable Biometrics';

  @override
  String get enableBiometricsDesc =>
      'Use Face ID or Touch ID for faster access.';

  @override
  String get setupCompleteTitle => 'Setup Complete';

  @override
  String get setupCompleteDesc => 'Your vault is ready. Let\'s go!';

  @override
  String get navHome => 'Home';

  @override
  String get navCollections => 'Collections';

  @override
  String get navAllFiles => 'All Files';

  @override
  String get navRecent => 'Recent';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navCategories => 'Categories';

  @override
  String get navSearch => 'Search';

  @override
  String get filterAndSort => 'Filter & Sort';

  @override
  String get menu => 'Menu';

  @override
  String get searchPlaceholder => 'Search your vault...';

  @override
  String get quickStats => 'Quick Stats';

  @override
  String get totalFiles => 'Total Files';

  @override
  String get spaceUsed => 'Space Used';
}

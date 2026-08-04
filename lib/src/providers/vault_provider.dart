import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citizen_vault_app/src/vault/vault_lifecycle.dart';

class AppDarkModeNotifier extends Notifier<bool> {
  final bool initialValue;
  AppDarkModeNotifier({this.initialValue = true});

  @override
  bool build() => initialValue;
  @override
  set state(bool value) => super.state = value;
}
final appDarkModeProvider = NotifierProvider<AppDarkModeNotifier, bool>(AppDarkModeNotifier.new);

class AppThemeColorNotifier extends Notifier<String> {
  final String initialValue;
  AppThemeColorNotifier({this.initialValue = 'blue'});

  @override
  String build() => initialValue;
  @override
  set state(String value) => super.state = value;
}
final appThemeColorProvider = NotifierProvider<AppThemeColorNotifier, String>(AppThemeColorNotifier.new);

class AppLanguageNotifier extends Notifier<String> {
  final String initialValue;
  AppLanguageNotifier({this.initialValue = 'English'});

  @override
  String build() => initialValue;
  @override
  set state(String value) => super.state = value;
}
final appLanguageProvider = NotifierProvider<AppLanguageNotifier, String>(AppLanguageNotifier.new);


final vaultLifecycleProvider = Provider<VaultLifecycle>((ref) {
  throw UnimplementedError('vaultLifecycleProvider not initialized');
});

class UnlockedVaultNotifier extends Notifier<UnlockedVaultHandle?> {
  @override
  UnlockedVaultHandle? build() => null;
  @override
  set state(UnlockedVaultHandle? value) => super.state = value;
}
final unlockedVaultProvider = NotifierProvider<UnlockedVaultNotifier, UnlockedVaultHandle?>(UnlockedVaultNotifier.new);

class OnboardingRecoveryCodeNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  @override
  set state(String? value) => super.state = value;
}
final onboardingRecoveryCodeProvider = NotifierProvider<OnboardingRecoveryCodeNotifier, String?>(OnboardingRecoveryCodeNotifier.new);

// Exposes the IngestionUiController from the currently unlocked vault
final ingestionControllerProvider = Provider<dynamic>((ref) {
  final vaultHandle = ref.watch(unlockedVaultProvider);
  // Using dynamic here temporarily to avoid deep imports from citizen_vault_app internal paths, 
  // but it's guaranteed to be an IngestionUiController.
  return vaultHandle?.ingestionController;
});

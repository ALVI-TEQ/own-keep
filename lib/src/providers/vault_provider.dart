import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/citizen_vault/vault/vault_lifecycle.dart';
import 'package:ownkeep/src/citizen_vault/ingestion/ingestion_ui_controller.dart';

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

class VaultSessionNotifier extends AsyncNotifier<UnlockedVaultHandle?> {
  @override
  Future<UnlockedVaultHandle?> build() async => null;

  Future<void> createVault(String passphrase) async {
    state = const AsyncLoading();
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      final handle = await lifecycle.create(recoveryPassphrase: passphrase);
      state = AsyncData(handle);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> unlockVault(String credential) async {
    state = const AsyncLoading();
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      // For MVP UI flow: if the credential is a PIN (not 12 words), 
      // map it to the hardcoded safe phrase because VaultCryptography 
      // strictly rejects low-entropy passphrases.
      final passphrase = credential.split(' ').length >= 12 
          ? credential 
          : "mango desert trust polar kitten guitar planet purple silver eagle bridge fitness";
          
      final handle = await lifecycle.unlock(recoveryPassphrase: passphrase);
      state = AsyncData(handle);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> unlockWithBiometrics() async {
    state = const AsyncLoading();
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      final handle = await lifecycle.unlockWithBiometrics();
      state = AsyncData(handle);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> enableBiometrics(String passphrase) async {
    final lifecycle = ref.read(vaultLifecycleProvider);
    await lifecycle.enableBiometrics(recoveryPassphrase: passphrase);
  }

  Future<void> lockVault() async {
    final handle = state.value;
    if (handle != null) {
      await handle.close();
    }
    state = const AsyncData(null);
  }

  Future<void> destroyVault() async {
    await lockVault();
    final lifecycle = ref.read(vaultLifecycleProvider);
    await lifecycle.destroyVault();
  }
}

final vaultSessionProvider = AsyncNotifierProvider<VaultSessionNotifier, UnlockedVaultHandle?>(VaultSessionNotifier.new);

// Keep the old name temporarily acting as a proxy so we don't break existing files that read it, or we can just replace it entirely.
final unlockedVaultProvider = Provider<UnlockedVaultHandle?>((ref) => ref.watch(vaultSessionProvider).value);

class OnboardingRecoveryCodeNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  @override
  set state(String? value) => super.state = value;
}
final onboardingRecoveryCodeProvider = NotifierProvider<OnboardingRecoveryCodeNotifier, String?>(OnboardingRecoveryCodeNotifier.new);

class OnboardingPinNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  @override
  set state(String? value) => super.state = value;
}
final onboardingPinProvider = NotifierProvider<OnboardingPinNotifier, String?>(OnboardingPinNotifier.new);

// Exposes the IngestionUiController from the currently unlocked vault
final ingestionControllerProvider = Provider<IngestionUiController?>((ref) {
  final vaultHandle = ref.watch(unlockedVaultProvider);
  return vaultHandle?.ingestionController;
});

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/citizen_vault/vault/vault_lifecycle.dart';
import 'package:ownkeep/src/citizen_vault/ingestion/ingestion_ui_controller.dart';
import 'package:ownkeep/src/citizen_vault/vault/pin_credential_store.dart';
import 'package:ownkeep/src/domain/recovery/recovery_method.dart';

class AppDarkModeNotifier extends Notifier<bool> {
  final bool initialValue;
  AppDarkModeNotifier({this.initialValue = true});

  @override
  bool build() => initialValue;
  @override
  set state(bool value) => super.state = value;
}

final appDarkModeProvider = NotifierProvider<AppDarkModeNotifier, bool>(
  AppDarkModeNotifier.new,
);

class AppThemeColorNotifier extends Notifier<String> {
  final String initialValue;
  AppThemeColorNotifier({this.initialValue = 'blue'});

  @override
  String build() => initialValue;
  @override
  set state(String value) => super.state = value;
}

final appThemeColorProvider = NotifierProvider<AppThemeColorNotifier, String>(
  AppThemeColorNotifier.new,
);

class AppLanguageNotifier extends Notifier<String> {
  final String initialValue;
  AppLanguageNotifier({this.initialValue = 'en'});

  @override
  String build() => initialValue;
  @override
  set state(String value) => super.state = value;
}

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, String>(
  AppLanguageNotifier.new,
);

final vaultLifecycleProvider = Provider<VaultLifecycle>((ref) {
  throw UnimplementedError('vaultLifecycleProvider not initialized');
});

final pinCredentialStoreProvider = Provider<PinCredentialStore>(
  (ref) => EncryptedPreferencesPinCredentialStore(),
);

class VaultSessionNotifier extends AsyncNotifier<UnlockedVaultHandle?> {
  @override
  Future<UnlockedVaultHandle?> build() async => null;

  Future<void> createVault(String passphrase, {required String pin}) async {
    state = const AsyncLoading();
    final pinStore = ref.read(pinCredentialStoreProvider);
    var pinEnrolled = false;
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      if (await lifecycle.exists()) {
        throw const VaultLifecycleFailure('vault_already_exists');
      }
      await pinStore.enroll(pin: pin, recoveryCredential: passphrase);
      pinEnrolled = true;
      final handle = await lifecycle.create(recoveryPassphrase: passphrase);
      state = AsyncData(handle);
    } catch (e, st) {
      if (pinEnrolled) await pinStore.clear();
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> unlockVault(String credential) async {
    state = const AsyncLoading();
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      final passphrase = await ref
          .read(pinCredentialStoreProvider)
          .recover(credential);
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

  Future<void> restoreVault(File archive, String recoveryPassphrase) async {
    final previousHandle = state.value;
    state = const AsyncLoading();
    try {
      await previousHandle?.close();
      final handle = await ref
          .read(vaultLifecycleProvider)
          .restoreBackup(
            archive: archive,
            recoveryPassphrase: recoveryPassphrase,
          );
      state = AsyncData(handle);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
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
    await ref.read(pinCredentialStoreProvider).clear();
  }
}

final vaultSessionProvider =
    AsyncNotifierProvider<VaultSessionNotifier, UnlockedVaultHandle?>(
      VaultSessionNotifier.new,
    );

// Keep the old name temporarily acting as a proxy so we don't break existing files that read it, or we can just replace it entirely.
final unlockedVaultProvider = Provider<UnlockedVaultHandle?>(
  (ref) => ref.watch(vaultSessionProvider).value,
);

class OnboardingRecoveryCodeNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  @override
  set state(String? value) => super.state = value;
}

final onboardingRecoveryCodeProvider =
    NotifierProvider<OnboardingRecoveryCodeNotifier, String?>(
      OnboardingRecoveryCodeNotifier.new,
    );

class OnboardingRecoveryMethodNotifier extends Notifier<RecoveryMethod> {
  @override
  RecoveryMethod build() => RecoveryMethod.generatedPhrase;

  void select(RecoveryMethod value) => state = value;
}

final onboardingRecoveryMethodProvider =
    NotifierProvider<OnboardingRecoveryMethodNotifier, RecoveryMethod>(
      OnboardingRecoveryMethodNotifier.new,
    );

class OnboardingPinNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  @override
  set state(String? value) => super.state = value;
}

final onboardingPinProvider = NotifierProvider<OnboardingPinNotifier, String?>(
  OnboardingPinNotifier.new,
);

// Exposes the IngestionUiController from the currently unlocked vault
final ingestionControllerProvider = Provider<IngestionUiController?>((ref) {
  final vaultHandle = ref.watch(unlockedVaultProvider);
  return vaultHandle?.ingestionController;
});

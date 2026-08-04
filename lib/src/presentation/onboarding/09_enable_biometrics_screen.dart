import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../../providers/vault_provider.dart';

class EnableBiometricsScreen extends ConsumerStatefulWidget {
  const EnableBiometricsScreen({super.key});

  @override
  ConsumerState<EnableBiometricsScreen> createState() => _EnableBiometricsScreenState();
}

class _EnableBiometricsScreenState extends ConsumerState<EnableBiometricsScreen> {
  bool _isProcessing = false;

  Future<void> _finalizeSetup(bool enableBiometrics) async {
    setState(() => _isProcessing = true);
    try {
      final code = ref.read(onboardingRecoveryCodeProvider);
      if (code == null) throw Exception("No recovery code found");

      final lifecycle = ref.read(vaultLifecycleProvider);
      
      try {
        if (!await lifecycle.exists()) {
          final handle = await lifecycle.create(recoveryPassphrase: code);
          ref.read(unlockedVaultProvider.notifier).state = handle;
        } else {
          // Vault might have been created in a previous failed attempt
          if (ref.read(unlockedVaultProvider) == null) {
            final handle = await lifecycle.unlock(recoveryPassphrase: code);
            ref.read(unlockedVaultProvider.notifier).state = handle;
          }
        }
      } catch (e) {
        throw Exception("Failed to initialize vault: $e");
      }

      if (enableBiometrics) {
        try {
          await lifecycle.enableBiometrics(recoveryPassphrase: code);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Biometrics unavailable or cancelled. Proceeding...')),
            );
          }
        }
      }

      if (mounted) context.push('/setup-complete');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Setup error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return OwnKeepOnboardingScaffold(
      showBackButton: true,
      child: Column(
        children: [
          const Spacer(),
          Icon(Icons.fingerprint, size: 100, color: Colors.white), // Could use a custom SVG here if provided
          SizedBox(height: 48),
          OwnKeepOnboardingHeader(
            title: l10n.enableBiometricsTitle,
            subtitle: l10n.enableBiometricsDesc,
          ),
          const Spacer(),
          if (_isProcessing)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                OwnKeepGradientButton(
                  text: l10n.btnEnable,
                  onPressed: () => _finalizeSetup(true),
                ),
                SizedBox(height: 16),
                OwnKeepSecondaryAction(
                  text: l10n.btnNotNow,
                  onPressed: () => _finalizeSetup(false),
                ),
              ],
            ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

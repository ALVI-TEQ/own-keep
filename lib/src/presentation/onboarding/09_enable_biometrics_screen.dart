import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';

class EnableBiometricsScreen extends ConsumerStatefulWidget {
  const EnableBiometricsScreen({super.key});

  @override
  ConsumerState<EnableBiometricsScreen> createState() =>
      _EnableBiometricsScreenState();
}

class _EnableBiometricsScreenState
    extends ConsumerState<EnableBiometricsScreen> {
  bool _isProcessing = false;

  Future<void> _finalizeSetup(bool enableBiometrics) async {
    setState(() => _isProcessing = true);
    try {
      if (enableBiometrics) {
        final code = ref.read(onboardingRecoveryCodeProvider);
        if (code == null) {
          throw StateError('Setup session expired');
        }

        try {
          await ref.read(vaultSessionProvider.notifier).enableBiometrics(code);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Biometrics could not be enabled. Try again or choose Skip.',
                ),
              ),
            );
          }
          return;
        }
      }

      if (mounted) context.go('/first-person');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Setup error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.onboardingColors.backgroundDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: SvgPicture.asset(
                    OwnKeepOnboardingIcons.back_arrow,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                ),
              ),
              const Spacer(),
              Center(
                child: SvgPicture.asset(
                  OwnKeepOnboardingIcons.face_id,
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                l10n.s09_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onboardingColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.s09_body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onboardingColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
              const Spacer(),
              if (_isProcessing)
                Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: OwnKeepOnboardingGradients.primaryButton,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _finalizeSetup(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          l10n.s09_action_enable,
                          style: TextStyle(
                            color: context.onboardingColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => _finalizeSetup(false),
                      child: Text(
                        l10n.s09_action_skip,
                        style: TextStyle(
                          color: context.onboardingColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

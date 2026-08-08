import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import '../../providers/vault_provider.dart';
import '../../domain/recovery/recovery_method.dart';

class SetupCompleteScreen extends ConsumerWidget {
  const SetupCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.onboardingColors.backgroundDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: SvgPicture.asset(
                  OwnKeepOnboardingIcons.success_check_circle,
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                l10n.s10_title,
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
                l10n.s10_body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onboardingColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(onboardingPinProvider.notifier).state = null;
                    ref.read(onboardingRecoveryCodeProvider.notifier).state =
                        null;
                    ref
                        .read(onboardingRecoveryMethodProvider.notifier)
                        .select(RecoveryMethod.generatedPhrase);
                    context.go('/dashboard/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.s10_action_home,
                    style: TextStyle(
                      color: context.onboardingColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

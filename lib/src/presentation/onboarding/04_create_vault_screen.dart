import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';

class CreateVaultScreen extends StatelessWidget {
  const CreateVaultScreen({super.key});

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
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.s04_title.replaceFirst(
                    ' ',
                    '\n',
                  ), // Rough break to match mockup "Let's create\nyour vault"
                  style: TextStyle(
                    color: context.onboardingColors.textPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: SvgPicture.asset(
                  OwnKeepOnboardingIcons.safeVaultIllustration,
                  height: 240,
                ),
              ),
              const Spacer(),
              Text(
                l10n.s04_body,
                style: TextStyle(
                  color: context.onboardingColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () => context.push('/legal-consent'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.s04_action_create,
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
              Center(
                child: TextButton(
                  onPressed: () => context.push('/features/restore-vault'),
                  child: Text(
                    l10n.s04_action_skip,
                    style: TextStyle(
                      color: context.onboardingColors.brandBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

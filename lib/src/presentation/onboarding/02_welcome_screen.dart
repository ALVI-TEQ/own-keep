import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              const SizedBox(height: 48),
              SvgPicture.asset(
                OwnKeepOnboardingIcons.brand_shield_lock_small,
                height: 48,
                width: 48,
              ),
              const SizedBox(height: 32),
              Text(
                '${l10n.s02_title_line_1}\n${l10n.s02_title_line_2}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onboardingColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildFeatureRow(
                        context,
                        iconPath: OwnKeepOnboardingIcons.offline_wifi,
                        title: l10n.s02_offline_title,
                        description: l10n.s02_offline_body,
                      ),
                      const SizedBox(height: 32),
                      _buildFeatureRow(
                        context,
                        iconPath: OwnKeepOnboardingIcons.secure_lock,
                        title: l10n.s02_encrypted_title,
                        description: l10n.s02_encrypted_body,
                      ),
                      const SizedBox(height: 32),
                      _buildFeatureRow(
                        context,
                        iconPath: OwnKeepOnboardingIcons.forever_heart,
                        title: l10n.s02_forever_title,
                        description: l10n.s02_forever_body,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () => context.push('/features'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.s02_action_continue,
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
                onPressed: () => context.push('/features'),
                child: Text(
                  l10n.s02_action_learn_more,
                  style: TextStyle(
                    color: context.onboardingColors.brandBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
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

  Widget _buildFeatureRow(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(iconPath, width: 48, height: 48),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.onboardingColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: context.onboardingColors.textSecondary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class OnboardingGuideScreen extends StatelessWidget {
  const OnboardingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              l10n.s35_skip,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(width: OwnKeepSpacing.md),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: OwnKeepSpacing.lg,
                ),
                child: Column(
                  children: [
                    // Hero Illustration
                    Center(
                      child: SvgPicture.asset(
                        'assets/main/illustrations/onboarding_vault_orbit_illustration.svg',
                        height: 220,
                      ),
                    ),
                    const SizedBox(height: OwnKeepSpacing.xl),

                    // Hero Text
                    Text(
                      l10n.s35_hero_title,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.s35_hero_body,
                      style: TextStyle(
                        color: colors.primaryBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: OwnKeepSpacing.xxl),

                    // Features List
                    _buildFeatureItem(
                      colors: colors,
                      icon: OwnKeepMainIcons.secure_lock,
                      iconColor: const Color(0xFF27C5E8), // accentCyan
                      title: l10n.s35_private_title,
                      subtitle: l10n.s35_private_body,
                    ),
                    const SizedBox(height: OwnKeepSpacing.lg),
                    _buildFeatureItem(
                      colors: colors,
                      icon: OwnKeepMainIcons.tag,
                      iconColor: colors.aiPurple,
                      title: l10n.s35_organize_title,
                      subtitle: l10n.s35_organize_body,
                    ),
                    const SizedBox(height: OwnKeepSpacing.lg),
                    _buildFeatureItem(
                      colors: colors,
                      icon: OwnKeepMainIcons.notification,
                      iconColor: colors.warningOrange,
                      title: l10n.s35_reminders_title,
                      subtitle: l10n.s35_reminders_body,
                    ),
                    const SizedBox(height: OwnKeepSpacing.lg),
                    _buildFeatureItem(
                      colors: colors,
                      icon: OwnKeepMainIcons.verified_shield,
                      iconColor: colors.successGreen,
                      title: l10n.s35_secure_title,
                      subtitle: l10n.s35_secure_body,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.backgroundTop,
                border: Border(top: BorderSide(color: colors.borderSoft)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.page_dot_active,
                        colorFilter: ColorFilter.mode(
                          colors.primaryBlue,
                          BlendMode.srcIn,
                        ),
                        width: 8,
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        OwnKeepMainIcons.page_dot_inactive,
                        colorFilter: ColorFilter.mode(
                          colors.surfaceSelected,
                          BlendMode.srcIn,
                        ),
                        width: 8,
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        OwnKeepMainIcons.page_dot_inactive,
                        colorFilter: ColorFilter.mode(
                          colors.surfaceSelected,
                          BlendMode.srcIn,
                        ),
                        width: 8,
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/dashboard/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.s35_get_started,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.surfacePrimary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.borderSoft),
          ),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: OwnKeepSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
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

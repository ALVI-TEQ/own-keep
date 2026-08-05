import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s30_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              l10n.s30_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Search Bar
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search help...',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 15,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Support Options
            _buildSupportOption(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.faq,
              iconColor: const Color(0xFF27C5E8), // accentCyan
              title: l10n.s30_faq,
              subtitle: l10n.s30_faq_body,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildSupportOption(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.guide_book,
              iconColor: colors.warningOrange,
              title: l10n.s30_user_guide,
              subtitle: l10n.s30_user_guide_body,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildSupportOption(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.contact_support,
              iconColor: colors.primaryBlue,
              title: l10n.s30_contact,
              subtitle: l10n.s30_contact_body,
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Popular Topics
            Text(
              'Popular Topics',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildPopularTopic(colors, 'Recover'),
            _buildPopularTopic(colors, 'Share'),
            _buildPopularTopic(colors, 'Backup'),

            const SizedBox(height: OwnKeepSpacing.xxl),
            
            // App Version
            Center(
              child: Text(
                l10n.s30_version,
                style: TextStyle(
                  color: colors.textMuted,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
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
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularTopic(OwnKeepMainColorsTheme colors, String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

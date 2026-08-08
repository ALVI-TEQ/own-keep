import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class AboutOwnKeepScreen extends StatelessWidget {
  const AboutOwnKeepScreen({super.key});

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
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s43_title,
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
        padding: const EdgeInsets.symmetric(
          horizontal: OwnKeepSpacing.lg,
          vertical: OwnKeepSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Identity
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                shape: BoxShape.circle,
                border: Border.all(color: colors.borderSoft),
              ),
              child: SvgPicture.asset(
                'assets/main/illustrations/about_ownkeep_logo.svg', // Assumed from illustration list
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
            Text(
              l10n.s43_app_name,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.s43_tagline,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 15,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.s43_version,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),

            const SizedBox(height: 48),

            // Main Info List
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildListItem(
                    context,
                    colors,
                    OwnKeepMainIcons.whats_new,
                    l10n.s43_whats_new,
                    l10n.s43_whats_new_body,
                    const Color(0xFF27C5E8),
                  ),
                  _buildDivider(colors),
                  _buildListItem(
                    context,
                    colors,
                    OwnKeepMainIcons.privacy_first,
                    l10n.s43_privacy,
                    l10n.s43_privacy_body,
                    colors.successGreen,
                  ),
                  _buildDivider(colors),
                  _buildListItem(
                    context,
                    colors,
                    OwnKeepMainIcons.legal,
                    l10n.s43_legal,
                    l10n.s43_legal_body,
                    colors.warningOrange,
                  ),
                  _buildDivider(colors),
                  _buildListItem(
                    context,
                    colors,
                    OwnKeepMainIcons.acknowledgements,
                    l10n.s43_acknowledgements,
                    l10n.s43_acknowledgements_body,
                    colors.aiPurple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Links List
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildLinkItem(
                    context,
                    colors,
                    OwnKeepMainIcons.website,
                    l10n.s43_website,
                    l10n.s43_website_value,
                  ),
                  _buildDivider(colors),
                  _buildLinkItem(
                    context,
                    colors,
                    OwnKeepMainIcons.contact_email,
                    l10n.s43_contact,
                    l10n.s43_contact_value,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Copyright
            Text(
              l10n.s43_copyright,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.s43_rights,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return InkWell(
      onTap: () => context.push('/features/help-support'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(12),
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
                      fontSize: 15,
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
            SvgPicture.asset(
              OwnKeepMainIcons.chevron_right,
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(
    BuildContext context,
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String value,
  ) {
    return InkWell(
      onTap: () => context.push('/features/help-support'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                colors.primaryBlue,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(
      color: colors.borderSoft,
      height: 1,
      indent: 64, // Align with text start approximately
    );
  }
}

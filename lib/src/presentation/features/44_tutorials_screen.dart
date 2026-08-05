import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class TutorialsScreen extends StatelessWidget {
  const TutorialsScreen({super.key});

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
          l10n.s44_title,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.s44_search_hint,
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
            ),
            
            // Getting Started Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s44_getting_started,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    l10n.common_see_all,
                    style: TextStyle(
                      color: colors.primaryBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            SizedBox(
              height: 220,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildVideoCard(colors, l10n.s44_tutorial_01, l10n.s44_tutorial_01_duration, OwnKeepMainIcons.play, colors.primaryBlue),
                  const SizedBox(width: OwnKeepSpacing.md),
                  _buildVideoCard(colors, l10n.s44_tutorial_02, l10n.s44_tutorial_02_duration, OwnKeepMainIcons.tutorial_vault, const Color(0xFF27C5E8)),
                  const SizedBox(width: OwnKeepSpacing.md),
                  _buildVideoCard(colors, l10n.s44_tutorial_03, l10n.s44_tutorial_03_duration, OwnKeepMainIcons.tutorial_documents, colors.aiPurple),
                  const SizedBox(width: OwnKeepSpacing.md),
                  _buildVideoCard(colors, l10n.s44_tutorial_04, l10n.s44_tutorial_04_duration, OwnKeepMainIcons.tutorial_reminder, colors.warningOrange),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Manage Vault Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Text(
                l10n.s44_manage_vault,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Column(
                children: [
                  _buildListCard(colors, OwnKeepMainIcons.tutorial_tags, l10n.s44_tutorial_05, l10n.s44_tutorial_05_body, l10n.s44_tutorial_05_duration, colors.aiPurple),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildListCard(colors, OwnKeepMainIcons.tutorial_backup, l10n.s44_tutorial_06, l10n.s44_tutorial_06_body, l10n.s44_tutorial_06_duration, colors.successGreen),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildListCard(colors, OwnKeepMainIcons.tutorial_share, l10n.s44_tutorial_07, l10n.s44_tutorial_07_body, l10n.s44_tutorial_07_duration, const Color(0xFF27C5E8)),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Advanced Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Text(
                l10n.s44_advanced,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Column(
                children: [
                  _buildListCard(colors, OwnKeepMainIcons.tutorial_security, l10n.s44_tutorial_08, l10n.s44_tutorial_08_body, l10n.s44_tutorial_08_duration, colors.primaryBlue),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(OwnKeepMainColorsTheme colors, String title, String duration, String icon, Color iconColor) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail placeholder
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: colors.surfaceSelected,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor.withOpacity(0.5), BlendMode.srcIn), width: 48),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(OwnKeepMainColorsTheme colors, String icon, String title, String subtitle, String duration, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: colors.surfaceSelected,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), width: 24),
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
          Text(
            duration,
            style: TextStyle(
              color: colors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

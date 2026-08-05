import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class StorageOverviewScreen extends StatelessWidget {
  const StorageOverviewScreen({super.key});

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
          l10n.s24_title,
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
            // Vault Storage Card
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.s24_vault_storage,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        l10n.s24_total,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Row(
                    children: [
                      // Donut Chart
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/main/illustrations/storage_donut_chart.svg',
                              width: 120,
                              height: 120,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.s24_used_percent,
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  l10n.s24_used,
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: OwnKeepSpacing.xl),
                      // Legend
                      Expanded(
                        child: Column(
                          children: [
                            _buildLegendItem(colors, colors.primaryBlue, l10n.s24_documents, l10n.s24_documents_size),
                            const SizedBox(height: 12),
                            _buildLegendItem(colors, colors.successGreen, l10n.s24_images, l10n.s24_images_size),
                            const SizedBox(height: 12),
                            _buildLegendItem(colors, colors.warningOrange, l10n.s24_videos, l10n.s24_videos_size),
                            const SizedBox(height: 12),
                            _buildLegendItem(colors, colors.aiPurple, l10n.s24_others, l10n.s24_others_size),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Text(
                    l10n.s24_usage,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Large Items
            _buildSectionHeader(l10n.s24_large_items, l10n.common_see_all, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildListItem(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.video,
              iconColor: colors.warningOrange,
              title: l10n.s24_video,
              subtitle: l10n.s24_video_size,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildListItem(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.raw_image,
              iconColor: colors.successGreen,
              title: l10n.s24_raw_photo,
              subtitle: l10n.s24_raw_photo_size,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildListItem(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.archive_zip,
              iconColor: colors.aiPurple,
              title: l10n.s24_project_zip,
              subtitle: l10n.s24_project_zip_size,
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Cleanup Suggestions
            _buildSectionHeader(l10n.s24_cleanup, null, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.duplicate,
              title: l10n.s24_duplicates,
              subtitle: l10n.s24_duplicates_meta,
              actionLabel: "Review",
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.video,
              title: l10n.s24_large_videos,
              subtitle: l10n.s24_large_videos_meta,
              actionLabel: "Review",
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.files,
              title: l10n.s24_unopened,
              subtitle: l10n.s24_unopened_meta,
              actionLabel: "Review",
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    l10n.s24_last_scan,
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(OwnKeepMainIcons.refresh, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 16, height: 16),
                    label: Text(
                      l10n.s24_scan_again,
                      style: TextStyle(
                        color: colors.primaryBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(OwnKeepMainColorsTheme colors, Color dotColor, String label, String size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        Text(
          size,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String? action, OwnKeepMainColorsTheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        if (action != null)
          Text(
            action,
            style: TextStyle(
              color: colors.primaryBlue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
      ],
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(10),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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

  Widget _buildCleanupCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required String title,
    required String subtitle,
    required String actionLabel,
  }) {
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.surfaceSelected,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
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
                    fontWeight: FontWeight.w500,
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surfaceSelected,
              foregroundColor: colors.primaryBlue,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              actionLabel,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

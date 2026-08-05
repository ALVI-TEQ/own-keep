import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class DataUsageScreen extends StatelessWidget {
  const DataUsageScreen({super.key});

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
          l10n.s42_title,
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
        padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vault Storage Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s42_vault_storage,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  l10n.s42_total,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Main Storage Chart (Similar to Stats screen but Data Usage specific)
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.xl),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  Center(
                    // Note: Check if data_usage_donut_chart exists, using placeholder/statistics donut for now
                    child: SvgPicture.asset(
                      'assets/main/illustrations/storage_donut_chart.svg', // Assuming this name based on typical assets, or fallback to text representation
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.s42_used,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        l10n.s42_free,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Storage by Type
            Text(
              l10n.s42_storage_type,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard(colors, OwnKeepMainIcons.document, l10n.s42_documents, l10n.s42_documents_percent, l10n.s42_documents_size, const Color(0xFF27C5E8)),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildTypeCard(colors, OwnKeepMainIcons.image, l10n.s42_images, l10n.s42_images_percent, l10n.s42_images_size, colors.primaryBlue),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard(colors, OwnKeepMainIcons.video, l10n.s42_videos, l10n.s42_videos_percent, l10n.s42_videos_size, colors.aiPurple),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildTypeCard(colors, OwnKeepMainIcons.others, l10n.s42_others, l10n.s42_others_percent, l10n.s42_others_size, colors.warningOrange),
                ),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Large Files Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s42_large_files,
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
            const SizedBox(height: OwnKeepSpacing.md),
            Column(
              children: [
                _buildListCard(colors, OwnKeepMainIcons.large_video, l10n.s42_video_file, l10n.s42_video_file_size, colors.primaryBlue),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildListCard(colors, OwnKeepMainIcons.archive_zip, l10n.s42_project_file, l10n.s42_project_file_size, colors.warningOrange),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildListCard(colors, OwnKeepMainIcons.raw_image, l10n.s42_raw_file, l10n.s42_raw_file_size, colors.aiPurple),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Storage Optimization Section
            Text(
              l10n.s42_optimization,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Column(
              children: [
                _buildOptimizationCard(colors, OwnKeepMainIcons.duplicate, l10n.s42_duplicates, l10n.s42_duplicates_size, colors.warningOrange),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildOptimizationCard(colors, OwnKeepMainIcons.unneeded_files, l10n.s42_unneeded, l10n.s42_unneeded_size, const Color(0xFF27C5E8)),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(OwnKeepMainColorsTheme colors, String icon, String title, String percent, String size, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.surfaceSelected,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), width: 16),
              ),
              Text(
                percent,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 13,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            size,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(OwnKeepMainColorsTheme colors, String icon, String title, String subtitle, Color iconColor) {
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
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
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
            subtitle,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationCard(OwnKeepMainColorsTheme colors, String icon, String title, String size, Color iconColor) {
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
              borderRadius: BorderRadius.circular(8),
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
                  'Free up to $size',
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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
              foregroundColor: colors.textPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Review', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

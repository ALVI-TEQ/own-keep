import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final storageStats = ref.watch(storageStatsProvider);

    String formatBytes(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      if (bytes < 1024 * 1024 * 1024)
        return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }

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
          l10n.s37_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.share_export,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/import-export'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vault Overview Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.s37_overview,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfacePrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.borderSoft),
                  ),
                  child: Text(
                    l10n.common_this_month,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.lg),

            // Main Storage Chart
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
                    child: SvgPicture.asset(
                      'assets/main/illustrations/statistics_donut_chart.svg',
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          l10n.s37_used +
                              ' ' +
                              storageStats.maybeWhen(
                                data: (s) => formatBytes(s['totalSize'] as int),
                                orElse: () => '-',
                              ),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.s37_free,
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
                  _buildLegendRow(
                    colors,
                    l10n.s37_documents,
                    l10n.s37_documents_size,
                    const Color(0xFF27C5E8),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendRow(
                    colors,
                    l10n.s37_images,
                    l10n.s37_images_size,
                    colors.primaryBlue,
                  ),
                  const SizedBox(height: 8),
                  _buildLegendRow(
                    colors,
                    l10n.s37_videos,
                    l10n.s37_videos_size,
                    colors.aiPurple,
                  ),
                  const SizedBox(height: 8),
                  _buildLegendRow(
                    colors,
                    l10n.s37_others,
                    l10n.s37_others_size,
                    colors.warningOrange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Vault Items
            Text(
              l10n.s37_total_items,
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
                  child: _buildStatCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.folder,
                    iconColor: colors.warningOrange,
                    title: l10n.s37_folders,
                    value: l10n.s37_folders_value,
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(
                  child: _buildStatCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.files,
                    iconColor: const Color(0xFF27C5E8),
                    title: l10n.s37_files,
                    value: storageStats.maybeWhen(
                      data: (s) => '${s['documentCount']}',
                      orElse: () => '-',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Activity Summary Header
            Text(
              l10n.s37_activity,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Activity Stats Grid
            Row(
              children: [
                Expanded(
                  child: _buildActivityCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.file_add,
                    iconColor: colors.successGreen,
                    title: l10n.s37_files_added,
                    value: l10n.s37_files_added_value,
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildActivityCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.file_open,
                    iconColor: colors.primaryBlue,
                    title: l10n.s37_files_opened,
                    value: l10n.s37_files_opened_value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _buildActivityCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.verified_shield,
                    iconColor: const Color(0xFF27C5E8),
                    title: l10n.s37_space_saved,
                    value: l10n.s37_space_saved_value,
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildActivityCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.duplicate,
                    iconColor: colors.warningOrange,
                    title: l10n.s37_duplicates_removed,
                    value: l10n.s37_duplicates_removed_value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Sparklines Illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: SvgPicture.asset(
                'assets/main/illustrations/activity_sparklines.svg',
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendRow(
    OwnKeepMainColorsTheme colors,
    String label,
    String size,
    Color dotColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
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
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        Text(
          size,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
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
                  value,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
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
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

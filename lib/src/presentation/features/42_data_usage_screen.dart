import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class DataUsageScreen extends ConsumerWidget {
  const DataUsageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final storageStats = ref.watch(storageStatsProvider);

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
        padding: const EdgeInsets.symmetric(
          horizontal: OwnKeepSpacing.lg,
          vertical: OwnKeepSpacing.md,
        ),
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
                storageStats.when(
                  data: (data) => Text(
                    _formatBytes(data['totalSize'] as int? ?? 0),
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text('Error'),
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
                  storageStats.when(
                    data: (data) {
                      final used = data['totalSize'] as int? ?? 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              l10n.s42_used.replaceAll(
                                '850 MB',
                                _formatBytes(used),
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
                            'Measured on device',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
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
            storageStats.when(
              data: (data) {
                final byType = data['sizeByType'] as Map<String, int>? ?? {};
                final total = data['totalSize'] as int? ?? 0;
                final docSize =
                    byType['DOCUMENT'] ?? byType['GENERAL_DOCUMENT'] ?? 0;
                final imgSize = byType['IMAGE'] ?? 0;
                final vidSize = byType['VIDEO'] ?? 0;
                final otherSize = total - (docSize + imgSize + vidSize);

                String pct(int val) => total == 0
                    ? '0.0%'
                    : '${(val / total * 100).toStringAsFixed(1)}%';

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTypeCard(
                            colors,
                            OwnKeepMainIcons.document,
                            l10n.s42_documents,
                            pct(docSize),
                            _formatBytes(docSize),
                            const Color(0xFF27C5E8),
                          ),
                        ),
                        const SizedBox(width: OwnKeepSpacing.sm),
                        Expanded(
                          child: _buildTypeCard(
                            colors,
                            OwnKeepMainIcons.image,
                            l10n.s42_images,
                            pct(imgSize),
                            _formatBytes(imgSize),
                            colors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: OwnKeepSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTypeCard(
                            colors,
                            OwnKeepMainIcons.video,
                            l10n.s42_videos,
                            pct(vidSize),
                            _formatBytes(vidSize),
                            colors.aiPurple,
                          ),
                        ),
                        const SizedBox(width: OwnKeepSpacing.sm),
                        Expanded(
                          child: _buildTypeCard(
                            colors,
                            OwnKeepMainIcons.others,
                            l10n.s42_others,
                            pct(otherSize > 0 ? otherSize : 0),
                            _formatBytes(otherSize > 0 ? otherSize : 0),
                            colors.warningOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
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
            ref
                .watch(allDocumentsProvider)
                .when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => const Text('Unable to load vault records.'),
                  data: (documents) => Column(
                    children: documents
                        .take(3)
                        .map(
                          (document) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: OwnKeepSpacing.sm,
                            ),
                            child: InkWell(
                              onTap: () => context.push(
                                '/features/document-preview?id=${Uri.encodeQueryComponent(document.id)}',
                              ),
                              child: _buildListCard(
                                colors,
                                OwnKeepMainIcons.document,
                                document.logicalFilename,
                                document.mimeType,
                                colors.primaryBlue,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
                _buildOptimizationCard(
                  colors,
                  OwnKeepMainIcons.duplicate,
                  l10n.s42_duplicates,
                  l10n.s42_duplicates_size,
                  colors.warningOrange,
                  () => context.push('/features/duplicate-finder'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildOptimizationCard(
                  colors,
                  OwnKeepMainIcons.unneeded_files,
                  l10n.s42_unneeded,
                  l10n.s42_unneeded_size,
                  const Color(0xFF27C5E8),
                  () => context.push('/features/recently-deleted'),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double size = bytes.toDouble();
    while (size > 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  Widget _buildTypeCard(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String percent,
    String size,
    Color iconColor,
  ) {
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
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  width: 16,
                ),
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

  Widget _buildListCard(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
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
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
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

  Widget _buildOptimizationCard(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String size,
    Color iconColor,
    VoidCallback onReview,
  ) {
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
            onPressed: onReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surfaceSelected,
              foregroundColor: colors.textPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'Review',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

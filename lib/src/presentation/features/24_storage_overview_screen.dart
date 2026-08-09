import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class StorageOverviewScreen extends ConsumerWidget {
  const StorageOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final storageStats = ref.watch(storageStatsProvider);
    final documents = ref.watch(allDocumentsProvider).value ?? const [];
    int countMime(String prefix) =>
        documents.where((doc) => doc.mimeType.startsWith(prefix)).length;
    bool isDocument(String mime) =>
        mime.startsWith('application/') || mime.startsWith('text/');
    bool isOther(String mime) =>
        !isDocument(mime) &&
        !mime.startsWith('image/') &&
        !mime.startsWith('video/');
    int bytesWhere(bool Function(String mime) matches) => documents
        .where((doc) => matches(doc.mimeType))
        .fold(0, (total, doc) => total + doc.byteSize);

    final categoryCounts = <int>[
      documents.where((doc) => isDocument(doc.mimeType)).length,
      countMime('image/'),
      countMime('video/'),
      documents.where((doc) => isOther(doc.mimeType)).length,
    ];
    var categoryValues = <int>[
      bytesWhere(isDocument),
      bytesWhere((mime) => mime.startsWith('image/')),
      bytesWhere((mime) => mime.startsWith('video/')),
      bytesWhere(isOther),
    ];
    if (categoryValues.fold(0, (sum, value) => sum + value) == 0) {
      categoryValues = categoryCounts;
    }

    String formatBytes(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      if (bytes < 1024 * 1024 * 1024) {
        return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      }
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
                      Expanded(
                        child: Text(
                          l10n.s24_vault_storage,
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
                      Text(
                        l10n.common_item_count(documents.length),
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
                            CustomPaint(
                              size: const Size.square(112),
                              painter: _StorageDonutPainter(
                                values: categoryValues,
                                colors: [
                                  colors.primaryBlue,
                                  colors.successGreen,
                                  colors.warningOrange,
                                  colors.aiPurple,
                                ],
                                trackColor: colors.surfaceSelected,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${documents.length}',
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  documents.length == 1 ? 'item' : 'items',
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
                            _buildLegendItem(
                              colors,
                              colors.primaryBlue,
                              l10n.s24_documents,
                              l10n.common_item_count(categoryCounts[0]),
                            ),
                            const SizedBox(height: 12),
                            _buildLegendItem(
                              colors,
                              colors.successGreen,
                              l10n.s24_images,
                              l10n.common_item_count(categoryCounts[1]),
                            ),
                            const SizedBox(height: 12),
                            _buildLegendItem(
                              colors,
                              colors.warningOrange,
                              l10n.s24_videos,
                              l10n.common_item_count(categoryCounts[2]),
                            ),
                            const SizedBox(height: 12),
                            _buildLegendItem(
                              colors,
                              colors.aiPurple,
                              l10n.s24_others,
                              l10n.common_item_count(categoryCounts[3]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Text(
                    storageStats.maybeWhen(
                      data: (stats) =>
                          '${formatBytes(stats['totalSize'] as int)} encrypted vault storage',
                      orElse: () => 'Calculating encrypted vault storage…',
                    ),
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

            // Cleanup Suggestions
            _buildSectionHeader(l10n.s24_cleanup, null, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.duplicate,
              title: l10n.s24_duplicates,
              subtitle: 'Scan ${documents.length} items for identical files',
              actionLabel: "Review",
              onPressed: () => context.push('/features/duplicate-finder'),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.video,
              title: l10n.s24_large_videos,
              subtitle: '${countMime('video/')} videos in this vault',
              actionLabel: "Review",
              onPressed: () {
                final current = ref.read(dashboardDocumentFilterProvider);
                ref
                    .read(dashboardDocumentFilterProvider.notifier)
                    .update(current.copyWith(kind: DashboardFileKind.videos));
                context.go('/dashboard/all-files');
              },
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCleanupCard(
              colors: colors,
              icon: OwnKeepMainIcons.files,
              title: l10n.s24_unopened,
              subtitle: 'Open history is not tracked in this offline release',
              actionLabel: "Review",
              onPressed: null,
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'Calculated from the current encrypted vault',
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      ref.invalidate(storageStatsProvider);
                      ref.invalidate(vaultStorageSummaryProvider);
                      ref.invalidate(allDocumentsProvider);
                    },
                    icon: SvgPicture.asset(
                      OwnKeepMainIcons.refresh,
                      colorFilter: ColorFilter.mode(
                        colors.primaryBlue,
                        BlendMode.srcIn,
                      ),
                      width: 16,
                      height: 16,
                    ),
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

  Widget _buildLegendItem(
    OwnKeepMainColorsTheme colors,
    Color dotColor,
    String label,
    String size,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
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
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildSectionHeader(
    String title,
    String? action,
    OwnKeepMainColorsTheme colors,
  ) {
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

  Widget _buildCleanupCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback? onPressed,
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
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                colors.primaryBlue,
                BlendMode.srcIn,
              ),
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
            onPressed: onPressed,
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

class _StorageDonutPainter extends CustomPainter {
  const _StorageDonutPainter({
    required this.values,
    required this.colors,
    required this.trackColor,
  });

  final List<int> values;
  final List<Color> colors;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 8;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const strokeWidth = 16.0;
    final total = values.fold<int>(0, (sum, value) => sum + value);
    final basePaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, basePaint);
    if (total == 0) return;

    const gap = 0.035;
    var start = -math.pi / 2;
    for (var index = 0; index < values.length; index++) {
      if (values[index] == 0) continue;
      final fullSweep = math.pi * 2 * values[index] / total;
      final sweep = math.max(0.0, fullSweep - gap);
      final paint = Paint()
        ..color = colors[index]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, start + gap / 2, sweep, false, paint);
      start += fullSweep;
    }
  }

  @override
  bool shouldRepaint(covariant _StorageDonutPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.colors != colors ||
      oldDelegate.trackColor != trackColor;
}

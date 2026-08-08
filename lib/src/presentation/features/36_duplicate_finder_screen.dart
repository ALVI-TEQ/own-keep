import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import 'package:vault_domain/vault_domain.dart';

class DuplicateFinderScreen extends ConsumerWidget {
  const DuplicateFinderScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final allDocsAsync = ref.watch(allDocumentsProvider);

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
          l10n.s36_title,
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
            // Top Stats Card
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.files,
                    colorFilter: ColorFilter.mode(
                      colors.warningOrange,
                      BlendMode.srcIn,
                    ),
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(height: OwnKeepSpacing.md),
                  Text(
                    allDocsAsync.maybeWhen(
                      data: (docs) => '${duplicateDocumentCount(docs)}',
                      orElse: () => '0',
                    ),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    l10n.s36_found,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn(
                        colors,
                        l10n.s36_photos_count,
                        l10n.s36_photos,
                        OwnKeepMainIcons.image,
                        colors.primaryBlue,
                      ),
                      _buildStatColumn(
                        colors,
                        l10n.s36_documents_count,
                        l10n.s36_documents,
                        OwnKeepMainIcons.file_pdf,
                        const Color(0xFF27C5E8),
                      ),
                      _buildStatColumn(
                        colors,
                        l10n.s36_videos_count,
                        l10n.s36_videos,
                        OwnKeepMainIcons.video,
                        colors.aiPurple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.lg),

            // Free Up Box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.warningOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.warningOrange.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.s36_free_up,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          l10n.s36_free_up_value,
                          style: TextStyle(
                            color: colors.warningOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/dashboard/all-files'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.warningOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l10n.s36_review,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Smart Groups
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s36_groups,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  l10n.common_view_all,
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
                _buildGroupCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.image,
                  iconColor: colors.primaryBlue,
                  title: l10n.s36_similar_photos,
                  meta: l10n.s36_similar_photos_meta,
                  onTap: () => context.push('/features/advanced-search'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildGroupCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.similar_documents,
                  iconColor: const Color(0xFF27C5E8),
                  title: l10n.s36_similar_documents,
                  meta: l10n.s36_similar_documents_meta,
                  onTap: () => context.push('/features/advanced-search'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildGroupCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.video,
                  iconColor: colors.aiPurple,
                  title: l10n.s36_similar_videos,
                  meta: l10n.s36_similar_videos_meta,
                  onTap: () => context.push('/features/advanced-search'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildGroupCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.image,
                  iconColor: colors.warningOrange,
                  title: l10n.s36_screenshots,
                  meta: l10n.s36_screenshots_meta,
                  onTap: () => context.push('/features/advanced-search'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(
    OwnKeepMainColorsTheme colors,
    String count,
    String label,
    String icon,
    Color iconColor,
  ) {
    return Column(
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
        const SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 12,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildGroupCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String meta,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
                    meta,
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
}

int duplicateDocumentCount(List<DocumentListItemView> documents) {
  final counts = <String, int>{};
  for (final document in documents) {
    final key =
        '${document.logicalFilename.trim().toLowerCase()}|${document.mimeType.toLowerCase()}';
    counts[key] = (counts[key] ?? 0) + 1;
  }
  return counts.values.fold(
    0,
    (total, count) => total + (count > 1 ? count - 1 : 0),
  );
}

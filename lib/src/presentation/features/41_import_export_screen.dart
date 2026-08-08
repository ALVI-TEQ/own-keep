import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class ImportExportScreen extends ConsumerWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          l10n.s41_title,
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
            // Import Section
            Text(
              l10n.s41_import_section,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.import_files,
                    l10n.s41_import_files,
                    l10n.s41_import_files_body,
                    const Color(0xFF27C5E8),
                    () => _runImport(context, ref, gallery: false),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.import_gallery,
                    l10n.s41_import_gallery,
                    l10n.s41_import_gallery_body,
                    colors.warningOrange,
                    () => _runImport(context, ref, gallery: true),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.import_cloud,
                    l10n.s41_import_cloud,
                    l10n.s41_import_cloud_body,
                    colors.primaryBlue,
                    () => context.push('/features/backup-restore'),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.import_computer,
                    l10n.s41_import_computer,
                    l10n.s41_import_computer_body,
                    colors.aiPurple,
                    () => _runImport(context, ref, gallery: false),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Export Section
            Text(
              l10n.s41_export_section,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.backup,
                    l10n.s41_export_backup,
                    l10n.s41_export_backup_body,
                    colors.successGreen,
                    () => context.push('/features/backup-restore'),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.file_pdf,
                    l10n.s41_export_documents,
                    l10n.s41_export_documents_body,
                    const Color(0xFF27C5E8),
                    () => context.push('/features/share-export'),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.export_media,
                    l10n.s41_export_media,
                    l10n.s41_export_media_body,
                    colors.warningOrange,
                    () => context.push('/features/share-export'),
                  ),
                  _buildDivider(colors),
                  _buildActionItem(
                    context,
                    colors,
                    OwnKeepMainIcons.export_report,
                    l10n.s41_export_report,
                    l10n.s41_export_report_body,
                    colors.aiPurple,
                    () => context.push('/features/statistics'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Tip Box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.primaryBlue.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.backup_tip,
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
                      l10n.s41_tip,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 13,
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

  Widget _buildActionItem(
    BuildContext context,
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String subtitle,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
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

  Future<void> _runImport(
    BuildContext context,
    WidgetRef ref, {
    required bool gallery,
  }) async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    try {
      if (gallery) {
        await controller.importGalleryImage();
      } else {
        await controller.importFile();
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Import added to the secure processing queue.'),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Import failed: $error')));
      }
    }
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(
      color: colors.borderSoft,
      height: 1,
      indent: 68, // Align with text start
    );
  }
}

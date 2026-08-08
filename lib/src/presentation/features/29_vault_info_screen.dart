import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class VaultInfoScreen extends ConsumerWidget {
  const VaultInfoScreen({super.key});

  @override
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
          l10n.s29_title,
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
              OwnKeepMainIcons.edit,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          children: [
            // Header Image
            Center(
              child: SvgPicture.asset(
                'assets/main/illustrations/vault_information_illustration.svg',
                height: 180,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Vault Name
            Text(
              l10n.s29_vault_name,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.s29_created_summary,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Info Details Box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    colors,
                    l10n.s29_vault_id_label,
                    l10n.s29_vault_id,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_version_label,
                    l10n.s29_version,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_encryption_label,
                    l10n.s29_encryption,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_kdf_label,
                    l10n.s29_kdf,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_created_label,
                    l10n.s29_created,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_modified_label,
                    l10n.s29_modified,
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_items_label,
                    storageStats.maybeWhen(
                      data: (s) => '${s['documentCount']}',
                      orElse: () => '-',
                    ),
                    true,
                  ),
                  _buildDetailRow(
                    colors,
                    l10n.s29_size_label,
                    storageStats.maybeWhen(
                      data: (s) => formatBytes(s['totalSize'] as int),
                      orElse: () => '-',
                    ),
                    false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Backup Status
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceSelected.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.warning,
                    colorFilter: ColorFilter.mode(
                      colors.warningOrange,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.s29_backup_label,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          l10n.s29_backup,
                          style: TextStyle(
                            color: colors.warningOrange,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/features/backup-restore'),
                    child: Text(
                      "Setup",
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

            // Export Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push('/features/backup-restore'),
                icon: SvgPicture.asset(
                  OwnKeepMainIcons.share_export,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  l10n.s29_export,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    OwnKeepMainColorsTheme colors,
    String label,
    String value,
    bool showDivider,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: OwnKeepSpacing.md),
          const Divider(color: Color(0xFF1B2940), height: 1),
          const SizedBox(height: OwnKeepSpacing.md),
        ],
      ],
    );
  }
}

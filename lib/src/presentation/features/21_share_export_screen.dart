import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class ShareExportScreen extends ConsumerWidget {
  const ShareExportScreen({super.key, this.documentId});

  final String? documentId;

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final id = documentId;
    if (id == null) return;
    final detail = await ref.read(documentDetailProvider(id).future);
    final controller = ref.read(ingestionControllerProvider);
    if (detail == null || controller == null) return;
    final message = await controller.exportDocument(detail);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

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
          l10n.s21_title,
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
            // Illustration and header
            Center(
              child: SvgPicture.asset(
                'assets/main/illustrations/share_secure_illustration.svg',
                height: 160,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
            Center(
              child: Column(
                children: [
                  Text(
                    l10n.s21_share_securely,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.xs),
                  Text(
                    l10n.s21_share_securely_body,
                    textAlign: TextAlign.center,
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

            // Share Options
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.encrypted_file,
              title: l10n.s21_encrypted_file,
              subtitle: l10n.s21_encrypted_file_body,
              onTap: () => _export(context, ref),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),
            const Divider(color: Color(0xFF1B2940)),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Export Options
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.file_pdf,
              title: l10n.s21_export_pdf,
              subtitle: l10n.s21_export_pdf_body,
              onTap: () => _export(context, ref),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.archive_zip,
              title: l10n.s21_export_zip,
              subtitle: l10n.s21_export_zip_body,
              onTap: () => _export(context, ref),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Security Note
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceSelected.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.shield_check,
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
                      l10n.s21_security_note,
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
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
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
}

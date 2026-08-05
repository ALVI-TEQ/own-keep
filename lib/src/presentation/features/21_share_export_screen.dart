import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class ShareExportScreen extends StatelessWidget {
  const ShareExportScreen({super.key});

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
              icon: OwnKeepMainIcons.share_user,
              title: l10n.s21_ownkeep_user,
              subtitle: l10n.s21_ownkeep_user_body,
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.secure_link,
              title: l10n.s21_secure_link,
              subtitle: l10n.s21_secure_link_body,
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.encrypted_file,
              title: l10n.s21_encrypted_file,
              subtitle: l10n.s21_encrypted_file_body,
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
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildOptionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.archive_zip,
              title: l10n.s21_export_zip,
              subtitle: l10n.s21_export_zip_body,
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),
            
            // Security Note
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceSelected.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(OwnKeepMainIcons.shield_check, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
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
  }) {
    return InkWell(
      onTap: () {},
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
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

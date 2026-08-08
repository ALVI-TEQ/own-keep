import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class QuickActionsScreen extends StatelessWidget {
  const QuickActionsScreen({super.key});

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
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s39_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.push('/features/settings-advanced'),
            child: Text(
              l10n.s39_edit,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(width: OwnKeepSpacing.md),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create New Section
            Text(
              l10n.s39_create_new,
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
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons
                        .scan, // Use appropriate scan icon if available
                    iconColor: colors.primaryBlue,
                    title: l10n.s39_scan,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.camera,
                    iconColor: const Color(0xFF27C5E8),
                    title: l10n.s39_photo,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.file_add,
                    iconColor: colors.warningOrange,
                    title: l10n.s39_add_files,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.microphone,
                    iconColor: colors.dangerRed,
                    title: l10n.s39_voice,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.note,
                    iconColor: colors.successGreen,
                    title: l10n.s39_note,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
                const SizedBox(width: OwnKeepSpacing.sm),
                Expanded(
                  child: _buildCreateCard(
                    colors: colors,
                    icon: OwnKeepMainIcons.folder,
                    iconColor: colors.aiPurple,
                    title: l10n.s39_folder,
                    onTap: () => context.push('/features/add-item-menu'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Tools Section
            Text(
              l10n.s39_tools,
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
                _buildToolCard(
                  colors: colors,
                  icon: OwnKeepMainIcons
                      .ai_assistant, // mapped to ai_powered perhaps
                  iconColor: colors.aiPurple,
                  title: l10n.s39_ai,
                  subtitle: l10n.s39_ai_body,
                  onTap: () => context.push('/features/ai-organize'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildToolCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.duplicate, // duplicate_files
                  iconColor: colors.warningOrange,
                  title: l10n.s39_duplicate,
                  subtitle: l10n.s39_duplicate_body,
                  onTap: () => context.push('/features/duplicate-finder'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildToolCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.export, // share_export
                  iconColor: const Color(0xFF27C5E8),
                  title: l10n.s39_export,
                  subtitle: l10n.s39_export_body,
                  onTap: () => context.push('/features/import-export'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildToolCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.lock, // secure_lock
                  iconColor: colors.primaryBlue,
                  title: l10n.s39_lock,
                  subtitle: l10n.s39_lock_body,
                  onTap: () => context.go('/lock'),
                ),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Shortcuts Section
            Text(
              l10n.s39_shortcuts,
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
                _buildShortcutCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.identity, // passport
                  iconColor: colors.aiPurple,
                  title: l10n.s39_passport,
                  subtitle: l10n.s39_passport_path,
                  onTap: () => context.push('/features/advanced-search'),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                _buildShortcutCard(
                  colors: colors,
                  icon: OwnKeepMainIcons.file_pdf, // insurance_document
                  iconColor: const Color(0xFF27C5E8),
                  title: l10n.s39_insurance,
                  subtitle: l10n.s39_insurance_path,
                  onTap: () => context.push('/features/advanced-search'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
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

  Widget _buildShortcutCard({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
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
                shape: BoxShape.circle,
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
                    subtitle,
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
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

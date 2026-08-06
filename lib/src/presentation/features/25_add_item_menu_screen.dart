import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class AddItemMenuScreen extends ConsumerWidget {
  const AddItemMenuScreen({super.key});

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
          icon: SvgPicture.asset(OwnKeepMainIcons.close, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s25_title,
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
            // Create New Section
            _buildSectionTitle(l10n.s25_create_new, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            Row(
              children: [
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.scan, l10n.s25_scan, colors.primaryBlue, () async {
                  final c = ref.read(ingestionControllerProvider);
                  if (c != null && context.mounted) { context.pop(); await c.captureImage(); }
                })),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.camera, l10n.s25_photo, colors.successGreen, () async {
                  final c = ref.read(ingestionControllerProvider);
                  if (c != null && context.mounted) { context.pop(); await c.captureImage(); }
                })),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Row(
              children: [
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.file_add, l10n.s25_add_files, colors.warningOrange, () async {
                  final c = ref.read(ingestionControllerProvider);
                  if (c != null && context.mounted) { context.pop(); await c.importFile(); }
                })),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.microphone, l10n.s25_voice, colors.aiPurple, null)),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Row(
              children: [
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.note, l10n.s25_note, const Color(0xFF27C5E8), null)),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: _buildGridItem(context, colors, OwnKeepMainIcons.contact, l10n.s25_contact, const Color(0xFFE54B86), null)),
              ],
            ),
            
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Import From Section
            _buildSectionTitle(l10n.s25_import_from, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildListTile(context, colors, OwnKeepMainIcons.gallery, l10n.s25_gallery, null, () async {
              final c = ref.read(ingestionControllerProvider);
              if (c != null && context.mounted) { context.pop(); await c.importGalleryImage(); }
            }),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildListTile(context, colors, OwnKeepMainIcons.files, l10n.s25_files, null, () async {
              final c = ref.read(ingestionControllerProvider);
              if (c != null && context.mounted) { context.pop(); await c.importFile(); }
            }),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildListTile(context, colors, OwnKeepMainIcons.cloud, l10n.s25_cloud, l10n.s25_cloud_note, null),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Create New Folder Section
            _buildSectionTitle(l10n.s25_create_folder, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildListTile(context, colors, OwnKeepMainIcons.folder, l10n.s25_new_folder, null, null, iconColor: colors.favoriteYellow),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Tip Box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceSelected.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(OwnKeepMainIcons.lightbulb, colorFilter: ColorFilter.mode(colors.favoriteYellow, BlendMode.srcIn), width: 24, height: 24),
                  const SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.s25_tip,
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
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, OwnKeepMainColorsTheme colors) {
    return Text(
      title,
      style: TextStyle(
        color: colors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, OwnKeepMainColorsTheme colors, String icon, String label, Color iconColor, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
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
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, OwnKeepMainColorsTheme colors, String iconPath, String title, String? subtitle, VoidCallback? onTap, {Color? iconColor}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(iconColor ?? colors.textSecondary, BlendMode.srcIn), width: 24, height: 24),
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
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ]
                ],
              ),
            ),
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn), width: 20),
          ],
        ),
      ),
    );
  }
}

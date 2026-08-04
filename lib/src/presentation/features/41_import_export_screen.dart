import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Import & Export',
      showBottomNav: true,
      body: ListView(
        children: [
          // Import Into OwnKeep
          const OwnKeepSectionHeader(title: 'Import Into OwnKeep'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                _ImportExportTile(
                  icon: Icons.folder_outlined,
                  iconColor: OwnKeepColors.primary,
                  title: 'Import from Files',
                  subtitle: 'From your device storage',
                  isFirst: true,
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.photo_library_outlined,
                  iconColor: OwnKeepColors.success,
                  title: 'Import from Gallery',
                  subtitle: 'Photos and videos',
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.cloud_outlined,
                  iconColor: OwnKeepColors.ai,
                  title: 'Import from Cloud',
                  subtitle: 'Google Drive, Dropbox (Download first)',
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.computer_outlined,
                  iconColor: OwnKeepColors.primary,
                  title: 'Import from Computer',
                  subtitle: 'Via USB or local network',
                  isLast: true,
                ),
              ],
            ),
          ),

          // Export From OwnKeep
          const OwnKeepSectionHeader(title: 'Export From OwnKeep'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                _ImportExportTile(
                  icon: Icons.save_outlined,
                  iconColor: OwnKeepColors.primary,
                  title: 'Export Vault Backup',
                  subtitle: 'Create .cvault backup file',
                  isFirst: true,
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.picture_as_pdf_outlined,
                  iconColor: OwnKeepColors.danger,
                  title: 'Export Documents',
                  subtitle: 'As PDF or original files',
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.perm_media_outlined,
                  iconColor: OwnKeepColors.ai,
                  title: 'Export Photos & Videos',
                  subtitle: 'As original files',
                ),
                _Divider(),
                _ImportExportTile(
                  icon: Icons.summarize_outlined,
                  iconColor: OwnKeepColors.success,
                  title: 'Export Report',
                  subtitle: 'Inventory and summary report',
                  isLast: true,
                ),
              ],
            ),
          ),

          const OwnKeepTipCard(text: 'Tip: Keep regular backups of your vault in multiple locations.'),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.25), indent: 64, endIndent: 0);
  }
}

class _ImportExportTile extends StatelessWidget {
  const _ImportExportTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isFirst = false,
    this.isLast = false,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$title simulated successfully!'),
          duration: const Duration(seconds: 2),
        ));
      },
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
        bottom: isLast ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
        child: Row(
          children: [
            OwnKeepIconBadge(icon: icon, color: iconColor),
            SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

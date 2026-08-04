import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AboutOwnKeepScreen extends StatelessWidget {
  const AboutOwnKeepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'About OwnKeep',
      showBottomNav: true,
      body: ListView(
        children: [
          SizedBox(height: OwnKeepSpacing.xl),
          // App logo + name
          Center(
            child: Column(
              children: [
                Container(
                  width: 88, height: 88,
                  decoration: BoxDecoration(
                    color: OwnKeepColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.lock_rounded, color: OwnKeepColors.primary, size: 48),
                ),
                SizedBox(height: OwnKeepSpacing.md),
                Text('OwnKeep', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                SizedBox(height: 4),
                Text('Keep What Matters. Own Your Data.', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.md),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.darkSurfaceElevated,
                    borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
                    border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.4)),
                  ),
                  child: Text('Version 1.3.0', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Info list
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                _AboutTile(icon: Icons.new_releases_outlined, iconColor: OwnKeepColors.ai, title: "What's New", subtitle: "See what's new in this version", isFirst: true),
                _AboutDivider(),
                _AboutTile(icon: Icons.security_outlined, iconColor: OwnKeepColors.primary, title: 'Privacy First', subtitle: '100% offline. Your data stays on your device.'),
                _AboutDivider(),
                _AboutTile(icon: Icons.gavel_outlined, iconColor: OwnKeepColors.success, title: 'Legal', subtitle: 'Terms of Use, Privacy Policy and Licenses'),
                _AboutDivider(),
                _AboutTile(icon: Icons.volunteer_activism_outlined, iconColor: OwnKeepColors.ai, title: 'Acknowledgements', subtitle: 'Open source libraries and credits'),
                _AboutDivider(),
                _AboutTile(
                  icon: Icons.language_outlined, iconColor: OwnKeepColors.success,
                  title: 'Website',
                  subtitle: 'www.ownkeep.app',
                  subtitleColor: OwnKeepColors.primary,
                ),
                _AboutDivider(),
                _AboutTile(
                  icon: Icons.mail_outline_rounded, iconColor: OwnKeepColors.primary,
                  title: 'Contact',
                  subtitle: 'support@ownkeep.app',
                  subtitleColor: OwnKeepColors.primary,
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          const Center(
            child: Text('© 2025 OwnKeep\nAll rights reserved.', textAlign: TextAlign.center,
                style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter', height: 1.6)),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _AboutDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.25), indent: 60, endIndent: 0);
}

class _AboutTile extends StatelessWidget {
  const _AboutTile({
    required this.icon, required this.iconColor, required this.title, required this.subtitle,
    this.subtitleColor, this.isFirst = false, this.isLast = false,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
        bottom: isLast ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
        child: Row(
          children: [
            OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
            SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: subtitleColor ?? OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class TutorialsScreen extends StatelessWidget {
  const TutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Tutorials',
      showBottomNav: true,
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: 12),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: OwnKeepColors.darkTextMuted, size: 18),
                  SizedBox(width: 8),
                  Text('Search tutorials...', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 14, fontFamily: 'Inter')),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Getting Started
                OwnKeepSectionHeader(title: 'Getting Started', actionText: 'See All', onAction: () {}),
                _TutorialTile(number: '01', title: 'Welcome to OwnKeep', subtitle: 'Overview and key features', duration: '2:45', gradientStart: OwnKeepColors.primary),
                _TutorialTile(number: '02', title: 'Create Your First Vault', subtitle: 'Secure your data in minutes', duration: '4:12', gradientStart: OwnKeepColors.success),
                _TutorialTile(number: '03', title: 'Add Documents & Photos', subtitle: 'Import and organize your files', duration: '3:38', gradientStart: OwnKeepColors.warning),
                _TutorialTile(number: '04', title: 'Set Reminders', subtitle: 'Never miss important things', duration: '3:05', gradientStart: OwnKeepColors.pink),

                // Manage Your Vault
                OwnKeepSectionHeader(title: 'Manage Your Vault', actionText: 'See All', onAction: () {}),
                _TutorialTile(number: '05', title: 'Tags and Collections', subtitle: 'Organize with ease', duration: '2:50', gradientStart: OwnKeepColors.ai),
                _TutorialTile(number: '06', title: 'Backup Your Vault', subtitle: 'Keep your data safe', duration: '3:20', gradientStart: OwnKeepColors.primary),
                _TutorialTile(number: '07', title: 'Export and Share', subtitle: 'Share securely', duration: '2:35', gradientStart: OwnKeepColors.success),

                // Advanced
                OwnKeepSectionHeader(title: 'Advanced', actionText: 'See All', onAction: () {}),
                _TutorialTile(number: '08', title: 'Security Features', subtitle: 'All about encryption & more', duration: '4:18', gradientStart: OwnKeepColors.danger),
                SizedBox(height: OwnKeepSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TutorialTile extends StatelessWidget {
  const _TutorialTile({required this.number, required this.title, required this.subtitle, required this.duration, required this.gradientStart});
  final String number;
  final String title;
  final String subtitle;
  final String duration;
  final Color gradientStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(OwnKeepRadius.md)),
            child: Container(
              width: 72, height: 68,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientStart.withValues(alpha: 0.8), gradientStart.withValues(alpha: 0.3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), shape: BoxShape.circle),
                  child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                ),
              ),
            ),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$number. $title', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 3),
                Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: OwnKeepSpacing.md),
            child: Text(duration, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}

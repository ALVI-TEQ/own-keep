import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class VersionHistoryScreen extends StatelessWidget {
  const VersionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Version History', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Passport.pdf', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current version banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Current version', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                  SizedBox(height: 4),
                  Text('Version 4', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                ]),
                Text('Today, 10:31 AM', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontFamily: 'Inter')),
              ]),
            ),

            SizedBox(height: OwnKeepSpacing.xl),
            Text('Previous Versions', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.md),

            // Version list
            _VersionCard(version: 'Version 3', subtitle: 'Metadata updated', time: 'Today, 10:30 AM', color: OwnKeepColors.ai),
            SizedBox(height: OwnKeepSpacing.sm),
            _VersionCard(version: 'Version 2', subtitle: 'Tags changed', time: '9 May 2025, 4:20 PM', color: OwnKeepColors.primary),
            SizedBox(height: OwnKeepSpacing.sm),
            _VersionCard(version: 'Version 1', subtitle: 'Original document added', time: '8 May 2025, 2:15 PM', color: OwnKeepColors.success),

            const Spacer(),

            // Version storage
            Container(
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Version storage', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                SizedBox(height: 4),
                Text('3 previous versions  •  4.8 MB', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.md),
            Text('How it works', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: 6),
            Text(
              'OwnKeep stores local encrypted snapshots when you edit metadata or replace a file. Versions never leave your device and can be removed at any time.',
              style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter', height: 1.5),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: OwnKeepColors.danger,
                  side: const BorderSide(color: OwnKeepColors.danger),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                ),
                child: Text('Delete Old Versions', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionCard extends StatelessWidget {
  const _VersionCard({required this.version, required this.subtitle, required this.time, required this.color});
  final String version;
  final String subtitle;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(Icons.refresh_rounded, color: color, size: 18),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(version, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              Text(time, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
            ]),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: OwnKeepColors.primary,
              side: BorderSide(color: OwnKeepColors.primary.withValues(alpha: 0.5)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: Text('Restore', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}

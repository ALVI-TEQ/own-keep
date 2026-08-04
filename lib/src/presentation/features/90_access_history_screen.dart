import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const logItems = [
      (OwnKeepColors.pink, 'H', 'Opened Health Report', 'Harika', 'Today  •  10:32 AM', 'Allowed', OwnKeepColors.success),
      (OwnKeepColors.primary, 'A', 'Exported Family Documents', 'Arjun', 'Today  •  9:20 AM', 'Allowed', OwnKeepColors.success),
      (Color(0xFF7C3AED), 'S', 'Tried to open Property Papers', 'Alekhya', 'Yesterday  •  7:45 PM', 'Blocked', OwnKeepColors.danger),
      (OwnKeepColors.success, 'C', 'Viewed Education Certificate', 'Charvika', 'Yesterday  •  4:15 PM', 'Allowed', OwnKeepColors.success),
      (OwnKeepColors.pink, 'H', 'Added doctor reminder', 'Harika', '12 May  •  11:10 AM', 'Allowed', OwnKeepColors.success),
      (Color(0xFFF59E0B), 'R', 'Emergency package request', 'Ramesh', '10 May  •  8:45 AM', 'Pending', Color(0xFFF59E0B)),
    ];

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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Access History', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Family vault access log', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.crop_square_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 2),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Month summary
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('This month', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('86 family vault actions', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              ]),
              Text('No warnings', style: TextStyle(color: OwnKeepColors.success, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Log items
          ...logItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: item.$1, shape: BoxShape.circle),
                child: Center(child: Text(item.$2, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(item.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                Text(item.$5, style: TextStyle(color: OwnKeepColors.primary, fontSize: 11, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: item.$7,
                  side: BorderSide(color: item.$7),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(item.$6, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: item.$7, fontFamily: 'Inter')),
              ),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Export report footer
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: const [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Export access report', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text('Create a local encrypted audit file', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class ActivityFeedScreen extends StatelessWidget {
  const ActivityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const activities = [
      (OwnKeepColors.pink, 'H', 'Harika added Health Report', 'Health Records', 'Today, 10:30 AM'),
      (OwnKeepColors.primary, 'A', 'Arjun updated Insurance Policy', 'Family Documents', 'Today, 9:15 AM'),
      (Color(0xFF7C3AED), 'S', 'Alekhya viewed Education Certificate', 'Education', 'Yesterday, 7:40 PM'),
      (OwnKeepColors.success, 'H', 'Harika added a reminder', 'Health Records', 'Yesterday, 4:20 PM'),
      (Color(0xFFF59E0B), 'C', 'Charvika opened School ID', 'Education', '12 May, 11:10 AM'),
      (OwnKeepColors.primary, 'A', 'Arjun created Emergency Pack', 'Emergency Pack', '10 May, 8:45 AM'),
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
          Text('Shared Activity', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Local family vault actions', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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
        child: Column(children: [
          ...activities.asMap().entries.map((e) {
            final a = e.value;
            final i = e.key;
            return IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Date + avatar column
                SizedBox(
                  width: 100,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.only(top: 14, right: 10),
                      child: Text(a.$5.split(',').last.trim(), style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                    ),
                  ]),
                ),
                // Dot + line
                Column(children: [
                  Container(width: 14, height: 14, margin: EdgeInsets.only(top: 14), decoration: BoxDecoration(color: a.$1, shape: BoxShape.circle)),
                  if (i < activities.length - 1)
                    Expanded(child: Container(width: 1.5, color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
                ]),
                SizedBox(width: 10),
                // Card
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm, top: 6),
                    padding: EdgeInsets.all(OwnKeepSpacing.md),
                    decoration: BoxDecoration(
                      color: OwnKeepColors.darkSurfaceElevated,
                      borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                      border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                    ),
                    child: Row(children: [
                      Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(color: a.$1, shape: BoxShape.circle),
                        child: Center(child: Text(a.$2, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                      ),
                      SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(a.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                        Text(a.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                      ])),
                    ]),
                  ),
                ),
              ]),
            );
          }),
          SizedBox(height: OwnKeepSpacing.sm),
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Activity log location', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('Stored only in this family vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

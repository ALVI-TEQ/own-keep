import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AutoTaggingScreen extends StatelessWidget {
  const AutoTaggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const files = [
      ('PDF', OwnKeepColors.danger, 'Passport.pdf', ['#identity', '#passport', '#important']),
      ('PDF', OwnKeepColors.primary, 'Insurance Policy.pdf', ['#insurance', '#health', '#expiry']),
      ('PDF', OwnKeepColors.success, 'Salary Slip - July.pdf', ['#finance', '#salary', '#2025']),
      ('IMG', Color(0xFFF59E0B), 'Driving Licence.jpg', ['#identity', '#vehicle', '#expiry']),
      ('PDF', Color(0xFF7C3AED), 'Sale Deed.pdf', ['#property', '#legal', '#important']),
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
          Text('Auto Tagging', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Review AI tag suggestions', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.4)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('8 files ready for tagging', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                Text('Tags are suggested using on-device text analysis', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: OwnKeepColors.ai,
                  side: const BorderSide(color: OwnKeepColors.ai),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
                ),
                child: Text('Apply All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          ...files.map((f) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: f.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(f.$1, style: TextStyle(color: f.$2, fontSize: 11, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Text(f.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter'))),
              ]),
              SizedBox(height: OwnKeepSpacing.sm),
              Wrap(
                spacing: 6, runSpacing: 6,
                children: f.$4.map((tag) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.5)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(tag, style: TextStyle(color: OwnKeepColors.ai, fontSize: 11, fontFamily: 'Inter')),
                )).toList(),
              ),
              SizedBox(height: OwnKeepSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OwnKeepColors.primary,
                    side: const BorderSide(color: OwnKeepColors.primary),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Review Tags', style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                ),
              ),
            ]),
          )),
        ]),
      ),
    );
  }
}

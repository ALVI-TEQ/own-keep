import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SimilarDocumentsScreen extends StatelessWidget {
  const SimilarDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const groups = [
      (Icons.crop_square_rounded, OwnKeepColors.primary, 'Vehicle Insurance Policies', '3 files  •  88–96% similar'),
      (Icons.currency_rupee_rounded, OwnKeepColors.success, 'Salary Slips - 2025', '6 files  •  Same layout'),
      (Icons.favorite_rounded, OwnKeepColors.pink, 'Health Reports', '4 files  •  Same hospital'),
      (Icons.home_rounded, Color(0xFFF59E0B), 'Property Tax Receipts', '3 files  •  Same property'),
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
          Text('Similar Documents', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Group related files', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert_rounded, color: OwnKeepColors.darkTextSecondary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(children: [
          // Header stat
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('4 similarity groups found', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                Text('AI compares text and file structure locally', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ]),
              Text('92%', style: TextStyle(color: OwnKeepColors.ai, fontSize: 20, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          ...groups.map((g) => Container(
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
                  decoration: BoxDecoration(color: g.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                  child: Icon(g.$1, color: g.$2, size: 20),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(g.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text(g.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ])),
              ]),
              SizedBox(height: OwnKeepSpacing.sm),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OwnKeepColors.primary,
                    side: const BorderSide(color: OwnKeepColors.primary),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Preview Group', style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OwnKeepColors.ai,
                    side: const BorderSide(color: OwnKeepColors.ai),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Organize', style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                ),
              ]),
            ]),
          )),
        ]),
      ),
    );
  }
}

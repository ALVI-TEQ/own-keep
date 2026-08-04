import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SharedWithMeScreen extends StatelessWidget {
  const SharedWithMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const collections = [
      (Icons.crop_square_rounded, OwnKeepColors.primary, 'Family Documents', '28 items  •  All members', '4 members', OwnKeepColors.primary),
      (Icons.favorite_rounded, OwnKeepColors.pink, 'Health Records', '16 items  •  Parents only', '2 members', OwnKeepColors.pink),
      (Icons.home_rounded, Color(0xFFF59E0B), 'Property Papers', '9 items  •  Adults only', '2 members', Color(0xFFF59E0B)),
      (Icons.diamond_rounded, Color(0xFF7C3AED), 'Education', '12 items  •  Children and parents', '4 members', Color(0xFF7C3AED)),
      (Icons.warning_amber_rounded, OwnKeepColors.danger, 'Emergency Pack', '6 items  •  Trusted contacts', '2 contacts', OwnKeepColors.danger),
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
          Text('Shared Collections', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Available to family members', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.add_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...collections.map((c) => Container(
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
                  width: 56, height: 56,
                  decoration: BoxDecoration(color: c.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                  child: Icon(c.$1, color: c.$2, size: 26),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text(c.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ])),
                Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
              ]),
              SizedBox(height: OwnKeepSpacing.sm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(border: Border.all(color: c.$6), borderRadius: BorderRadius.circular(20)),
                child: Text(c.$5, style: TextStyle(color: c.$6, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Sharing method footer
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Sharing method', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('Encrypted package or nearby transfer', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ]),
              Text('Change', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Create Shared Collection', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

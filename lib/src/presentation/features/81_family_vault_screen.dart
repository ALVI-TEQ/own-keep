import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class FamilyVaultScreen extends StatelessWidget {
  const FamilyVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const members = [
      ('A', OwnKeepColors.primary),
      ('H', OwnKeepColors.pink),
      ('S', Color(0xFF7C3AED)),
      ('C', OwnKeepColors.success),
    ];

    const collections = [
      (Icons.crop_square_rounded, OwnKeepColors.primary, 'Family Documents', '28 items', 'All Members', OwnKeepColors.primary),
      (Icons.favorite_rounded, OwnKeepColors.pink, 'Health Records', '16 items', 'Parents', OwnKeepColors.pink),
      (Icons.home_rounded, Color(0xFFF59E0B), 'Property Papers', '9 items', 'Adults', Color(0xFFF59E0B)),
      (Icons.diamond_rounded, Color(0xFF7C3AED), 'Education', '12 items', 'Children', Color(0xFF7C3AED)),
      (Icons.warning_amber_rounded, OwnKeepColors.danger, 'Emergency Pack', '6 items', 'Trusted', OwnKeepColors.danger),
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
          Text('Family Vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Private sharing without cloud accounts', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.add_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Family hero card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.4)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Our Family', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              Text('4 members  •  6 shared collections', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
              SizedBox(height: OwnKeepSpacing.md),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Avatar stack
                SizedBox(
                  height: 44,
                  child: Stack(children: members.asMap().entries.map((e) => Positioned(
                    left: e.key * 30.0,
                    child: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: e.value.$2,
                        shape: BoxShape.circle,
                        border: Border.all(color: OwnKeepColors.darkBackground, width: 2),
                      ),
                      child: Center(child: Text(e.value.$1, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                    ),
                  )).toList()),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OwnKeepColors.ai,
                    side: const BorderSide(color: OwnKeepColors.ai),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
                  ),
                  child: Text('Manage Members', style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                ),
              ]),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('Shared Collections', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            Text('View all', style: TextStyle(color: OwnKeepColors.primary, fontSize: 12, fontFamily: 'Inter')),
          ]),
          SizedBox(height: OwnKeepSpacing.sm),
          ...collections.map((c) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: c.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                child: Icon(c.$1, color: c.$2, size: 20),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(c.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(c.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: c.$6,
                  side: BorderSide(color: c.$6),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(c.$5, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.$6, fontFamily: 'Inter')),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Offline sharing row
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: const [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Offline sharing', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text('Use QR, nearby transfer, or encrypted package', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
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
            child: Text('Add Family Member', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

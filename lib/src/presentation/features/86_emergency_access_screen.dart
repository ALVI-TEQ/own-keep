import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class EmergencyAccessScreen extends StatelessWidget {
  const EmergencyAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const includedItems = [
      (Icons.credit_card_rounded, OwnKeepColors.primary, Color(0xFF1A3D7A), 'Identity Card', 'View only'),
      (Icons.favorite_rounded, OwnKeepColors.pink, Color(0xFF7A1A2E), 'Health Summary', 'View only'),
      (Icons.crop_square_rounded, OwnKeepColors.success, Color(0xFF0A4A2E), 'Insurance Details', 'View only'),
      (Icons.circle_rounded, Color(0xFFF59E0B), Color(0xFF7A3D0A), 'Emergency Contacts', 'View only'),
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
          Text('Emergency Access', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Prepare a limited recovery package', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.danger.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.error_outline_rounded, color: OwnKeepColors.danger, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Hero circle
                Center(
                  child: Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: OwnKeepColors.danger, width: 2),
                      color: OwnKeepColors.danger.withValues(alpha: 0.1),
                    ),
                    child: Icon(Icons.warning_amber_rounded, color: OwnKeepColors.danger, size: 64),
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                const Center(child: Text('Emergency Pack', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                const Center(child: Text('6 selected items', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter'))),
                SizedBox(height: OwnKeepSpacing.xl),
                Text('Included Items', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.sm),
                ...includedItems.map((item) => Container(
                  margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                  padding: EdgeInsets.all(OwnKeepSpacing.md),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.darkSurfaceElevated,
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                    border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                  ),
                  child: Row(children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: item.$3, borderRadius: BorderRadius.circular(9)),
                      child: Icon(item.$1, color: Colors.white.withValues(alpha: 0.85), size: 18),
                    ),
                    SizedBox(width: OwnKeepSpacing.md),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      Text(item.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    ])),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: item.$2,
                        side: BorderSide(color: item.$2),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(item.$5, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: item.$2, fontFamily: 'Inter')),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                  ]),
                )),
                SizedBox(height: OwnKeepSpacing.sm),
                // Warning box
                Container(
                  padding: EdgeInsets.all(OwnKeepSpacing.md),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.danger.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                    border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    Text('Emergency access is limited', style: TextStyle(color: OwnKeepColors.danger, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    SizedBox(height: 4),
                    Text('It never unlocks the full vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ]),
                ),
              ]),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.danger,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Create Emergency Package', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

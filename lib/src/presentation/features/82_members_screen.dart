import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const members = [
      ('A', OwnKeepColors.primary, 'Arjun Sharma', 'Owner  •  This device', 'Owner', OwnKeepColors.primary),
      ('H', OwnKeepColors.pink, 'Harika', 'Adult  •  Full access', 'Active', OwnKeepColors.danger),
      ('S', Color(0xFF7C3AED), 'Alekhya', 'Child  •  Limited access', 'Active', Color(0xFF7C3AED)),
      ('C', OwnKeepColors.success, 'Charvika', 'Child  •  Limited access', 'Active', OwnKeepColors.success),
    ];

    const transferOptions = [
      (OwnKeepColors.ai, Color(0xFF0A3D3D), Icons.compare_arrows_rounded, 'Nearby Transfer', 'Share encrypted access on local network'),
      (Color(0xFF7C3AED), Color(0xFF3D1A7A), Icons.grid_view_rounded, 'QR Invitation', 'Scan on another device'),
      (OwnKeepColors.success, Color(0xFF0A4A2E), Icons.download_rounded, 'Encrypted Package', 'Export an offline invitation file'),
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
          Text('Family Members', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('4 members', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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
          // Member list
          ...members.map((m) => Container(
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
                decoration: BoxDecoration(color: m.$2, shape: BoxShape.circle),
                child: Center(child: Text(m.$1, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(m.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: m.$6,
                  side: BorderSide(color: m.$6),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(m.$5, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: m.$6, fontFamily: 'Inter')),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Access Summary', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          Row(children: const [
            _SumChip(value: '4', label: 'Members', color: OwnKeepColors.primary),
            SizedBox(width: 8),
            _SumChip(value: '6', label: 'Collections', color: Color(0xFF7C3AED)),
            SizedBox(width: 8),
            _SumChip(value: '2', label: 'Trusted', color: OwnKeepColors.success),
            SizedBox(width: 8),
            _SumChip(value: '1', label: 'Pending', color: Color(0xFFF59E0B)),
          ]),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Transfer Options', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...transferOptions.map((t) => Container(
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
                decoration: BoxDecoration(color: t.$2, borderRadius: BorderRadius.circular(9)),
                child: Icon(t.$3, color: Colors.white.withValues(alpha: 0.85), size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(t.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _SumChip extends StatelessWidget {
  const _SumChip({required this.value, required this.label, required this.color});
  final String value, label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: 2),
          Text(label, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 10, fontFamily: 'Inter')),
        ]),
      ),
    );
  }
}

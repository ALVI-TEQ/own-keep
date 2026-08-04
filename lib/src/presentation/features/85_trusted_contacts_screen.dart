import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class TrustedContactsScreen extends StatelessWidget {
  const TrustedContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const rules = [
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), '2', 'Minimum approvals', '2 of 2 trusted contacts'),
      (Color(0xFF7A3D0A), Color(0xFFF59E0B), Icons.crop_square_rounded, 'Waiting period', '48 hours before access'),
      (Color(0xFF1A3D7A), OwnKeepColors.primary, Icons.crop_square_rounded, 'Access scope', 'Emergency Pack only'),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Package lifetime', 'Valid for 24 hours'),
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
          Text('Trusted Contacts', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Emergency recovery helpers', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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
          // Info banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.4)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('What trusted contacts can do', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text(
                'They cannot see your vault. They can only help unlock an emergency package when your rules are satisfied.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter', height: 1.5),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Contact cards
          _ContactCard(initial: 'H', color: OwnKeepColors.pink, name: 'Harika', role: 'Primary trusted contact'),
          SizedBox(height: OwnKeepSpacing.sm),
          _ContactCard(initial: 'R', color: OwnKeepColors.primary, name: 'Ramesh', role: 'Backup contact'),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Emergency Rules', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          // Rule items
          ...rules.map((r) => Container(
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
                decoration: BoxDecoration(color: r.$1, borderRadius: BorderRadius.circular(9)),
                child: Center(child: r.$3 is String
                    ? Text(r.$3 as String, style: TextStyle(color: r.$2, fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'Inter'))
                    : Icon(r.$3 as IconData, color: r.$2, size: 18)),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(r.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Add Trusted Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.initial, required this.color, required this.name, required this.role});
  final String initial, name, role;
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
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Text(initial, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
        ),
        SizedBox(width: OwnKeepSpacing.md),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text(role, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ])),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: OwnKeepColors.success,
            side: const BorderSide(color: OwnKeepColors.success),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text('Verified', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: OwnKeepColors.success, fontFamily: 'Inter')),
        ),
        SizedBox(width: 6),
        Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DeviceMigrationScreen extends StatefulWidget {
  const DeviceMigrationScreen({super.key});
  @override
  State<DeviceMigrationScreen> createState() => _DeviceMigrationScreenState();
}

class _DeviceMigrationScreenState extends State<DeviceMigrationScreen> {
  final _checklist = [true, true, true, false];
  final _checkLabels = [
    'Create fresh backup',
    'Keep both devices charged',
    'Verify available storage',
    'Do not delete old vault yet',
  ];

  @override
  Widget build(BuildContext context) {
    const methods = [
      (Color(0xFF0A4A2E), OwnKeepColors.ai, Icons.compare_arrows_rounded, 'Nearby Transfer', 'Fast local transfer on the same network'),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.download_rounded, 'Encrypted Migration File', 'Move using USB, Files or SD card'),
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), Icons.grid_view_rounded, 'QR Pairing', 'Pair devices before local transfer'),
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
          Text('Device Migration', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Move your vault to another device', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.compare_arrows_rounded, color: OwnKeepColors.ai, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Hero banner
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Secure Device-to-Device Transfer', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                SizedBox(height: 6),
                Text(
                  'Transfer through local network or an encrypted migration package. No cloud account is required.',
                  style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, height: 1.5, fontFamily: 'Inter'),
                ),
              ])),
              SizedBox(width: OwnKeepSpacing.md),
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: OwnKeepColors.ai, width: 2)),
                child: Icon(Icons.compare_arrows_rounded, color: OwnKeepColors.ai, size: 24),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Choose Method', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...methods.map((m) => Container(
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
                decoration: BoxDecoration(color: m.$1, borderRadius: BorderRadius.circular(9)),
                child: Icon(m.$3, color: m.$2, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(m.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Migration Checklist', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ..._checklist.asMap().entries.map((e) {
            final done = e.value;
            return Container(
              margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done ? OwnKeepColors.success : Colors.transparent,
                    border: Border.all(color: done ? OwnKeepColors.success : OwnKeepColors.darkTextMuted, width: 2),
                  ),
                  child: done ? Icon(Icons.check_rounded, color: Colors.white, size: 14) : null,
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Text(
                  _checkLabels[e.key],
                  style: TextStyle(
                    color: done ? OwnKeepColors.darkTextPrimary : OwnKeepColors.darkTextSecondary,
                    fontSize: 14,
                    fontWeight: done ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ]),
            );
          }),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Start Device Migration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

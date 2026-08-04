import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RestoreVaultScreen extends StatefulWidget {
  const RestoreVaultScreen({super.key});
  @override
  State<RestoreVaultScreen> createState() => _RestoreVaultScreenState();
}

class _RestoreVaultScreenState extends State<RestoreVaultScreen> {
  int _selected = 0; // 0=everything, 1=docs only, 2=collections

  final _options = [
    ('Restore everything', 'Documents, notes, reminders and settings'),
    ('Documents only', 'Skip app preferences and activity history'),
    ('Choose collections', 'Restore selected categories'),
  ];

  @override
  Widget build(BuildContext context) {
    const verifications = [
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Container integrity', 'Verified'),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Recovery envelope', 'Valid'),
      (Color(0xFF1A3D7A), OwnKeepColors.primary, Icons.crop_square_rounded, 'Available storage', '7.8 GB free'),
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), 'V', 'Backup version', 'Compatible'),
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
          Text('Restore Vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Recover from an encrypted backup', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Backup File', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.primary, width: 1.5),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('CV', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OwnKeep_Backup_2026-08-03.cvault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text('2.4 GB  •  Verified container', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Text('Change', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Restore Options', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ..._options.asMap().entries.map((e) {
            final isSelected = _selected == e.key;
            return GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(
                    color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkTextMuted, width: 2),
                      color: isSelected ? OwnKeepColors.primary : Colors.transparent,
                    ),
                    child: isSelected ? Icon(Icons.circle, color: Colors.white, size: 8) : null,
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.value.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, fontFamily: 'Inter')),
                    Text(e.value.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                ]),
              ),
            );
          }),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Verification', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...verifications.map((v) => Container(
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
                decoration: BoxDecoration(color: v.$1, borderRadius: BorderRadius.circular(9)),
                child: Center(child: v.$3 is IconData
                    ? Icon(v.$3 as IconData, color: v.$2, size: 18)
                    : Text(v.$3 as String, style: TextStyle(color: v.$2, fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(v.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Restore Vault', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SecurityAuditScreen extends StatelessWidget {
  const SecurityAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const auditItems = [
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Vault encryption', 'Strong and verified', 'Pass', OwnKeepColors.success),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Recovery phrase', 'Verified 12-word phrase', 'Pass', OwnKeepColors.success),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.fingerprint_rounded, 'Biometric lock', 'Enabled', 'Pass', OwnKeepColors.success),
      (Color(0xFF7A3D0A), Color(0xFFF59E0B), Icons.download_rounded, 'Encrypted backup', 'Created 14 days ago', 'Review', Color(0xFFF59E0B)),
      (Color(0xFF1A3D7A), OwnKeepColors.primary, Icons.circle_rounded, 'Hidden vault', 'Not configured', 'Optional', OwnKeepColors.primary),
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), Icons.error_outline_rounded, 'Decoy vault', 'Not configured', 'Optional', Color(0xFF7C3AED)),
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
          Text('Security Audit', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Final vault safety review', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Score circle
          Center(
            child: Container(
              width: 160, height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0A2E1A),
                border: Border.all(color: OwnKeepColors.success, width: 2),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Text('98', style: TextStyle(color: OwnKeepColors.success, fontSize: 52, fontWeight: FontWeight.w800, fontFamily: 'Inter', height: 1)),
                Text('Security Score', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ]),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          const Center(child: Text('Excellent protection', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
          const Center(child: Text('Last audited today at 9:35 AM', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter'))),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Audit Results', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...auditItems.map((a) => Container(
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
                decoration: BoxDecoration(color: a.$1, borderRadius: BorderRadius.circular(9)),
                child: Icon(a.$3, color: a.$2, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(a.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(a.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: a.$7,
                  side: BorderSide(color: a.$7),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(a.$6, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: a.$7, fontFamily: 'Inter')),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Recommended next step
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: const [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Recommended next step', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('Create a fresh encrypted backup', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          ),
        ]),
      ),
    );
  }
}

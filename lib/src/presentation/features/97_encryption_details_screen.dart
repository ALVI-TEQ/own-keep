import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class EncryptionDetailsScreen extends StatelessWidget {
  const EncryptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const details = [
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'Content encryption', 'AES-256-GCM'),
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), 'K', 'Key derivation', 'Argon2id'),
      (Color(0xFF1A3D7A), OwnKeepColors.primary, 'M', 'Manifest format', 'Canonical CBOR'),
      (Color(0xFF0A3D3D), OwnKeepColors.ai, '#', 'Integrity', 'SHA-256 digests'),
      (Color(0xFF7A3D0A), Color(0xFFF59E0B), Icons.crop_square_rounded, 'Container', 'Encrypted .cvault'),
      (Color(0xFF7A1A2E), OwnKeepColors.pink, 'R', 'Recovery envelope', 'Authenticated and local'),
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
          Text('Encryption Details', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('How OwnKeep protects your vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Hero
          Center(
            child: Container(
              width: 150, height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: OwnKeepColors.success, width: 2),
                color: const Color(0xFF0A2E1A),
              ),
              child: Icon(Icons.check_rounded, color: OwnKeepColors.success, size: 64),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          const Center(child: Text('Vault Fully Encrypted', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
          const Center(child: Text('All checks passed', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter'))),
          SizedBox(height: OwnKeepSpacing.xl),
          // Detail rows
          ...details.map((d) => Container(
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
                decoration: BoxDecoration(color: d.$1, borderRadius: BorderRadius.circular(9)),
                child: Center(child: d.$3 is IconData
                    ? Icon(d.$3 as IconData, color: d.$2, size: 18)
                    : Text(d.$3 as String, style: TextStyle(color: d.$2, fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(d.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Security model footer
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Security model', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Text('OwnKeep cannot read or recover your vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
            ]),
          ),
        ]),
      ),
    );
  }
}

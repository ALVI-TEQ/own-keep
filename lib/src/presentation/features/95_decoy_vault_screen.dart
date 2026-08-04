import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DecoyVaultScreen extends StatelessWidget {
  const DecoyVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      (Color(0xFF1A3D7A), OwnKeepColors.primary, '1', 'Choose decoy PIN', 'Must differ from your real PIN'),
      (Color(0xFF0A4A2E), OwnKeepColors.success, '2', 'Add harmless files', 'Select ordinary documents or photos'),
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), '3', 'Test decoy unlock', 'Verify the alternate vault opens'),
      (Color(0xFF7A3D0A), Color(0xFFF59E0B), '4', 'Enable silent mode', 'No warning appears during unlock'),
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
          Text('Decoy Vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Open a harmless vault with a separate PIN', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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
          // Safety feature banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFF3D1A0A),
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: Color(0xFFF59E0B).withValues(alpha: 0.5)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Safety Feature', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.8, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text('Create a believable alternate vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 17, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text(
                'A decoy PIN opens a separate vault containing only the items you choose. Your real vault stays hidden.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, height: 1.5, fontFamily: 'Inter'),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Decoy Setup', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Expanded(
            child: ListView(children: [
              ...steps.map((s) => Container(
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
                    decoration: BoxDecoration(color: s.$1, borderRadius: BorderRadius.circular(9)),
                    child: Center(child: Text(s.$3, style: TextStyle(color: s.$2, fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text(s.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                  Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                ]),
              )),
              // Important warning
              Container(
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: OwnKeepColors.danger.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Important', style: TextStyle(color: OwnKeepColors.danger, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  SizedBox(height: 4),
                  Text('Decoy mode does not replace physical safety precautions', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ]),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Create Decoy Vault', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

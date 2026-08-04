import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class OcrScanTextScreen extends StatelessWidget {
  const OcrScanTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Scan Text', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Extract text from document', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document preview card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(OwnKeepSpacing.base),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
                border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.3)),
              ),
              child: Container(
                padding: EdgeInsets.all(OwnKeepSpacing.lg),
                decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('INSURANCE POLICY', style: TextStyle(
                        color: const Color(0xFF1A2340),
                        fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 1,
                        fontFamily: 'Inter',
                      )),
                    ),
                    SizedBox(height: OwnKeepSpacing.md),
                    ...const [
                      'Policy Number: POL/AGI/2024/123456789',
                      'Policy Holder: Arjun Sharma',
                      'Policy Type: Health Insurance',
                      'Policy Period: 01 Apr 2024 – 31 Mar 2025',
                    ].map((line) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(line, style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 12, fontFamily: 'Inter')),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Extracted Text', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                child: const SelectableText(
                  'INSURANCE POLICY\n\nPolicy Number: POL/AGI/2024/123456789\nPolicy Holder: Arjun Sharma\nPolicy Type: Health Insurance\nPolicy Period: 01 Apr 2024 – 31 Mar 2025',
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontFamily: 'Inter', height: 1.7),
                ),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: OwnKeepColors.primary,
                      backgroundColor: OwnKeepColors.darkSurfaceElevated,
                      side: BorderSide(color: OwnKeepColors.darkSurfaceElevated),
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    ),
                    child: Text('Copy Text', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  ),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: OwnKeepColors.primary,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    ),
                    child: Text('Save as Note', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  ),
                ),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.sm),
            const Center(
              child: Text('Text processed only on this device', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
            ),
            SizedBox(height: OwnKeepSpacing.md),
          ],
        ),
      ),
    );
  }
}

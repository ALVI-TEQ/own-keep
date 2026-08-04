import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DocumentCompareScreen extends StatelessWidget {
  const DocumentCompareScreen({super.key});

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
            Text('Compare Documents', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Review differences', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Version A label
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Version A', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.all(OwnKeepSpacing.md),
                    decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Policy Number', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('POL/AGI/2024/123', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      SizedBox(height: 8),
                      Text('Policy Holder', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('Arjun Sharma', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      SizedBox(height: 8),
                      Text('Premium', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(border: Border.all(color: OwnKeepColors.danger), borderRadius: BorderRadius.circular(4)),
                        child: Text('₹12,500', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      ),
                      SizedBox(height: 8),
                      Text('Period', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('2024–2025', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                    ]),
                  ),
                ])),
                SizedBox(width: OwnKeepSpacing.md),
                // Version B
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Version B', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.all(OwnKeepSpacing.md),
                    decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Policy Number', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('POL/AGI/2024/123', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      SizedBox(height: 8),
                      Text('Policy Holder', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('Arjun Sharma', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      SizedBox(height: 8),
                      Text('Premium', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(border: Border.all(color: OwnKeepColors.success), borderRadius: BorderRadius.circular(4)),
                        child: Text('₹13,250', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                      ),
                      SizedBox(height: 8),
                      Text('Period', style: TextStyle(color: Color(0xFF1A2340), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('2025–2026', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 11, fontFamily: 'Inter')),
                    ]),
                  ),
                ])),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Changes Found', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            _ChangeRow(color: OwnKeepColors.warning, title: 'Premium', detail: '₹12,500 → ₹13,250'),
            SizedBox(height: OwnKeepSpacing.sm),
            _ChangeRow(color: OwnKeepColors.primary, title: 'Policy Period', detail: '2024–2025 → 2025–2026'),
            SizedBox(height: OwnKeepSpacing.sm),
            _ChangeRow(color: OwnKeepColors.success, title: 'No other changes', detail: 'Document structure matches'),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Export Comparison', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeRow extends StatelessWidget {
  const _ChangeRow({required this.color, required this.title, required this.detail});
  final Color color;
  final String title;
  final String detail;

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
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: OwnKeepSpacing.md),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text(detail, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ])),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class MergePdfScreen extends StatelessWidget {
  const MergePdfScreen({super.key});

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
            Text('Merge PDF', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Combine selected documents', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Arrange pages', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 16),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text('Drag items to reorder before merging', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                Icon(Icons.menu_rounded, color: OwnKeepColors.primary, size: 18),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.md),
            ...[
              ('Passport.pdf', '2 pages • 1.2 MB', 'Position 1'),
              ('Insurance Policy.pdf', '4 pages • 2.4 MB', 'Position 2'),
              ('Bank Statement.pdf', '6 pages • 3.1 MB', 'Position 3'),
            ].asMap().entries.map((e) => Container(
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
                  decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(8)),
                  child: const Center(child: Text('PDF', style: TextStyle(color: Color(0xFFCC2200), fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(e.value.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  Text(e.value.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  Text(e.value.$3, style: TextStyle(color: OwnKeepColors.primary, fontSize: 11, fontFamily: 'Inter')),
                ])),
                Icon(Icons.menu_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
              ]),
            )),
            SizedBox(height: OwnKeepSpacing.md),
            Text('Output File', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 16),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text('Merged Documents.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Icon(Icons.edit_outlined, color: OwnKeepColors.darkTextMuted, size: 18),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text('Estimated output', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                Text('12 pages  •  6.7 MB', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ]),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Merge 3 PDFs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}

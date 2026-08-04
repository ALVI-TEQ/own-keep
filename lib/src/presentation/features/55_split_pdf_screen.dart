import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SplitPdfScreen extends StatefulWidget {
  const SplitPdfScreen({super.key});

  @override
  State<SplitPdfScreen> createState() => _SplitPdfScreenState();
}

class _SplitPdfScreenState extends State<SplitPdfScreen> {
  final Set<int> _selected = {1, 2}; // pages 2 and 3 selected (0-indexed)
  int _splitOption = 0; // 0=extract, 1=separate, 2=remove

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
            Text('Split PDF', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Choose pages to extract', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Source file
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Insurance Policy.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('4 pages  •  2.4 MB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Select Pages', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.md),
            // Page thumbnails row
            Row(
              children: List.generate(4, (i) {
                final isSelected = _selected.contains(i);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      if (isSelected) {
                        _selected.remove(i);
                      } else {
                        _selected.add(i);
                      }
                    }),
                    child: Container(
                      margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEBF0),
                        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                        border: Border.all(
                          color: isSelected ? OwnKeepColors.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Stack(children: [
                        Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('PAGE ${i + 1}', style: TextStyle(color: Color(0xFF1A2340), fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                          SizedBox(height: 8),
                          Text('Insurance', style: TextStyle(color: Color(0xFF6B7A99), fontSize: 9, fontFamily: 'Inter')),
                        ])),
                        if (isSelected)
                          Positioned(
                            top: 4, right: 4,
                            child: Container(
                              width: 18, height: 18,
                              decoration: BoxDecoration(color: OwnKeepColors.primary, shape: BoxShape.circle),
                              child: Icon(Icons.check_rounded, color: Colors.white, size: 12),
                            ),
                          ),
                      ]),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Split Options', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            ...[
              ('Extract selected pages', 'Create one PDF from pages 2–3'),
              ('Save pages separately', 'Create individual files'),
              ('Remove selected pages', 'Create PDF without pages 2–3'),
            ].asMap().entries.map((e) => GestureDetector(
              onTap: () => setState(() => _splitOption = e.key),
              child: Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: _splitOption == e.key
                      ? OwnKeepColors.primary.withValues(alpha: 0.1)
                      : OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(
                    color: _splitOption == e.key
                        ? OwnKeepColors.primary.withValues(alpha: 0.5)
                        : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _splitOption == e.key ? OwnKeepColors.primary : OwnKeepColors.darkTextMuted, width: 2),
                    ),
                    child: _splitOption == e.key
                        ? Center(child: Container(width: 10, height: 10, decoration: BoxDecoration(color: OwnKeepColors.primary, shape: BoxShape.circle)))
                        : null,
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.value.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text(e.value.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                ]),
              ),
            )),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Split PDF', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}

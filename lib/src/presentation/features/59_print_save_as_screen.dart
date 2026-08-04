import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class PrintSaveAsScreen extends StatefulWidget {
  const PrintSaveAsScreen({super.key});

  @override
  State<PrintSaveAsScreen> createState() => _PrintSaveAsScreenState();
}

class _PrintSaveAsScreenState extends State<PrintSaveAsScreen> {
  int _selected = 0;

  final _outputs = [
    (Icons.print_outlined, const Color(0xFF3A5ED0), 'Print', 'Use a connected printer'),
    (Icons.picture_as_pdf_outlined, const Color(0xFFCC2200), 'Save as PDF', 'Create a new PDF copy'),
    (Icons.folder_outlined, OwnKeepColors.success, 'Save to Files', 'Choose a local folder'),
    (Icons.image_outlined, OwnKeepColors.ai, 'Export Images', 'Save each page as image'),
  ];

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
            Text('Print / Save As', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Choose output option', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Source file card
            Container(
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(8)),
                  child: const Center(child: Text('PDF', style: TextStyle(color: Color(0xFFCC2200), fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Insurance Policy.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text('4 pages  •  2.4 MB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  Text('Finance › Insurance', style: TextStyle(color: OwnKeepColors.primary, fontSize: 11, fontFamily: 'Inter')),
                ])),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Output', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            ..._outputs.asMap().entries.map((e) => GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: _selected == e.key ? OwnKeepColors.primary.withValues(alpha: 0.1) : OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(
                    color: _selected == e.key ? OwnKeepColors.primary.withValues(alpha: 0.5) : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: e.value.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: Icon(e.value.$1, color: e.value.$2, size: 22),
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.value.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text(e.value.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                  Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                ]),
              ),
            )),
            SizedBox(height: OwnKeepSpacing.sm),
            Text('Page Range', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text('All pages', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Text('1–4', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontFamily: 'Inter')),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.md),
            Text('Privacy', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: 4),
            Text(
              'Printing or saving creates an unencrypted copy outside OwnKeep. Continue only when you trust the destination.',
              style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter', height: 1.5),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}

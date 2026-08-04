import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RenameScreen extends StatefulWidget {
  const RenameScreen({super.key});

  @override
  State<RenameScreen> createState() => _RenameScreenState();
}

class _RenameScreenState extends State<RenameScreen> {
  final _controller = TextEditingController(text: 'Insurance Policy 2025.pdf');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            Text('Rename', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Update file name', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File preview card
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
                border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                  child: Column(mainAxisSize: MainAxisSize.min, children: const [
                    Text('PDF', style: TextStyle(color: Color(0xFFCC2200), fontSize: 26, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
                    SizedBox(height: 4),
                    Text('Insurance Policy', style: TextStyle(color: Color(0xFF3C3F4A), fontSize: 13, fontFamily: 'Inter')),
                  ]),
                ),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('File Name', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            TextField(
              controller: _controller,
              autofocus: true,
              style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
              decoration: InputDecoration(
                filled: true,
                fillColor: OwnKeepColors.darkSurfaceElevated,
                suffixIcon: IconButton(
                  icon: Icon(Icons.close_rounded, color: OwnKeepColors.darkTextMuted, size: 18),
                  onPressed: () => _controller.clear(),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.4))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary, width: 1.5)),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('Location', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 16),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Text('Finance › Insurance', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('Naming Tips', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            ...[
              'Use a clear title',
              'Include a year when useful',
              'Avoid special characters',
              'File extension stays unchanged',
            ].map((tip) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Container(width: 20, height: 20, decoration: BoxDecoration(color: OwnKeepColors.success.withValues(alpha: 0.15), shape: BoxShape.circle), child: Icon(Icons.check_rounded, color: OwnKeepColors.success, size: 12)),
                SizedBox(width: OwnKeepSpacing.sm),
                Text(tip, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
              ]),
            )),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Save Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
            SizedBox(height: OwnKeepSpacing.sm),
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Center(child: Text('Cancel', style: TextStyle(color: OwnKeepColors.primary, fontSize: 15, fontFamily: 'Inter'))),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _titleController = TextEditingController(text: 'Renewal Notes');
  final _noteController = TextEditingController(
    text: 'Call insurer before 20 March.\n\nAsk about family floater upgrade and cashless hospitals near home.\n\nCompare premium with last year before renewing.',
  );
  bool _addReminder = false;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
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
            Text('Add Note', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Insurance Policy.pdf', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text('Title', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            TextField(
              controller: _titleController,
              style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
              decoration: InputDecoration(
                filled: true, fillColor: OwnKeepColors.darkSurfaceElevated,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary, width: 1.5)),
                isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Note
            Text('Note', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Expanded(
              child: Stack(children: [
                TextField(
                  controller: _noteController,
                  maxLines: null, expands: true,
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontFamily: 'Inter', height: 1.7),
                  decoration: InputDecoration(
                    filled: true, fillColor: OwnKeepColors.darkSurfaceElevated,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary, width: 1.5)),
                    contentPadding: EdgeInsets.all(14),
                    isDense: true,
                  ),
                ),
                const Positioned(
                  bottom: 10, right: 14,
                  child: Text('164 / 2000', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
                ),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Attach To
            Text('Attach To', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text('Insurance Policy.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Icon(Icons.check_rounded, color: OwnKeepColors.success, size: 18),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Reminder
            Text('Reminder', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                const Expanded(child: Text('Add reminder for this note', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'))),
                Switch(value: _addReminder, onChanged: (v) => setState(() => _addReminder = v), activeThumbColor: OwnKeepColors.primary),
              ]),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Save Note', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}

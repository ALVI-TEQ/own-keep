import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class WipeDataScreen extends StatefulWidget {
  const WipeDataScreen({super.key});

  @override
  State<WipeDataScreen> createState() => _WipeDataScreenState();
}

class _WipeDataScreenState extends State<WipeDataScreen> {
  final List<bool> _checks = [false, false, false];
  final _controller = TextEditingController();

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
            Text('Wipe Data', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Permanently erase this vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          children: [
            SizedBox(height: OwnKeepSpacing.xl),
            // Warning icon
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: OwnKeepColors.danger.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.6), width: 2),
              ),
              child: const Center(child: Icon(Icons.priority_high_rounded, color: OwnKeepColors.danger, size: 52)),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('This action cannot be undone', textAlign: TextAlign.center,
                style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.md),
            Text(
              'All documents, notes, reminders, tags, recovery settings and encryption keys in this vault will be permanently removed from this device.',
              textAlign: TextAlign.center,
              style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter', height: 1.6),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            // Confirmation checklist
            Container(
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.danger.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Before continuing', style: TextStyle(color: OwnKeepColors.danger, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  SizedBox(height: OwnKeepSpacing.sm),
                  ..._buildCheckItems([
                    'I have created an encrypted backup',
                    'I understand recovery will be impossible',
                    'I want to erase this vault from this device',
                  ]),
                ],
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Type DELETE field
            TextField(
              controller: _controller,
              style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'),
              decoration: InputDecoration(
                hintText: 'Type DELETE to confirm',
                hintStyle: TextStyle(color: OwnKeepColors.darkTextMuted, fontFamily: 'Inter'),
                filled: true,
                fillColor: OwnKeepColors.danger.withValues(alpha: 0.07),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: BorderSide(color: OwnKeepColors.danger.withValues(alpha: 0.4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: BorderSide(color: OwnKeepColors.danger.withValues(alpha: 0.4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: const BorderSide(color: OwnKeepColors.danger),
                ),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Delete button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: OwnKeepColors.danger,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                ),
                child: Text('Permanently Delete Vault', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.md),
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text('Cancel', style: TextStyle(color: OwnKeepColors.primary, fontSize: 15, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCheckItems(List<String> items) {
    return items.asMap().entries.map((e) {
      return Row(
        children: [
          Checkbox(
            value: _checks[e.key],
            onChanged: (v) => setState(() => _checks[e.key] = v ?? false),
            activeColor: OwnKeepColors.danger,
            side: const BorderSide(color: OwnKeepColors.darkTextMuted, width: 1.5),
          ),
          Expanded(child: Text(e.value, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter'))),
        ],
      );
    }).toList();
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SmartSuggestionsScreen extends StatefulWidget {
  const SmartSuggestionsScreen({super.key});
  @override
  State<SmartSuggestionsScreen> createState() => _SmartSuggestionsScreenState();
}

class _SmartSuggestionsScreenState extends State<SmartSuggestionsScreen> {
  int _tab = 0;
  final _tabs = ['All', 'Organize', 'Tags', 'Reminders', 'Cleanup'];

  final _suggestions = [
    (Icons.crop_square_rounded, OwnKeepColors.primary, 'Move 4 files to Insurance', 'Detected policy documents in Finance', 'Apply', OwnKeepColors.primary),
    (Icons.tag_rounded, Color(0xFF7C3AED), 'Add #identity tag to 3 files', 'Passport, PAN and Aadhaar', 'Apply', Color(0xFF7C3AED)),
    (Icons.calendar_today_rounded, Color(0xFFF59E0B), 'Create expiry reminder', 'Driving licence expires in 26 days', 'Add', Color(0xFFF59E0B)),
    (Icons.copy_rounded, OwnKeepColors.success, 'Merge duplicate receipts', 'Two identical premium receipts', 'Review', OwnKeepColors.success),
    (Icons.edit_outlined, OwnKeepColors.ai, 'Rename unclear document', 'IMG_2045 → Health Report - May', 'Rename', OwnKeepColors.ai),
    (Icons.archive_outlined, OwnKeepColors.danger, 'Archive old policy', 'Policy expired 8 months ago', 'Archive', OwnKeepColors.danger),
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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Smart Suggestions', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Review before applying', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 0),
      body: Column(children: [
        // Filter tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
          child: Row(
            children: _tabs.asMap().entries.map((e) => GestureDetector(
              onTap: () => setState(() => _tab = e.key),
              child: Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _tab == e.key ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _tab == e.key ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                child: Text(e.value, style: TextStyle(
                  color: _tab == e.key ? Colors.white : OwnKeepColors.darkTextSecondary,
                  fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter',
                )),
              ),
            )).toList(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            children: [
              ..._suggestions.map((s) => Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: s.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                      child: Icon(s.$1, color: s.$2, size: 20),
                    ),
                    SizedBox(width: OwnKeepSpacing.md),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      Text(s.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    ])),
                  ]),
                  SizedBox(height: OwnKeepSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: s.$6,
                        side: BorderSide(color: s.$6),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(s.$5, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: s.$6, fontFamily: 'Inter')),
                    ),
                  ),
                ]),
              )),
              SizedBox(height: 70),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(OwnKeepSpacing.base),
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Apply Selected Suggestions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ),
      ]),
    );
  }
}

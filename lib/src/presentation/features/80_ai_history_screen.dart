import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiHistoryScreen extends StatefulWidget {
  const AiHistoryScreen({super.key});
  @override
  State<AiHistoryScreen> createState() => _AiHistoryScreenState();
}

class _AiHistoryScreenState extends State<AiHistoryScreen> {
  int _tab = 0;
  final _tabs = ['All', 'Chats', 'Searches', 'Actions', 'Insights'];

  final _items = [
    (OwnKeepColors.primary, Color(0xFF1A3D7A), Icons.crop_square_rounded, 'Find my vehicle insurance', 'Opened policy and expiry reminder', 'Today, 10:30 AM'),
    (OwnKeepColors.ai, Color(0xFF3D1A7A), Icons.auto_awesome_rounded, 'What expires this month?', 'Found 3 documents', 'Today, 9:15 AM'),
    (OwnKeepColors.success, Color(0xFF0A4A2E), Icons.check_box_outlined, 'Organize my finance files', 'Moved 4 files and added 6 tags', 'Yesterday, 7:40 PM'),
    (OwnKeepColors.pink, Color(0xFF7A1A2E), Icons.favorite_rounded, 'Summarize health report', 'Generated local summary', 'Yesterday, 4:20 PM'),
    (Color(0xFFF59E0B), Color(0xFF7A3D0A), Icons.copy_rounded, 'Detect duplicate receipts', 'Resolved 2 duplicate groups', '12 May, 11:10 AM'),
    (OwnKeepColors.ai, Color(0xFF0A3D3D), Icons.calendar_today_rounded, 'Create passport reminder', 'Reminder created for 2031', '10 May, 8:45 AM'),
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
          Text('AI History', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Local conversations and actions', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.crop_square_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: Column(children: [
        // Filter tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
          child: Row(children: _tabs.asMap().entries.map((e) => GestureDetector(
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
          )).toList()),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            children: [
              ..._items.map((item) => Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                child: Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: item.$2, borderRadius: BorderRadius.circular(10)),
                    child: Icon(item.$3, color: Colors.white.withValues(alpha: 0.85), size: 18),
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text(item.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    SizedBox(height: 2),
                    Text(item.$6, style: TextStyle(color: OwnKeepColors.primary, fontSize: 11, fontFamily: 'Inter')),
                  ])),
                  Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                ]),
              )),
              SizedBox(height: OwnKeepSpacing.sm),
              // Clear AI History button
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(OwnKeepSpacing.md),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.danger.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                    border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: const Center(
                    child: Text('Clear AI History', style: TextStyle(color: OwnKeepColors.danger, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  ),
                ),
              ),
              SizedBox(height: 8),
              const Center(
                child: Text('History is stored only on this device', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
              ),
              SizedBox(height: OwnKeepSpacing.xl),
            ],
          ),
        ),
      ]),
    );
  }
}

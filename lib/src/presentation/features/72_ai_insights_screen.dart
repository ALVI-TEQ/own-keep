import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiInsightsScreen extends StatelessWidget {
  const AiInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const insights = [
      (Icons.tag_rounded, Color(0xFF7C3AED), '12 documents need tags', 'Mostly insurance and finance files'),
      (Icons.calendar_today_rounded, Color(0xFFF59E0B), '3 documents expire this month', 'Vehicle insurance, licence, health policy'),
      (Icons.copy_rounded, OwnKeepColors.success, '5 duplicate groups detected', 'Potentially save 1.4 GB'),
      (Icons.add_box_rounded, OwnKeepColors.primary, '8 files are uncategorized', 'AI can organize them automatically'),
      (Icons.warning_amber_rounded, OwnKeepColors.danger, '2 reminders may be outdated', 'Review and update due dates'),
    ];

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
          Text('AI Insights', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Patterns found in your vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Monthly vault insight card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.5)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Monthly Vault Insight', style: TextStyle(color: OwnKeepColors.ai, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter', letterSpacing: 0.5)),
              SizedBox(height: 8),
              Text('Your vault is getting healthier', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text(
                'You organized 34 documents, resolved 12 duplicates and added 6 expiry reminders this month.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter', height: 1.5),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Stats row
          Row(
            children: [
              _StatChip(value: '34', label: 'Organized', color: OwnKeepColors.primary),
              SizedBox(width: 8),
              _StatChip(value: '12', label: 'Duplicates fixed', color: OwnKeepColors.success),
              SizedBox(width: 8),
              _StatChip(value: '6', label: 'Reminders', color: Color(0xFFF59E0B)),
              SizedBox(width: 8),
              _StatChip(value: '2.8 GB', label: 'Space saved', color: OwnKeepColors.ai),
            ],
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Insights', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...insights.map((ins) => Container(
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
                decoration: BoxDecoration(color: ins.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                child: Icon(ins.$1, color: ins.$2, size: 20),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(ins.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(ins.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label, required this.color});
  final String value, label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: 2),
          Text(label, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 9, fontFamily: 'Inter'), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

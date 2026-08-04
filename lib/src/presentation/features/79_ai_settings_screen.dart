import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiSettingsScreen extends StatefulWidget {
  const AiSettingsScreen({super.key});
  @override
  State<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends State<AiSettingsScreen> {
  bool _aiAssistant = true;
  bool _smartSuggestions = true;
  bool _autoTagging = true;
  bool _expiryDetection = true;
  bool _similarDocs = true;
  bool _activityHistory = false;
  bool _backgroundAnalysis = false;

  @override
  Widget build(BuildContext context) {
    final toggles = [
      (Icons.auto_awesome_rounded, OwnKeepColors.ai, 'AI Assistant', 'Enable private vault chat', _aiAssistant, (v) => setState(() => _aiAssistant = v)),
      (Icons.check_box_outlined, OwnKeepColors.primary, 'Smart Suggestions', 'Recommend organization actions', _smartSuggestions, (v) => setState(() => _smartSuggestions = v)),
      (Icons.tag_rounded, OwnKeepColors.success, 'Auto Tagging', 'Suggest tags from document text', _autoTagging, (v) => setState(() => _autoTagging = v)),
      (Icons.calendar_today_rounded, Color(0xFFF59E0B), 'Expiry Detection', 'Find dates and create suggestions', _expiryDetection, (v) => setState(() => _expiryDetection = v)),
      (Icons.copy_rounded, OwnKeepColors.ai, 'Similar Document Groups', 'Detect related files', _similarDocs, (v) => setState(() => _similarDocs = v)),
      (Icons.history_rounded, OwnKeepColors.pink, 'AI Activity History', 'Save local prompt history', _activityHistory, (v) => setState(() => _activityHistory = v)),
      (Icons.bolt_rounded, Color(0xFFF59E0B), 'Background Analysis', 'Analyze while charging', _backgroundAnalysis, (v) => setState(() => _backgroundAnalysis = v)),
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
          Text('AI Settings', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Control local intelligence', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.help_outline_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Privacy banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.4)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Private by design', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Text(
                'OwnKeep AI runs on your device. Your documents and prompts are never uploaded.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter', height: 1.5),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Toggle rows
          ...toggles.map((t) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: t.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(9)),
                child: Icon(t.$1, color: t.$2, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Text(t.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Switch(value: t.$5, onChanged: t.$6, activeThumbColor: OwnKeepColors.primary),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Clear AI History destructive row
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.danger.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
              ),
              child: Row(children: const [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Clear AI History', style: TextStyle(color: OwnKeepColors.danger, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text('Deletes prompts and local AI results', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ])),
                Icon(Icons.chevron_right_rounded, color: OwnKeepColors.danger, size: 20),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

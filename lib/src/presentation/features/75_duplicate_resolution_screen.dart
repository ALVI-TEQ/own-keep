import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DuplicateResolutionScreen extends StatefulWidget {
  const DuplicateResolutionScreen({super.key});
  @override
  State<DuplicateResolutionScreen> createState() => _DuplicateResolutionScreenState();
}

class _DuplicateResolutionScreenState extends State<DuplicateResolutionScreen> {
  int _selected = 0; // 0 = current, 1 = copy

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
          Text('Duplicate Resolution', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Choose what to keep', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Group header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Group 1 of 5', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                Text('Insurance Policy duplicates', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              ]),
              Text('2.4 MB', style: TextStyle(color: OwnKeepColors.success, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // File A — Current (selectable)
          GestureDetector(
            onTap: () => setState(() => _selected = 0),
            child: _FileCard(
              name: 'Insurance Policy.pdf', sub: 'Added today  •  2.4 MB',
              badgeLabel: 'Current', badgeColor: OwnKeepColors.primary,
              selected: _selected == 0,
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // File B — Duplicate
          GestureDetector(
            onTap: () => setState(() => _selected = 1),
            child: _FileCard(
              name: 'Insurance Policy Copy.pdf', sub: 'Added 2 days ago  •  2.4 MB',
              badgeLabel: 'Duplicate', badgeColor: OwnKeepColors.danger,
              selected: _selected == 1,
            ),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // AI recommendation
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Recommended', style: TextStyle(color: OwnKeepColors.ai, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Text('Keep the newer file and delete the copy', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
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
            child: Text('Keep Selected & Delete Duplicate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: OwnKeepColors.primary,
              side: const BorderSide(color: OwnKeepColors.primary),
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Keep Both Files', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

class _FileCard extends StatelessWidget {
  const _FileCard({required this.name, required this.sub, required this.badgeLabel, required this.badgeColor, required this.selected});
  final String name, sub, badgeLabel;
  final Color badgeColor;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(
          color: selected ? OwnKeepColors.primary.withValues(alpha: 0.7) : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(children: [
        Container(
          width: 72, height: 80,
          decoration: BoxDecoration(color: const Color(0xFFEAEBF0), borderRadius: BorderRadius.circular(8)),
          child: const Center(child: Text('PDF', style: TextStyle(color: OwnKeepColors.danger, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
        ),
        SizedBox(width: OwnKeepSpacing.md),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          SizedBox(height: 4),
          Text(sub, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(border: Border.all(color: badgeColor), borderRadius: BorderRadius.circular(6)),
            child: Text(badgeLabel, style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ])),
        if (selected)
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: OwnKeepColors.primary, shape: BoxShape.circle),
            child: Icon(Icons.check_rounded, color: Colors.white, size: 16),
          ),
      ]),
    );
  }
}

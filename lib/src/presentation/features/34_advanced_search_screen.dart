import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Search', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
      ),
      bottomNavigationBar: OwnKeepBottomNav(),
      body: ListView(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: OwnKeepColors.darkTextMuted, size: 20),
                  SizedBox(width: 8),
                  const Expanded(
                    child: Text('insurance policy', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontFamily: 'Inter')),
                  ),
                  Icon(Icons.close, color: OwnKeepColors.darkTextMuted, size: 18),
                  SizedBox(width: 12),
                  Icon(Icons.tune_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              children: const [
                _Chip(label: 'All (24)', isSelected: true),
                _Chip(label: 'Documents (8)'),
                _Chip(label: 'Images (6)'),
                _Chip(label: 'Others (10)'),
              ],
            ),
          ),
          // Top Results
          _SectionLabel(title: 'Top Results'),
          _SearchResultItem(name: 'Health Insurance Policy', type: 'PDF', size: '2.4 MB', date: '31 May 2025', typeColor: OwnKeepColors.danger, isFavorite: true),
          _SearchResultItem(name: 'Car Insurance Policy', type: 'PDF', size: '1.8 MB', date: '20 Jun 2025', typeColor: OwnKeepColors.danger, isFavorite: true),
          _SearchResultItem(name: 'Life Insurance Policy', type: 'PDF', size: '1.2 MB', date: '15 Aug 2025', typeColor: OwnKeepColors.danger, isFavorite: true),
          // Other Results
          _SectionLabel(title: 'Other Results'),
          _SearchResultItem(name: 'Insurance Premium Receipt', type: 'JPG', size: '845 KB', date: '15 May 2025', typeColor: OwnKeepColors.success),
          _SearchResultItem(name: 'Insurance Claim Form', type: 'PDF', size: '1.1 MB', date: '10 Apr 2025', typeColor: OwnKeepColors.danger),
          _SearchResultItem(name: 'Policy Documents', type: 'Folder', size: '8 Items', date: '', typeColor: OwnKeepColors.warning),
          _SearchResultItem(name: 'Insurance Policy Copy', type: 'PDF', size: '2.0 MB', date: '5 Jan 2025', typeColor: OwnKeepColors.danger),
          // AI Search suggestion
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Can't find what you're looking for?", style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('Try AI Search', style: TextStyle(color: OwnKeepColors.primary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.ai.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
                    border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.auto_awesome, color: OwnKeepColors.ai, size: 14),
                      SizedBox(width: 4),
                      Text('AI Search', style: TextStyle(color: OwnKeepColors.ai, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.isSelected = false});
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: OwnKeepSpacing.sm),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
        border: Border.all(color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, OwnKeepSpacing.lg, OwnKeepSpacing.base, OwnKeepSpacing.sm),
      child: Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.name, required this.type, required this.size, required this.date, required this.typeColor, this.isFavorite = false});
  final String name;
  final String type;
  final String size;
  final String date;
  final Color typeColor;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          OwnKeepIconBadge(icon: type == 'Folder' ? Icons.folder_outlined : Icons.description_outlined, color: typeColor),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('$type  •  $size${date.isNotEmpty ? '  •  $date' : ''}', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Icon(
            isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isFavorite ? OwnKeepColors.warning : OwnKeepColors.darkTextMuted,
            size: 20,
          ),
        ],
      ),
    );
  }
}

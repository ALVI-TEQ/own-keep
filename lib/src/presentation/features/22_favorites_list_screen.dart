import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class FavoritesListScreen extends StatelessWidget {
  const FavoritesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Favorites',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search, color: OwnKeepColors.darkTextPrimary)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
            child: Row(
              children: [
                _FilterChip(label: 'All', isSelected: true),
                _FilterChip(label: 'Documents'),
                _FilterChip(label: 'Images'),
                _FilterChip(label: 'Others'),
              ],
            ),
          ),
          // File list
          Expanded(
            child: ListView(
              children: const [
                _FavoriteFileItem(name: 'Passport', type: 'PDF', size: '1.2 MB', date: 'Today, 10:30 AM', typeColor: OwnKeepColors.danger),
                _FavoriteFileItem(name: 'Insurance Policy', type: 'PDF', size: '2.4 MB', date: 'Yesterday', typeColor: OwnKeepColors.danger),
                _FavoriteFileItem(name: 'Family Photo', type: 'JPG', size: '3.6 MB', date: '2 days ago', typeColor: OwnKeepColors.ai),
                _FavoriteFileItem(name: 'Aadhaar Card', type: 'PDF', size: '1.1 MB', date: '3 days ago', typeColor: OwnKeepColors.danger),
                _FavoriteFileItem(name: 'Driving License', type: 'PDF', size: '1.0 MB', date: '5 days ago', typeColor: OwnKeepColors.danger),
                _FavoriteFileItem(name: 'Bank Statement', type: 'PDF', size: '3.2 MB', date: '7 days ago', typeColor: OwnKeepColors.danger),
                _FavoriteFileItem(name: 'Income Tax Return 2024', type: 'XLSX', size: '540 KB', date: '10 May 2025', typeColor: OwnKeepColors.success),
                _FavoriteFileItem(name: 'Property Papers', type: 'PDF', size: '4.8 MB', date: '8 May 2025', typeColor: OwnKeepColors.danger),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.isSelected = false});
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: OwnKeepSpacing.sm),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
        border: Border.all(
          color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : OwnKeepColors.darkTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _FavoriteFileItem extends StatelessWidget {
  const _FavoriteFileItem({
    required this.name,
    required this.type,
    required this.size,
    required this.date,
    required this.typeColor,
  });

  final String name;
  final String type;
  final String size;
  final String date;
  final Color typeColor;

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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
            ),
            child: Center(
              child: Text(
                type,
                style: TextStyle(color: typeColor, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Inter'),
              ),
            ),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('$type  •  $size', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Icon(Icons.star_rounded, color: OwnKeepColors.warning, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

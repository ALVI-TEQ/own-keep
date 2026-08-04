import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class TagManagerScreen extends StatelessWidget {
  const TagManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Tag Manager',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.add, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: OwnKeepColors.darkTextMuted, size: 20),
                  SizedBox(width: 8),
                  Text('Search tags...', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 14, fontFamily: 'Inter')),
                ],
              ),
            ),
          ),
          // Smart Tags
          _SectionWithCount(title: 'Smart Tags', count: 8),
          _TagItem(name: 'Identity', count: 24, icon: Icons.fingerprint, color: OwnKeepColors.primary),
          _TagItem(name: 'Finance', count: 18, icon: Icons.account_balance_outlined, color: OwnKeepColors.success),
          _TagItem(name: 'Insurance', count: 16, icon: Icons.shield_outlined, color: OwnKeepColors.cyan),
          _TagItem(name: 'Health', count: 14, icon: Icons.favorite_outline, color: OwnKeepColors.pink),
          _TagItem(name: 'Property', count: 12, icon: Icons.home_outlined, color: OwnKeepColors.orange),
          _TagItem(name: 'Vehicle', count: 10, icon: Icons.directions_car_outlined, color: OwnKeepColors.primary),
          _TagItem(name: 'Work', count: 8, icon: Icons.work_outline, color: OwnKeepColors.ai),
          _TagItem(name: 'Important', count: 20, icon: Icons.star_outline, color: OwnKeepColors.warning),
          // Custom Tags
          _SectionWithCount(title: 'Custom Tags', count: 4),
          _TagItem(name: 'Travel', count: 6, icon: Icons.flight_outlined, color: OwnKeepColors.cyan),
          _TagItem(name: 'Education', count: 7, icon: Icons.school_outlined, color: OwnKeepColors.success),
          _TagItem(name: 'Personal', count: 15, icon: Icons.person_outline, color: OwnKeepColors.ai),
          _TagItem(name: 'Family', count: 9, icon: Icons.people_outline, color: OwnKeepColors.orange),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _SectionWithCount extends StatelessWidget {
  const _SectionWithCount({required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, OwnKeepSpacing.lg, OwnKeepSpacing.base, OwnKeepSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: OwnKeepColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
            ),
            child: Text('$count', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}

class _TagItem extends StatelessWidget {
  const _TagItem({required this.name, required this.count, required this.icon, required this.color});
  final String name;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          OwnKeepIconBadge(icon: icon, color: color, size: 36, iconSize: 18),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(child: Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter'))),
          Text('$count', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
          SizedBox(width: OwnKeepSpacing.sm),
          Icon(Icons.more_vert, color: OwnKeepColors.darkTextMuted, size: 18),
        ],
      ),
    );
  }
}

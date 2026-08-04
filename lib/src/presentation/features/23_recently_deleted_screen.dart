import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RecentlyDeletedScreen extends StatelessWidget {
  const RecentlyDeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Recently Deleted',
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Select', style: TextStyle(color: OwnKeepColors.primary, fontFamily: 'Inter')),
        ),
      ],
      body: Column(
        children: [
          // Info banner
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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: OwnKeepColors.danger.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
                  ),
                  child: Icon(Icons.delete_outline, color: OwnKeepColors.danger, size: 22),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Items in trash are stored locally', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('You can restore or permanently\ndelete them.', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Item count + sort
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30 items', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                Row(
                  children: [
                    Text('Newest first', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                    Icon(Icons.arrow_drop_down, color: OwnKeepColors.darkTextSecondary),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // Deleted files list
          Expanded(
            child: ListView(
              children: const [
                _DeletedFileItem(name: 'Old Insurance Policy', type: 'PDF', size: '1.8 MB', deletedAt: 'Deleted 1 hour ago', typeColor: OwnKeepColors.danger),
                _DeletedFileItem(name: 'Screenshot_2025...', type: 'JPG', size: '1.2 MB', deletedAt: 'Deleted 3 hours ago', typeColor: OwnKeepColors.ai),
                _DeletedFileItem(name: 'Old Bank Statement', type: 'PDF', size: '2.3 MB', deletedAt: 'Deleted Yesterday', typeColor: OwnKeepColors.danger),
                _DeletedFileItem(name: 'IMG_20240115_1205', type: 'JPG', size: '3.7 MB', deletedAt: 'Deleted 2 days ago', typeColor: OwnKeepColors.ai),
                _DeletedFileItem(name: 'Tax Receipt 2023', type: 'PDF', size: '1.1 MB', deletedAt: 'Deleted 5 days ago', typeColor: OwnKeepColors.danger),
                _DeletedFileItem(name: 'Project Plan.docx', type: 'DOCX', size: '520 KB', deletedAt: 'Deleted 7 days ago', typeColor: OwnKeepColors.primary),
              ],
            ),
          ),
          // Bottom action buttons
          Padding(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever, color: OwnKeepColors.danger, size: 18),
                    label: Text('Empty Trash', style: TextStyle(color: OwnKeepColors.danger, fontFamily: 'Inter')),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: OwnKeepColors.danger),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.restore, size: 18),
                    label: Text('Restore All', style: TextStyle(fontFamily: 'Inter')),
                    style: FilledButton.styleFrom(
                      backgroundColor: OwnKeepColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
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

class _DeletedFileItem extends StatelessWidget {
  const _DeletedFileItem({
    required this.name,
    required this.type,
    required this.size,
    required this.deletedAt,
    required this.typeColor,
  });

  final String name;
  final String type;
  final String size;
  final String deletedAt;
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
              child: Text(type, style: TextStyle(color: typeColor, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            ),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('$type  •  $size     $deletedAt', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Icon(Icons.restore_rounded, color: OwnKeepColors.darkTextMuted, size: 22),
        ],
      ),
    );
  }
}

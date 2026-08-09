import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/ownkeep_main_colors.dart';

class OwnKeepActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const OwnKeepActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OwnKeepRecentCard extends StatelessWidget {
  final String type;
  final Color typeColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const OwnKeepRecentCard({
    super.key,
    required this.type,
    required this.typeColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: OwnKeepSpacing.md),
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: typeColor),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: typeColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: colors.textSecondary, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OwnKeepSmartCollectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String count;
  final VoidCallback onTap;

  const OwnKeepSmartCollectionCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: iconColor, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$count items',
                  style: TextStyle(color: colors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OwnKeepStorageBar extends StatelessWidget {
  final double percentage;
  final String labelText;

  const OwnKeepStorageBar({
    super.key,
    required this.percentage,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Storage Overview',
              style: TextStyle(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              labelText,
              style: TextStyle(color: colors.primaryBlue, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: OwnKeepSpacing.md),
        Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primaryBlue, colors.aiPurple],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: OwnKeepSpacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(color: colors.primaryBlue, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class OwnKeepSearchField extends StatelessWidget {
  final String placeholder;

  const OwnKeepSearchField({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return TextField(
      style: TextStyle(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: colors.textSecondary),
        prefixIcon: Icon(Icons.search, color: colors.textSecondary),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: OwnKeepSpacing.lg,
          vertical: OwnKeepSpacing.md,
        ),
      ),
    );
  }
}

class OwnKeepFileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final VoidCallback onTap;

  const OwnKeepFileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.textPrimary,
        ),
      ),
      subtitle: Text(date, style: TextStyle(color: colors.textSecondary)),
      trailing: Icon(Icons.more_vert, color: colors.textSecondary),
      onTap: onTap,
    );
  }
}

class OwnKeepCollectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final VoidCallback onTap;

  const OwnKeepCollectionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors.primaryBlue, size: 32),
            SizedBox(height: OwnKeepSpacing.sm),
            Text(
              label,
              style: TextStyle(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xs),
            Text(
              '$count items',
              style: TextStyle(color: colors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

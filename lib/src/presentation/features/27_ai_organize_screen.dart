import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiOrganizeScreen extends StatelessWidget {
  const AiOrganizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'AI Organize',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.history_rounded, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // AI Scan Complete banner
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OwnKeepColors.ai.withValues(alpha: 0.25),
                  OwnKeepColors.primary.withValues(alpha: 0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: OwnKeepColors.ai.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_rounded, color: OwnKeepColors.ai, size: 32),
                ),
                SizedBox(height: OwnKeepSpacing.md),
                Text('AI Scan Complete', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.xs),
                Text('I found 28 items that can be\nbetter organized.', textAlign: TextAlign.center, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.lg),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [OwnKeepColors.ai, OwnKeepColors.primary]),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Review Suggestions', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Suggestions
          const OwnKeepSectionHeader(title: 'Suggestions (12)'),
          OwnKeepListTile(
            title: 'Uncategorized Documents',
            subtitle: '8 items\nMove to appropriate collections',
            icon: Icons.folder_outlined,
            iconColor: OwnKeepColors.orange,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Duplicate Items',
            subtitle: '5 items\nReview and remove duplicates',
            icon: Icons.file_copy_outlined,
            iconColor: OwnKeepColors.danger,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Missing Tags',
            subtitle: '7 items\nAdd relevant tags automatically',
            icon: Icons.label_outline_rounded,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Similar Documents',
            subtitle: '4 groups\nOrganize similar documents together',
            icon: Icons.compare_outlined,
            iconColor: OwnKeepColors.ai,
            onTap: () {},
          ),
          // Auto Organization toggle
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Auto Organization', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('Let AI organize new items automatically', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (_) {},
                  activeThumbColor: OwnKeepColors.primary,
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DuplicateFinderScreen extends StatelessWidget {
  const DuplicateFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Duplicate Finder',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // Stats card
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.xl),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                // Donut chart
                SizedBox(
                  width: 110, height: 110,
                  child: CustomPaint(
                    painter: _DuplicateDonut(),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('873', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                          Text('Duplicates\nFound', textAlign: TextAlign.center, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: OwnKeepSpacing.xl),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatRow(icon: Icons.photo_outlined, label: 'Photos', value: '623', color: OwnKeepColors.primary),
                    SizedBox(height: 10),
                    _StatRow(icon: Icons.description_outlined, label: 'Documents', value: '186', color: OwnKeepColors.warning),
                    SizedBox(height: 10),
                    _StatRow(icon: Icons.video_library_outlined, label: 'Videos', value: '64', color: OwnKeepColors.danger),
                  ],
                ),
              ],
            ),
          ),
          // Free up card
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
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
                      Text('You can free up', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('2.48 GB', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: OwnKeepColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text('Review Duplicates', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ],
            ),
          ),
          // Smart Groups
          OwnKeepSectionHeader(title: 'Smart Groups', actionText: 'View All', onAction: () {}),
          _GroupItem(label: 'Similar Photos', count: '452 items', size: '1.36 GB', icon: Icons.photo_library_outlined, color: OwnKeepColors.primary),
          _GroupItem(label: 'Similar Documents', count: '214 items', size: '680 MB', icon: Icons.file_copy_outlined, color: OwnKeepColors.warning),
          _GroupItem(label: 'Similar Videos', count: '64 items', size: '450 MB', icon: Icons.video_collection_outlined, color: OwnKeepColors.danger),
          _GroupItem(label: 'Screenshots', count: '143 items', size: '280 MB', icon: Icons.screenshot_outlined, color: OwnKeepColors.ai),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _DuplicateDonut extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 12.0;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final segments = [
      (OwnKeepColors.primary, 0.52),
      (OwnKeepColors.warning, 0.21),
      (OwnKeepColors.danger, 0.07),
    ];
    double start = -pi / 2;
    for (final (color, frac) in segments) {
      final sweep = 2 * pi * frac;
      canvas.drawArc(rect, start, sweep - 0.05, false, Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
        SizedBox(width: 8),
        Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
      ],
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({required this.label, required this.count, required this.size, required this.icon, required this.color});
  final String label;
  final String count;
  final String size;
  final IconData icon;
  final Color color;

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
          OwnKeepIconBadge(icon: icon, color: color),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('$count  •  $size', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
        ],
      ),
    );
  }
}

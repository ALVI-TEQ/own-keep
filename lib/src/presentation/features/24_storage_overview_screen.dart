import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class StorageOverviewScreen extends StatelessWidget {
  const StorageOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Storage Overview',
      body: ListView(
        children: [
          // Vault Storage card with donut chart
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Vault Storage', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text('128 GB Total', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                Row(
                  children: [
                    // Donut chart
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CustomPaint(
                        painter: _DonutChartPainter(),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('73%', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                              Text('Used', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: OwnKeepSpacing.xl),
                    // Legend
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LegendItem(color: OwnKeepColors.primary, label: 'Documents', value: '48.5 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.success, label: 'Images', value: '28.3 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.warning, label: 'Videos', value: '22.1 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.darkTextMuted, label: 'Others', value: '6.2 GB'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                Text('93.8 GB used of 128 GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.sm),
                const OwnKeepProgressBar(value: 0.73),
              ],
            ),
          ),
          // Large Items section
          OwnKeepSectionHeader(title: 'Large Items', actionText: 'See All', onAction: () {}),
          _LargeFileItem(name: 'Vacation Video.mp4', size: '2.4 GB', icon: Icons.play_circle_outline, color: OwnKeepColors.ai),
          _LargeFileItem(name: 'Family Photo RAW.dng', size: '1.8 GB', icon: Icons.image_outlined, color: OwnKeepColors.success),
          _LargeFileItem(name: 'Project Files.zip', size: '1.2 GB', icon: Icons.folder_zip_outlined, color: OwnKeepColors.warning),
          // Cleanup Suggestions
          const OwnKeepSectionHeader(title: 'Cleanup Suggestions'),
          OwnKeepListTile(
            title: 'Duplicate Photos',
            subtitle: '367 files  •  2.1 GB',
            icon: Icons.photo_library_outlined,
            iconColor: OwnKeepColors.ai,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Large Videos',
            subtitle: '12 files  •  9.8 GB',
            icon: Icons.video_library_outlined,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Unopened Documents',
            subtitle: '23 files  •  1.3 GB',
            icon: Icons.description_outlined,
            iconColor: OwnKeepColors.warning,
            onTap: () {},
          ),
          // Scan Again
          Padding(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Last scanned: Today, 9:20 AM', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: OwnKeepColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.pill)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text('Scan Again', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 14.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final segments = [
      (OwnKeepColors.primary, 0.38),
      (OwnKeepColors.success, 0.22),
      (OwnKeepColors.warning, 0.17),
      (const Color(0xFF72819C), 0.05),
    ];

    double startAngle = -pi / 2;
    for (final (color, fraction) in segments) {
      final sweepAngle = 2 * pi * fraction;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, sweepAngle - 0.04, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label, required this.value});
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        SizedBox(width: 80, child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter'))),
        Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
      ],
    );
  }
}

class _LargeFileItem extends StatelessWidget {
  const _LargeFileItem({required this.name, required this.size, required this.icon, required this.color});
  final String name;
  final String size;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(child: Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter'))),
          Text(size, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}

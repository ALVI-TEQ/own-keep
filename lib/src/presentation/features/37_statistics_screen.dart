import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Statistics',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.ios_share_outlined, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // Vault Overview card
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vault Overview', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: OwnKeepColors.darkSurfaceMuted,
                        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
                      ),
                      child: Row(children: const [
                        Text('This Month', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: OwnKeepColors.darkTextSecondary, size: 18),
                      ]),
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                Row(
                  children: [
                    // Donut chart
                    SizedBox(
                      width: 110, height: 110,
                      child: CustomPaint(
                        painter: _VaultDonut(),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('128', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                              Text('GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: OwnKeepSpacing.xl),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LegendItem(color: OwnKeepColors.primary, label: 'Documents', value: '48.5 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.warning, label: 'Images', value: '32.4 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.danger, label: 'Videos', value: '22.1 GB'),
                        SizedBox(height: 8),
                        _LegendItem(color: OwnKeepColors.darkTextMuted, label: 'Others', value: '25.0 GB'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Used: 103 GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                    Text('Free: 25 GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.sm),
                const OwnKeepProgressBar(value: 0.80, color: OwnKeepColors.primary),
              ],
            ),
          ),
          // Stats counts
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              children: const [
                _StatCard(icon: Icons.description_outlined, label: 'Total Items', value: '12,547', color: OwnKeepColors.primary),
                SizedBox(width: OwnKeepSpacing.sm),
                _StatCard(icon: Icons.folder_outlined, label: 'Folders', value: '428', color: OwnKeepColors.warning),
                SizedBox(width: OwnKeepSpacing.sm),
                _StatCard(icon: Icons.insert_drive_file_outlined, label: 'Files', value: '12,119', color: OwnKeepColors.ai),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Activity Summary
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Activity Summary', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceMuted, borderRadius: BorderRadius.circular(OwnKeepRadius.pill)),
                  child: Row(children: const [
                    Text('This Month', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: OwnKeepColors.darkTextSecondary, size: 16),
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          _ActivityRow(icon: Icons.upload_file_outlined, label: 'Files Added', value: '+342', color: OwnKeepColors.success),
          _ActivityRow(icon: Icons.play_circle_outline, label: 'Files Opened', value: '+1,842', color: OwnKeepColors.ai),
          _ActivityRow(icon: Icons.shield_outlined, label: 'Space Saved', value: '2.48 GB', color: OwnKeepColors.success),
          _ActivityRow(icon: Icons.remove_circle_outline, label: 'Duplicates Removed', value: '873', color: OwnKeepColors.warning),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _VaultDonut extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final segments = [
      (OwnKeepColors.primary, 0.38),
      (OwnKeepColors.warning, 0.25),
      (OwnKeepColors.danger, 0.17),
      (const Color(0xFF72819C), 0.20),
    ];
    double start = -pi / 2;
    for (final (color, frac) in segments) {
      final sweep = 2 * pi * frac;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start, sweep - 0.04, false, Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13
        ..strokeCap = StrokeCap.round);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_) => false;
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
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        SizedBox(width: 78, child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter'))),
        Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            OwnKeepIconBadge(icon: icon, color: color, size: 36, iconSize: 18),
            SizedBox(height: 8),
            Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: 2),
            Text(label, textAlign: TextAlign.center, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label;
  final String value;
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
          OwnKeepIconBadge(icon: icon, color: color, size: 36, iconSize: 18),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Inter'))),
          Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          SizedBox(width: OwnKeepSpacing.md),
          // Sparkline placeholder
          SizedBox(
            width: 48, height: 28,
            child: CustomPaint(painter: _SparklinePainter(color: color)),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final pts = [0.6, 0.4, 0.7, 0.5, 0.8, 0.6, 0.9];
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    for (int i = 0; i < pts.length; i++) {
      final x = i * size.width / (pts.length - 1);
      final y = size.height - pts[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

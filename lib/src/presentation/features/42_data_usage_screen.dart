import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DataUsageScreen extends StatelessWidget {
  const DataUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Data Usage',
      showBottomNav: true,
      body: ListView(
        children: [
          // Vault Storage card
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
                Text('Vault Storage', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.lg),
                Row(
                  children: [
                    SizedBox(
                      width: 120, height: 120,
                      child: CustomPaint(
                        painter: _StorageDonut(),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('128', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                              Text('GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: OwnKeepSpacing.xl),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Legend(color: OwnKeepColors.primary, label: 'Documents', value: '48.5 GB'),
                        SizedBox(height: 10),
                        _Legend(color: OwnKeepColors.warning, label: 'Images', value: '32.4 GB'),
                        SizedBox(height: 10),
                        _Legend(color: OwnKeepColors.danger, label: 'Videos', value: '22.1 GB'),
                        SizedBox(height: 10),
                        _Legend(color: Color(0xFF72819C), label: 'Others', value: '25.0 GB'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Used: 103 GB', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                    Text('Free: 25 GB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.sm),
                const OwnKeepProgressBar(value: 0.80, color: OwnKeepColors.primary),
              ],
            ),
          ),

          // Storage by Type
          const OwnKeepSectionHeader(title: 'Storage by Type'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: const [
                _TypeRow(icon: Icons.description_outlined, iconColor: OwnKeepColors.primary, label: 'Documents', size: '48.5 GB', pct: '38%'),
                _TypeRow(icon: Icons.image_outlined, iconColor: OwnKeepColors.success, label: 'Images', size: '32.4 GB', pct: '25%'),
                _TypeRow(icon: Icons.videocam_outlined, iconColor: OwnKeepColors.danger, label: 'Videos', size: '22.1 GB', pct: '17%'),
                _TypeRow(icon: Icons.insert_drive_file_outlined, iconColor: Color(0xFF72819C), label: 'Others', size: '25.0 GB', pct: '20%', isLast: true),
              ],
            ),
          ),

          // Large Files
          OwnKeepSectionHeader(title: 'Large Files', actionText: 'See All', onAction: () {}),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: const [
                _LargeFileRow(icon: Icons.video_file_outlined, iconColor: OwnKeepColors.primary, label: 'Vacation Video.mp4', size: '2.4 GB'),
                _LargeFileRow(icon: Icons.folder_zip_outlined, iconColor: OwnKeepColors.ai, label: 'Project Files.zip', size: '1.2 GB'),
                _LargeFileRow(icon: Icons.photo_outlined, iconColor: OwnKeepColors.warning, label: 'Family Photos RAW.dng', size: '1.0 GB', isLast: true),
              ],
            ),
          ),

          // Storage Optimization
          const OwnKeepSectionHeader(title: 'Storage Optimization'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: const [
                _OptimRow(icon: Icons.file_copy_outlined, iconColor: OwnKeepColors.success, label: 'Duplicate Files', size: '2.48 GB'),
                _OptimRow(icon: Icons.delete_sweep_outlined, iconColor: OwnKeepColors.danger, label: 'Unneeded Files', size: '1.13 GB', isLast: true),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _StorageDonut extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final segments = [
      (OwnKeepColors.primary, 0.38),
      (OwnKeepColors.warning, 0.25),
      (OwnKeepColors.danger, 0.17),
      (const Color(0xFF72819C), 0.20),
    ];
    double start = -pi / 2;
    for (final (color, frac) in segments) {
      final sweep = 2 * pi * frac;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start, sweep - 0.04, false,
          Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 14..strokeCap = StrokeCap.round);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label, required this.value});
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      SizedBox(width: 8),
      SizedBox(width: 76, child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter'))),
      Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
    ]);
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow({required this.icon, required this.iconColor, required this.label, required this.size, required this.pct, this.isLast = false});
  final IconData icon;
  final Color iconColor;
  final String label;
  final String size;
  final String pct;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
          child: Row(children: [
            OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
            SizedBox(width: OwnKeepSpacing.md),
            Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'))),
            Text(size, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
            SizedBox(width: OwnKeepSpacing.md),
            SizedBox(width: 40, child: Text(pct, textAlign: TextAlign.end, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter'))),
          ]),
        ),
        if (!isLast) Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.2), indent: 64),
      ],
    );
  }
}

class _LargeFileRow extends StatelessWidget {
  const _LargeFileRow({required this.icon, required this.iconColor, required this.label, required this.size, this.isLast = false});
  final IconData icon;
  final Color iconColor;
  final String label;
  final String size;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
          child: Row(children: [
            OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
            SizedBox(width: OwnKeepSpacing.md),
            Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'))),
            Text(size, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
          ]),
        ),
        if (!isLast) Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.2), indent: 64),
      ],
    );
  }
}

class _OptimRow extends StatelessWidget {
  const _OptimRow({required this.icon, required this.iconColor, required this.label, required this.size, this.isLast = false});
  final IconData icon;
  final Color iconColor;
  final String label;
  final String size;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
          child: Row(children: [
            OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
            SizedBox(width: OwnKeepSpacing.md),
            Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'))),
            Text(size, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
          ]),
        ),
        if (!isLast) Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.2), indent: 64),
      ],
    );
  }
}

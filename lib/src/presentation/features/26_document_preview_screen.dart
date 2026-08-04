import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DocumentPreviewScreen extends StatelessWidget {
  const DocumentPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Passport.pdf',
      showBottomNav: true,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.star_border_rounded, color: OwnKeepColors.warning, size: 24)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // Document preview placeholder
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            height: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 60, color: Colors.grey.shade400),
                  SizedBox(height: 8),
                  Text('Document Preview', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  SizedBox(height: 4),
                  Text('REPUBLIC OF INDIA', style: TextStyle(color: Colors.grey.shade800, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          // Page indicator
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios, size: 14, color: OwnKeepColors.darkTextMuted),
                SizedBox(width: 8),
                Text('1 / 2', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 14, color: OwnKeepColors.darkTextMuted),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          // File info
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: OwnKeepColors.danger.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
                      ),
                      child: const Center(child: Text('PDF', style: TextStyle(color: OwnKeepColors.danger, fontSize: 10, fontWeight: FontWeight.w700))),
                    ),
                    SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Passport.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                        Text('PDF Document  •  1.2 MB', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.base),
                const _InfoRow(label: 'Added:', value: '10 May 2025, 10:30 AM'),
                const _InfoRow(label: 'Location:', value: 'Personal > IDs'),
                SizedBox(height: OwnKeepSpacing.sm),
                // Tags
                Row(
                  children: [
                    Text('Tags:  ', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                    _TagChip(label: 'Identity', color: OwnKeepColors.primary),
                    SizedBox(width: 6),
                    _TagChip(label: 'Important', color: OwnKeepColors.warning),
                    SizedBox(width: 6),
                    _TagChip(label: 'Personal', color: OwnKeepColors.ai),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.sm),
                const _InfoRow(label: 'Notes:', value: 'My valid passport document.'),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          // Action buttons row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(icon: Icons.share_outlined, label: 'Share'),
                _ActionButton(icon: Icons.favorite_border, label: 'Favorite'),
                _ActionButton(icon: Icons.download_outlined, label: 'Download'),
                _ActionButton(icon: Icons.more_horiz, label: 'More'),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 72, child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 13, fontFamily: 'Inter'))),
          Expanded(child: Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontFamily: 'Inter'))),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: OwnKeepColors.darkSurfaceElevated,
            shape: BoxShape.circle,
            border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: OwnKeepColors.darkTextSecondary, size: 22),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
      ],
    );
  }
}

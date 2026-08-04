import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class FileDetailsScreen extends StatelessWidget {
  const FileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('File Details', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Passport.pdf', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded, color: OwnKeepColors.darkTextPrimary)),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: ListView(
        children: [
          // Preview area
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            height: 160,
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EBF0),
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Text('PASSPORT', style: TextStyle(color: Color(0xFF1A2340), fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 1.5, fontFamily: 'Inter')),
                  SizedBox(height: 4),
                  Text('Preview', style: TextStyle(color: Color(0xFF6B7A99), fontSize: 12, fontFamily: 'Inter')),
                ]),
              ),
            ),
          ),

          // General info section
          _SectionLabel(text: 'General'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: const [
                _InfoRow(label: 'File name', value: 'Passport.pdf', isFirst: true),
                _InfoRow(label: 'Type', value: 'PDF document'),
                _InfoRow(label: 'Size', value: '1.2 MB'),
                _InfoRow(label: 'Added', value: '10 May 2025, 10:30 AM'),
                _InfoRow(label: 'Modified', value: '10 May 2025, 10:31 AM'),
                _InfoRow(label: 'Location', value: 'Personal › Identity', isLast: true),
              ],
            ),
          ),

          // Security section
          _SectionLabel(text: 'Security'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: const Column(
              children: [
                _InfoRow(label: 'Encryption', value: 'AES-256-GCM', isFirst: true),
                _InfoRow(label: 'Integrity', value: 'Verified', valueColor: OwnKeepColors.success),
                _InfoRow(label: 'Local file ID', value: '7FA2-91C8-48D2', isLast: true),
              ],
            ),
          ),

          SizedBox(height: OwnKeepSpacing.lg),
          // Open Document button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Open Document', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, OwnKeepSpacing.lg, OwnKeepSpacing.base, OwnKeepSpacing.sm),
      child: Text(text, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor, this.isFirst = false, this.isLast = false});
  final String label;
  final String value;
  final Color? valueColor;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
              Text(value, style: TextStyle(color: valueColor ?? OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
      ],
    );
  }
}

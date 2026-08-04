import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class DataCheckScreen extends StatelessWidget {
  const DataCheckScreen({super.key});

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
            Text('Data Check', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Verify vault integrity', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded, color: OwnKeepColors.darkTextPrimary)),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          children: [
            SizedBox(height: OwnKeepSpacing.xl),
            // Green check circle
            Container(
              width: 110, height: 110,
              decoration: BoxDecoration(
                color: OwnKeepColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: OwnKeepColors.success.withValues(alpha: 0.6), width: 2.5),
              ),
              child: const Center(child: Icon(Icons.check_rounded, color: OwnKeepColors.success, size: 56)),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            Text('Everything looks good', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: 6),
            Text('Last checked today at 9:20 AM', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.xl),
            // Stat chips
            Row(
              children: const [
                _StatChip(value: '248', label: 'Items checked', color: OwnKeepColors.primary),
                SizedBox(width: OwnKeepSpacing.sm),
                _StatChip(value: '0', label: 'Corrupt files'),
                SizedBox(width: OwnKeepSpacing.sm),
                _StatChip(value: '0', label: 'Missing files'),
                SizedBox(width: OwnKeepSpacing.sm),
                _StatChip(value: '100%', label: 'Integrity', color: OwnKeepColors.ai),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            // Checks performed
            Align(alignment: Alignment.centerLeft,
                child: Text('Checks Performed', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'))),
            SizedBox(height: OwnKeepSpacing.sm),
            Expanded(
              child: ListView(
                children: const [
                  _CheckItem(title: 'File integrity', subtitle: 'All file hashes match'),
                  _CheckItem(title: 'Encrypted manifests', subtitle: 'Valid and readable'),
                  _CheckItem(title: 'Document index', subtitle: 'No missing entries'),
                  _CheckItem(title: 'Recovery metadata', subtitle: 'Verified'),
                  _CheckItem(title: 'Storage consistency', subtitle: 'No orphaned files'),
                ],
              ),
            ),
            // Run Again button
            Padding(
              padding: EdgeInsets.only(top: OwnKeepSpacing.md),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: OwnKeepColors.primary,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                  ),
                  child: Text('Run Data Check Again', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label, this.color});
  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color ?? OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: 3),
            Text(label, textAlign: TextAlign.center, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 10, fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  const _CheckItem({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: OwnKeepColors.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.check_rounded, color: OwnKeepColors.success, size: 18),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
            ]),
          ),
          Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 18),
        ],
      ),
    );
  }
}

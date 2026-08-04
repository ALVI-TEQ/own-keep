import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class OwnKeepProScreen extends StatelessWidget {
  const OwnKeepProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const features = [
      ('PDF', Color(0xFF1A3D7A), OwnKeepColors.primary, 'Advanced document tools', 'Merge, split, compare and OCR'),
      ('★', Color(0xFF3D1A7A), Color(0xFF7C3AED), 'On-device AI', 'Smart search, tags and insights'),
      ('♥', Color(0xFF7A1A2E), OwnKeepColors.pink, 'Family Vault', 'Offline encrypted sharing'),
      ('✓', Color(0xFF0A4A2E), OwnKeepColors.success, 'Security tools', 'Hidden vault, decoy vault and audit'),
      ('□', Color(0xFF7A3D0A), Color(0xFFF59E0B), 'Unlimited collections', 'Create and customize freely'),
    ];

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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('OwnKeep Pro', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Unlock advanced local features', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: Color(0xFF3D1A7A), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.star_rounded, color: Color(0xFF7C3AED), size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(children: [
          // Hero pricing card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A3D),
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: const Color(0xFF7C3AED), width: 1.5),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('OWNKEEP PRO', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2, fontFamily: 'Inter')),
              SizedBox(height: 10),
              Text('Everything stays yours', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text(
                'One premium upgrade for advanced security, AI organization, document tools and family vault features.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, height: 1.5, fontFamily: 'Inter'),
              ),
              SizedBox(height: 16),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('₹1,499', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
                SizedBox(width: 8),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text('one-time', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                ),
              ]),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Included Features', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Expanded(
            child: ListView(children: features.map((f) => Container(
              margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
              padding: EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: f.$2, borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text(f.$1, style: TextStyle(color: f.$3, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(f.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text(f.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ])),
                Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
              ]),
            )).toList()),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Upgrade to OwnKeep Pro', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
          SizedBox(height: 8),
          Text('Purchase entitlement is cached for offline use', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
        ]),
      ),
    );
  }
}

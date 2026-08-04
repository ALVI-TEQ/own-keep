import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class HiddenVaultScreen extends StatelessWidget {
  const HiddenVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const howItWorks = [
      (Color(0xFF3D1A7A), Color(0xFF7C3AED), Icons.circle_rounded, 'Separate PIN', 'Different from your main vault PIN'),
      (Color(0xFF1A3D7A), OwnKeepColors.primary, Icons.north_east_rounded, 'Hidden entry gesture', 'Access from the lock screen'),
      (Color(0xFF0A4A2E), OwnKeepColors.success, Icons.check_rounded, 'No recent activity', 'Hidden files do not appear elsewhere'),
      (Color(0xFF7A3D0A), Color(0xFFF59E0B), Icons.crop_square_rounded, 'Local-only storage', 'Never uploaded or synchronized'),
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
          Text('Hidden Vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Keep sensitive items out of sight', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.north_east_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: Padding(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Hero circle
                Center(
                  child: Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF7C3AED), width: 2),
                      color: const Color(0xFF1A0A3D),
                    ),
                    child: Center(
                      child: Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF7C3AED),
                        ),
                        child: Center(
                          child: Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1A0A3D)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                const Center(child: Text('Hidden Vault Disabled', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Hidden Vault is concealed from the main app and\nopens only with a separate gesture and PIN.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, height: 1.6, fontFamily: 'Inter'),
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.xl),
                Text('How it works', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                SizedBox(height: OwnKeepSpacing.sm),
                ...howItWorks.map((h) => Container(
                  margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                  padding: EdgeInsets.all(OwnKeepSpacing.md),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.darkSurfaceElevated,
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                    border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                  ),
                  child: Row(children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: h.$1, borderRadius: BorderRadius.circular(9)),
                      child: Icon(h.$3, color: h.$2, size: 18),
                    ),
                    SizedBox(width: OwnKeepSpacing.md),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(h.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      Text(h.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                    ])),
                    Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                  ]),
                )),
              ]),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Set Up Hidden Vault', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
          SizedBox(height: 8),
          Text('You can remove the hidden vault at any time', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 11, fontFamily: 'Inter')),
        ]),
      ),
    );
  }
}

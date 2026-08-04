import 'package:flutter/material.dart';
import '../components/ownkeep_ui_kit.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Recent',
      showBottomNav: true,
      body: ListView(
        padding: const EdgeInsets.all(OwnKeepSpacing.base),
        children: [
          Container(
            padding: const EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.dashboard_customize_rounded, color: OwnKeepColors.primary, size: 64),
                const SizedBox(height: OwnKeepSpacing.md),
                const Text(
                  'Recent',
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                const Text(
                  'Content for Recent will appear here soon.',
                  style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.lg),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OwnKeepColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
                  ),
                  child: const Text('Refresh Data', style: TextStyle(fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

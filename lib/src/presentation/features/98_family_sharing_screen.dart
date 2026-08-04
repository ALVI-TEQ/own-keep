import 'package:flutter/material.dart';
import '../components/ownkeep_components.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

class FamilySharingScreen extends StatelessWidget {
  const FamilySharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepAppScaffold(
      title: 'Family Sharing',
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
              children: [
                const Icon(Icons.settings_suggest_rounded, color: OwnKeepColors.primary, size: 48),
                const SizedBox(height: OwnKeepSpacing.md),
                const Text(
                  'Family Sharing Features',
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                const Text(
                  'Configure settings and preferences for Family Sharing.',
                  style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.xl),
                _buildMockOption('Option 1', Icons.tune),
                const Divider(color: OwnKeepColors.darkBorder, height: 1),
                _buildMockOption('Option 2', Icons.settings_suggest),
                const Divider(color: OwnKeepColors.darkBorder, height: 1),
                _buildMockOption('Advanced Configuration', Icons.miscellaneous_services),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockOption(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: OwnKeepSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: OwnKeepColors.darkTextMuted, size: 24),
          const SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Text(label, style: const TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontFamily: 'Inter')),
          ),
          const Icon(Icons.chevron_right, color: OwnKeepColors.darkTextMuted, size: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../components/ownkeep_components.dart';
import 'package:go_router/go_router.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepAppScaffold(
      title: 'Profile',
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
                const Icon(Icons.account_circle, color: OwnKeepColors.primary, size: 64),
                const SizedBox(height: OwnKeepSpacing.md),
                const Text(
                  'My Vault Profile',
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.xl),
                _buildOption(context, 'Settings & Preferences', Icons.settings_outlined, '/features/settings-advanced'),
                const Divider(color: OwnKeepColors.darkBorder, height: 1),
                _buildOption(context, 'Security & App Lock', Icons.security_outlined, '/lock'),
                const Divider(color: OwnKeepColors.darkBorder, height: 1),
                _buildOption(context, 'Help & Support', Icons.help_outline, '/features/help-support'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label, IconData icon, String route) {
    return InkWell(
      onTap: () => context.push(route),
      child: Padding(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../components/ownkeep_components.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepAppScaffold(
      title: 'Invite Members',
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
                const Icon(Icons.star_outline_rounded, color: OwnKeepColors.primary, size: 64),
                const SizedBox(height: OwnKeepSpacing.md),
                const Text(
                  'Invite Members',
                  style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
                const Text(
                  'This page is part of the Invite Members flow.',
                  style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.lg),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OwnKeepColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
                  ),
                  child: const Text('Go Back', style: TextStyle(fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

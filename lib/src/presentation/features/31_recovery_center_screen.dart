import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RecoveryCenterScreen extends StatelessWidget {
  const RecoveryCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Recovery Center',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.verified_outlined, color: OwnKeepColors.success)),
      ],
      body: ListView(
        children: [
          // Hero banner
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [OwnKeepColors.ai.withValues(alpha: 0.2), OwnKeepColors.primary.withValues(alpha: 0.12)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: OwnKeepColors.ai.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  ),
                  child: Icon(Icons.vpn_key_rounded, color: OwnKeepColors.ai, size: 28),
                ),
                SizedBox(width: OwnKeepSpacing.base),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Recovery Phrase', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('is your ultimate access', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Status card
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recovery Phrase Status', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                      SizedBox(height: 4),
                      Text('Verified', style: TextStyle(color: OwnKeepColors.success, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                      SizedBox(height: 2),
                      Text('Last verified: 12 May 2025, 10:30 AM', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                    ],
                  ),
                ),
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: OwnKeepColors.success.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.verified_rounded, color: OwnKeepColors.success, size: 24),
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // Actions
          OwnKeepListTile(
            title: 'View Recovery Phrase',
            subtitle: 'View your 24-word recovery phrase',
            icon: Icons.visibility_outlined,
            iconColor: OwnKeepColors.primary,
            trailing: Icon(Icons.visibility_outlined, color: OwnKeepColors.darkTextMuted, size: 20),
            showChevron: false,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Verify Recovery Phrase',
            subtitle: 'Re-verify to make sure it\'s safe',
            icon: Icons.check_circle_outline,
            iconColor: OwnKeepColors.success,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Recovery Instructions',
            subtitle: 'Step-by-step guide to recover vault',
            icon: Icons.menu_book_outlined,
            iconColor: OwnKeepColors.ai,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Emergency Access',
            subtitle: 'Access your vault in critical situations',
            icon: Icons.warning_amber_rounded,
            iconColor: OwnKeepColors.danger,
            onTap: () {},
          ),
          const OwnKeepTipCard(
            text: 'Tip: Store your recovery phrase offline in a safe place. Never share it with anyone.',
          ),
        ],
      ),
    );
  }
}

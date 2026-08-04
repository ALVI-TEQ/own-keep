import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class VaultInfoScreen extends StatelessWidget {
  const VaultInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Vault Information',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.ios_share_outlined, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          SizedBox(height: OwnKeepSpacing.lg),
          // Vault shield icon
          Center(
            child: Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [OwnKeepColors.ai.withValues(alpha: 0.3), OwnKeepColors.primary.withValues(alpha: 0.2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
                border: Border.all(color: OwnKeepColors.ai.withValues(alpha: 0.3)),
              ),
              child: Icon(Icons.lock_rounded, color: OwnKeepColors.ai, size: 48),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          // Vault name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My First Vault', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(width: 8),
              Icon(Icons.edit_outlined, color: OwnKeepColors.darkTextMuted, size: 18),
            ],
          ),
          const Center(
            child: Text('Created on 12 May 2025', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Info table
          Container(
            margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                _VaultInfoRow(label: 'Vault ID', value: 'VK-7F3A-9D2B'),
                _divider(),
                _VaultInfoRow(label: 'Version', value: '1.0.0'),
                _divider(),
                _VaultInfoRow(label: 'Encryption', value: 'AES-256-GCM'),
                _divider(),
                _VaultInfoRow(label: 'Key Derivation', value: 'Argon2id'),
                _divider(),
                _VaultInfoRow(label: 'Created On', value: '12 May 2025, 10:20 AM'),
                _divider(),
                _VaultInfoRow(label: 'Last Modified', value: '15 May 2025, 09:15 AM'),
                _divider(),
                _VaultInfoRow(label: 'Total Items', value: '248 items'),
                _divider(),
                _VaultInfoRow(label: 'Total Size', value: '128 GB'),
                _divider(),
                _VaultInfoRow(
                  label: 'Backup',
                  value: 'Not Created',
                  valueColor: OwnKeepColors.danger,
                  valueIcon: Icons.warning_amber_rounded,
                ),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Export button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: OwnKeepColors.primary,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
              ),
              child: Text('Export Vault Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.3), indent: OwnKeepSpacing.base, endIndent: OwnKeepSpacing.base);
  }
}

class _VaultInfoRow extends StatelessWidget {
  const _VaultInfoRow({required this.label, required this.value, this.valueColor, this.valueIcon});
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? valueIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
          Row(
            children: [
              if (valueIcon != null) ...[
                Icon(valueIcon, color: valueColor ?? OwnKeepColors.darkTextPrimary, size: 16),
                SizedBox(width: 4),
              ],
              Text(value, style: TextStyle(color: valueColor ?? OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }
}

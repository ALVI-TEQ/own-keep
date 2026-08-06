import 'package:flutter/material.dart';
import '../components/ownkeep_components.dart';
import '../components/ownkeep_ui_kit.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';
import '../../citizen_vault/backup/backup_archive_transfer.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  bool _isBackingUp = false;
  bool _isRestoring = false;
  String? _lastBackupTime;

  Future<void> _performBackup() async {
    final handle = ref.read(vaultSessionProvider).value;
    if (handle == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vault is locked. Cannot backup.')));
      return;
    }
    setState(() => _isBackingUp = true);
    
    try {
      final passphrase = "mango desert trust polar kitten guitar planet purple silver eagle bridge fitness";
      final pending = await handle.createBackup(recoveryPassphrase: passphrase);
      
      final transfer = const PlatformBackupArchiveTransfer();
      final saved = await transfer.exportArchive(pending.archive);
      
      if (mounted) {
        setState(() {
          _isBackingUp = false;
          if (saved) {
            final now = DateTime.now();
            _lastBackupTime = '${_pad(now.month)}/${_pad(now.day)}/${now.year} ${_pad(now.hour)}:${_pad(now.minute)}';
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup exported successfully!')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup export cancelled.')));
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isBackingUp = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Backup failed: $e')));
      }
    }
  }
  
  String _pad(int n) => n.toString().padLeft(2, '0');

  Future<void> _performRestore() async {
    setState(() => _isRestoring = true);
    try {
      final transfer = const PlatformBackupArchiveTransfer();
      final selected = await transfer.pickArchive();
      
      if (selected == null) {
        if (mounted) {
          setState(() => _isRestoring = false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Restore cancelled.')));
        }
        return;
      }
      
      final lifecycle = ref.read(vaultLifecycleProvider);
      final passphrase = "mango desert trust polar kitten guitar planet purple silver eagle bridge fitness";
      
      await lifecycle.restoreBackup(archive: selected.file, recoveryPassphrase: passphrase);
      
      if (mounted) {
        setState(() => _isRestoring = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data restored successfully!')));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRestoring = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Restore failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OwnKeepAppScaffold(
      title: 'Backup & Restore',
      body: ListView(
        padding: const EdgeInsets.all(OwnKeepSpacing.base),
        children: [
          _buildCard(
            title: 'Create Backup',
            description: 'Save a secure encrypted copy of your vault.',
            buttonText: _isBackingUp ? 'Backing up...' : 'Backup Now',
            icon: Icons.backup_outlined,
            isLoading: _isBackingUp,
            onTap: _isBackingUp || _isRestoring ? null : _performBackup,
            statusText: _lastBackupTime != null ? 'Last backup: $_lastBackupTime' : 'No recent backup',
          ),
          const SizedBox(height: OwnKeepSpacing.md),
          _buildCard(
            title: 'Restore Data',
            description: 'Recover your vault from an existing backup file.',
            buttonText: _isRestoring ? 'Restoring...' : 'Restore',
            icon: Icons.restore_outlined,
            isLoading: _isRestoring,
            onTap: _isBackingUp || _isRestoring ? null : _performRestore,
            isDestructive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required bool isLoading,
    required VoidCallback? onTap,
    String? statusText,
    bool isDestructive = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              OwnKeepIconBadge(
                icon: icon,
                color: isDestructive ? OwnKeepColors.danger : OwnKeepColors.primary,
                size: 40,
                iconSize: 20,
              ),
              const SizedBox(width: OwnKeepSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                    const SizedBox(height: 4),
                    Text(description, style: const TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontFamily: 'Inter')),
                  ],
                ),
              ),
            ],
          ),
          if (statusText != null) ...[
            const SizedBox(height: OwnKeepSpacing.md),
            Text(statusText, style: const TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
          ],
          const SizedBox(height: OwnKeepSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive ? OwnKeepColors.danger : OwnKeepColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
              ),
              child: isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(buttonText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ),
        ],
      ),
    );
  }
}

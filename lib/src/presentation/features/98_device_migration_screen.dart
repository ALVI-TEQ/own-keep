import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';
import '../../citizen_vault/backup/backup_archive_transfer.dart';

class DeviceMigrationScreen extends ConsumerStatefulWidget {
  const DeviceMigrationScreen({super.key});

  @override
  ConsumerState<DeviceMigrationScreen> createState() =>
      _DeviceMigrationScreenState();
}

class _DeviceMigrationScreenState extends ConsumerState<DeviceMigrationScreen> {
  int _selectedMethod = 1; // File export is the implemented transport.
  bool _isExporting = false;

  Future<String?> _requestRecoveryPhrase() async {
    final phrase = TextEditingController();
    final confirmation = TextEditingController();
    String? error;
    final value = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Protect migration archive'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter and confirm the recovery phrase for this encrypted export.',
              ),
              TextField(
                controller: phrase,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(labelText: 'Recovery phrase'),
              ),
              TextField(
                controller: confirmation,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(labelText: 'Confirm phrase'),
              ),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final entered = phrase.text.trim();
                if (entered.isEmpty || entered != confirmation.text.trim()) {
                  setDialogState(
                    () => error = entered.isEmpty
                        ? 'Enter your recovery phrase.'
                        : 'Recovery phrases do not match.',
                  );
                  return;
                }
                Navigator.pop(dialogContext, entered);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
    phrase.dispose();
    confirmation.dispose();
    return value;
  }

  Future<void> _performFileExport() async {
    final handle = ref.read(vaultSessionProvider).value;
    if (handle == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vault is locked.')));
      return;
    }
    final passphrase = await _requestRecoveryPhrase();
    if (passphrase == null || !mounted) return;
    setState(() => _isExporting = true);

    try {
      final pending = await handle.createBackup(recoveryPassphrase: passphrase);
      final transfer = const PlatformBackupArchiveTransfer();
      final saved = await transfer.exportArchive(pending.archive);
      pending.dispose();

      if (mounted) {
        setState(() => _isExporting = false);
        if (saved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Migration file exported successfully!'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isExporting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final checklist = [
      {'title': l10n.s98_backup, 'done': true},
      {'title': l10n.s98_charge, 'done': true},
      {'title': l10n.s98_storage, 'done': true},
      {'title': l10n.s98_keep_old, 'done': false},
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              l10n.s98_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.s98_subtitle,
              style: TextStyle(color: colors.textMuted, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.primaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.device_sync,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.s98_secure,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s98_secure_body,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Text(
                l10n.s98_choose,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildMethodCard(
                l10n.s98_nearby,
                l10n.s98_nearby_body,
                OwnKeepMainIcons.device_sync,
                0,
                colors,
              ),
              _buildMethodCard(
                l10n.s98_file,
                l10n.s98_file_body,
                OwnKeepMainIcons.folder_export,
                1,
                colors,
              ),

              const SizedBox(height: 32),

              Text(
                l10n.s98_checklist,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              ...checklist.map(
                (item) => _buildChecklistItem(
                  item['title'] as String,
                  item['done'] as bool,
                  colors,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isExporting || _selectedMethod == 0
                  ? null
                  : _performFileExport,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isExporting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      _selectedMethod == 0
                          ? 'Nearby transfer unavailable'
                          : l10n.s98_start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard(
    String title,
    String body,
    String iconPath,
    int index,
    OwnKeepMainColorsTheme colors,
  ) {
    bool isSelected = _selectedMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryBlue.withValues(alpha: 0.1)
              : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  colors.primaryBlue,
                  BlendMode.srcIn,
                ),
                width: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.primaryBlue : colors.textSecondary,
                  width: 2,
                ),
                color: isSelected ? colors.primaryBlue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(
    String title,
    bool done,
    OwnKeepMainColorsTheme colors,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? colors.successGreen : colors.textMuted,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: done ? colors.textPrimary : colors.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

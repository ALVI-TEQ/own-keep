import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';
import '../../citizen_vault/backup/backup_archive_transfer.dart';
import '../components/recovery_credential_dialog.dart';
import '../components/new_pin_dialog.dart';

class RestoreVaultScreen extends ConsumerStatefulWidget {
  const RestoreVaultScreen({super.key});

  @override
  ConsumerState<RestoreVaultScreen> createState() => _RestoreVaultScreenState();
}

class _RestoreVaultScreenState extends ConsumerState<RestoreVaultScreen> {
  int _restoreOption = 0; // 0=Everything, 1=Docs only, 2=Choose
  SelectedBackupArchive? _selectedArchive;
  bool _isRestoring = false;

  Future<String?> _requestRecoveryPhrase() async {
    return showRecoveryCredentialDialog(context, title: 'Unlock backup');
  }

  Future<void> _pickArchive() async {
    final transfer = const PlatformBackupArchiveTransfer();
    final selected = await transfer.pickArchive();
    if (selected != null && mounted) {
      setState(() => _selectedArchive = selected);
    }
  }

  Future<void> _performRestore() async {
    if (_selectedArchive == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a backup file first.')),
      );
      return;
    }

    if (_restoreOption != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selective restore is not supported by this archive format. Choose Everything.',
          ),
        ),
      );
      return;
    }
    final passphrase = await _requestRecoveryPhrase();
    if (passphrase == null || !mounted) return;
    final newPin = await showNewPinDialog(
      context,
      title: 'Set PIN for restored vault',
    );
    if (newPin == null || !mounted) return;
    setState(() => _isRestoring = true);

    try {
      await ref
          .read(vaultSessionProvider.notifier)
          .restoreVault(_selectedArchive!.file, passphrase);
      await ref
          .read(pinCredentialStoreProvider)
          .enroll(pin: newPin, recoveryCredential: passphrase);

      if (mounted) {
        setState(() => _isRestoring = false);
        context.go('/dashboard/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRestoring = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Restore failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final selected = _selectedArchive != null;
    final validations = [
      {
        'title': l10n.s99_integrity,
        'value': selected ? 'Verified during restore' : 'Not checked',
        'ok': false,
      },
      {
        'title': l10n.s99_envelope,
        'value': selected ? 'Authenticated during restore' : 'Not checked',
        'ok': false,
      },
      {
        'title': l10n.s99_storage,
        'value': selected ? 'Checked during restore' : 'Not checked',
        'ok': false,
      },
      {
        'title': l10n.s99_version,
        'value': selected ? 'Checked during restore' : 'Not checked',
        'ok': false,
      },
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
              l10n.s99_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.s99_subtitle,
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
              // Selected File Banner
              Text(
                l10n.s99_backup_file,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
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
                        OwnKeepMainIcons.database,
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
                            _selectedArchive?.displayName ?? l10n.s99_file,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedArchive != null
                                ? 'Ready to restore'
                                : l10n.s99_file_meta,
                            style: TextStyle(
                              color: _selectedArchive != null
                                  ? colors.primaryBlue
                                  : colors.successGreen,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _isRestoring ? null : _pickArchive,
                      child: Text(
                        l10n.s99_change,
                        style: TextStyle(
                          color: colors.primaryBlue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Restore Options
              Text(
                l10n.s99_options,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildRadioOption(
                l10n.s99_everything,
                l10n.s99_everything_body,
                0,
                colors,
              ),
              _buildRadioOption(
                l10n.s99_documents,
                l10n.s99_documents_body,
                1,
                colors,
              ),
              _buildRadioOption(
                l10n.s99_collections,
                l10n.s99_collections_body,
                2,
                colors,
              ),

              const SizedBox(height: 32),

              // Verification
              Text(
                l10n.s99_verification,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Column(
                  children: validations
                      .map((v) => _buildValidationRow(v, colors))
                      .toList(),
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
              onPressed: _isRestoring ? null : _performRestore,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isRestoring
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.s99_restore,
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

  Widget _buildRadioOption(
    String title,
    String body,
    int index,
    OwnKeepMainColorsTheme colors,
  ) {
    bool isSelected = _restoreOption == index;
    return GestureDetector(
      onTap: () => setState(() => _restoreOption = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryBlue.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colors.primaryBlue.withValues(alpha: 0.5)
                : Colors.transparent,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? colors.primaryBlue : colors.textMuted,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      body,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationRow(
    Map<String, dynamic> v,
    OwnKeepMainColorsTheme colors,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              v['title'] as String,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    v['value'] as String,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (v['ok'] == true)
                  Icon(
                    Icons.check_circle,
                    color: colors.successGreen,
                    size: 16,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

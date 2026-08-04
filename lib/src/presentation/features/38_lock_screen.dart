import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:citizen_vault_app/src/vault/vault_lifecycle.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../../providers/vault_provider.dart';

/// Screen 38 — Lock Screen
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  bool _isUnlocking = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Prompt biometric unlock shortly after the screen renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _unlock();
    });
  }

  Future<void> _unlock() async {
    if (_isUnlocking) return;
    setState(() {
      _isUnlocking = true;
      _errorMessage = null;
    });
    
    try {
      final vaultLifecycle = ref.read(vaultLifecycleProvider);
      final unlockedVault = await vaultLifecycle.unlockWithBiometrics();
      if (!mounted) return;
      ref.read(unlockedVaultProvider.notifier).state = unlockedVault;
      context.go('/dashboard/home');
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e is VaultLifecycleFailure && e.code == 'biometric_cancelled' 
              ? 'Unlock cancelled' 
              : 'Failed to unlock';
        });
      }
    } finally {
      if (mounted) setState(() => _isUnlocking = false);
    }
  }

  void _showRecoveryUnlockDialog(BuildContext context) {
    final textController = TextEditingController();
    bool isUnlockingRecovery = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF14243B),
              title: Text('Unlock with Recovery Phrase', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Inter')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter your 12-word recovery phrase separated by spaces.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 16),
                  TextField(
                    controller: textController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'e.g. apple breeze canvas...',
                      hintStyle: TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF0A1628),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isUnlockingRecovery ? null : () => Navigator.of(dialogContext).pop(),
                  child: Text('Cancel', style: TextStyle(color: Colors.white60)),
                ),
                TextButton(
                  onPressed: isUnlockingRecovery ? null : () async {
                    setDialogState(() => isUnlockingRecovery = true);
                    try {
                      final vaultLifecycle = ref.read(vaultLifecycleProvider);
                      final handle = await vaultLifecycle.unlock(recoveryPassphrase: textController.text.trim());
                      if (!mounted) return;
                      ref.read(unlockedVaultProvider.notifier).state = handle;
                      Navigator.of(dialogContext).pop();
                      this.context.go('/dashboard/home');
                    } catch (e) {
                      setDialogState(() => isUnlockingRecovery = false);
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(content: Text('Invalid recovery phrase')),
                      );
                    }
                  },
                  child: isUnlockingRecovery 
                    ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: OwnKeepColors.primary))
                    : Text('Unlock', style: TextStyle(color: OwnKeepColors.primary)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
          children: [
            const Spacer(flex: 2),
            // Lock icon
            Icon(Icons.lock_outlined, color: Colors.white, size: 48),
            SizedBox(height: OwnKeepSpacing.md),
            Text('OwnKeep', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('Vault is locked', style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Inter')),
            if (_errorMessage != null) ...[
              SizedBox(height: OwnKeepSpacing.md),
              Text(_errorMessage!, style: TextStyle(color: OwnKeepColors.danger, fontSize: 14)),
            ],
            const Spacer(),
            if (_isUnlocking)
              const CircularProgressIndicator(color: OwnKeepColors.primary)
            else
              // Biometric button
              GestureDetector(
                onTap: _unlock,
                child: Column(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: OwnKeepColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                        border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.4)),
                      ),
                      child: Icon(Icons.fingerprint, color: OwnKeepColors.primary, size: 32),
                    ),
                    SizedBox(height: 8),
                    Text('Tap to Unlock', style: TextStyle(color: Colors.white60, fontSize: 13, fontFamily: 'Inter')),
                  ],
                ),
              ),
            SizedBox(height: OwnKeepSpacing.lg),
            TextButton(
              onPressed: () => _showRecoveryUnlockDialog(context),
              child: Text('Use Recovery Phrase', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontFamily: 'Inter')),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    ));
  }
}

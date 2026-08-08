import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../components/recovery_credential_dialog.dart';

class RecoveryVerificationScreen extends ConsumerStatefulWidget {
  const RecoveryVerificationScreen({super.key});

  @override
  ConsumerState<RecoveryVerificationScreen> createState() =>
      _RecoveryVerificationScreenState();
}

class _RecoveryVerificationScreenState
    extends ConsumerState<RecoveryVerificationScreen> {
  bool _checking = false;
  String? _error;

  Future<void> _verify() async {
    final phrase = await showRecoveryCredentialDialog(
      context,
      title: 'Verify recovery credential',
    );
    if (phrase == null || !mounted) return;
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      await ref.read(vaultLifecycleProvider).unlock(recoveryPassphrase: phrase);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recovery credential verified locally.')),
      );
      context.pop();
    } catch (_) {
      if (mounted) {
        setState(
          () =>
              _error = 'That recovery credential is not valid for this vault.',
        );
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Verify recovery credential'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text('Local cryptographic check'),
              subtitle: Text(
                'Your phrase is authenticated against the local vault and is never displayed or stored by this screen.',
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_error != null)
            Text(_error!, style: TextStyle(color: colors.dangerRed)),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _checking ? null : _verify,
            icon: _checking
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.verified_user),
            label: const Text('Verify locally'),
          ),
        ],
      ),
    );
  }
}

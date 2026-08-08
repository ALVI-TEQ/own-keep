import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class RecoveryVerificationScreen extends ConsumerStatefulWidget {
  const RecoveryVerificationScreen({super.key});

  @override
  ConsumerState<RecoveryVerificationScreen> createState() =>
      _RecoveryVerificationScreenState();
}

class _RecoveryVerificationScreenState
    extends ConsumerState<RecoveryVerificationScreen> {
  final _phrase = TextEditingController();
  bool _obscure = true;
  bool _checking = false;
  String? _error;

  @override
  void dispose() {
    _phrase.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    final phrase = _phrase.text.trim();
    if (phrase.isEmpty) {
      setState(() => _error = 'Enter your recovery phrase.');
      return;
    }
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      await ref.read(vaultLifecycleProvider).unlock(recoveryPassphrase: phrase);
      if (!mounted) return;
      _phrase.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recovery phrase verified locally.')),
      );
      context.pop();
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = 'The recovery phrase is not valid for this vault.',
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
        title: const Text('Verify recovery phrase'),
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
          TextField(
            controller: _phrase,
            obscureText: _obscure,
            autocorrect: false,
            enableSuggestions: false,
            minLines: 1,
            maxLines: _obscure ? 1 : 4,
            decoration: InputDecoration(
              labelText: 'Recovery phrase',
              errorText: _error,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            onSubmitted: (_) => _checking ? null : _verify(),
          ),
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

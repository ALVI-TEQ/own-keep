import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_platform/vault_platform.dart';

import '../../domain/recovery/recovery_method.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';

class RecoveryPhraseScreen extends ConsumerStatefulWidget {
  const RecoveryPhraseScreen({super.key});

  @override
  ConsumerState<RecoveryPhraseScreen> createState() =>
      _RecoveryPhraseScreenState();
}

class _RecoveryPhraseScreenState extends ConsumerState<RecoveryPhraseScreen> {
  final _passphrase = TextEditingController();
  final _confirmation = TextEditingController();
  String? _generatedPhrase;
  String? _error;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _generatePhrase();
  }

  @override
  void dispose() {
    _passphrase.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  Future<void> _generatePhrase() async {
    setState(() {
      _generatedPhrase = null;
      _error = null;
    });
    try {
      final phrase = await const RecoveryPhraseGenerator(
        PlatformCryptographicRandom(),
      ).generate();
      if (mounted) setState(() => _generatedPhrase = phrase);
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Could not securely generate a phrase.');
      }
    }
  }

  void _continue() {
    final method = ref.read(onboardingRecoveryMethodProvider);
    final String credential;
    if (method == RecoveryMethod.generatedPhrase) {
      final phrase = _generatedPhrase;
      if (phrase == null) return;
      credential = phrase;
    } else {
      credential = normalizeRecoveryCredential(
        _passphrase.text,
        RecoveryMethod.customPassphrase,
      );
      final assessment = RecoveryCredentialPolicy.assess(credential);
      if (!assessment.accepted ||
          credential.runes.length < minimumNewCustomRecoveryCharacters) {
        setState(
          () => _error =
              'Use a memorable recovery password with at least 16 characters.',
        );
        return;
      }
      if (credential != _confirmation.text.trim()) {
        setState(() => _error = 'Recovery passwords do not match.');
        return;
      }
    }
    ref.read(onboardingRecoveryCodeProvider.notifier).state = credential;
    context.push('/verify-phrase');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.onboardingColors;
    final method = ref.watch(onboardingRecoveryMethodProvider);
    final words = recoveryWords(_generatedPhrase ?? '');
    return Scaffold(
      backgroundColor: colors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: colors.backgroundDeep,
        leading: const BackButton(),
        title: const Text('Choose recovery method'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Protect access to your vault and encrypted backups.',
            style: TextStyle(color: colors.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 24),
          SegmentedButton<RecoveryMethod>(
            segments: const [
              ButtonSegment(
                value: RecoveryMethod.generatedPhrase,
                icon: Icon(Icons.auto_awesome),
                label: Text('12 words'),
              ),
              ButtonSegment(
                value: RecoveryMethod.customPassphrase,
                icon: Icon(Icons.password),
                label: Text('My password'),
              ),
            ],
            selected: {method},
            onSelectionChanged: (selection) {
              ref
                  .read(onboardingRecoveryMethodProvider.notifier)
                  .select(selection.single);
              setState(() => _error = null);
            },
          ),
          const SizedBox(height: 24),
          if (method == RecoveryMethod.generatedPhrase) ...[
            const Text(
              'Recommended',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Write these words down in order. OwnKeep cannot recover them.',
              style: TextStyle(color: colors.textSecondary),
            ),
            const SizedBox(height: 20),
            if (_generatedPhrase == null && _error == null)
              const Center(child: CircularProgressIndicator())
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var index = 0; index < words.length; index++)
                    Chip(label: Text('${index + 1}. ${words[index]}')),
                ],
              ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: _generatePhrase,
              icon: const Icon(Icons.refresh),
              label: const Text('Generate another phrase'),
            ),
          ] else ...[
            Text(
              'Use at least 16 characters. A memorable multi-word password is best.',
              style: TextStyle(color: colors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passphrase,
              obscureText: _obscure,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: 'Recovery password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmation,
              obscureText: _obscure,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                labelText: 'Confirm recovery password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!, style: TextStyle(color: colors.foreverRed)),
          ],
          const SizedBox(height: 32),
          FilledButton(
            onPressed: method == RecoveryMethod.generatedPhrase
                ? (_generatedPhrase == null ? null : _continue)
                : _continue,
            child: Text(
              method == RecoveryMethod.generatedPhrase
                  ? 'Verify word order'
                  : 'Create with this password',
            ),
          ),
        ],
      ),
    );
  }
}

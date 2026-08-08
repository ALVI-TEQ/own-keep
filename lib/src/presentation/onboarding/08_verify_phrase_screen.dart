import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../citizen_vault/vault/vault_lifecycle.dart';
import '../../domain/recovery/recovery_method.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';

class VerifyPhraseScreen extends ConsumerStatefulWidget {
  const VerifyPhraseScreen({super.key});

  @override
  ConsumerState<VerifyPhraseScreen> createState() => _VerifyPhraseScreenState();
}

class _VerifyPhraseScreenState extends ConsumerState<VerifyPhraseScreen> {
  List<String> _originalWords = const [];
  List<String> _shuffledWords = const [];
  final _selectedWords = <String>[];
  final _selectedIndices = <int>[];
  bool _isCreating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (ref.read(onboardingRecoveryMethodProvider) ==
        RecoveryMethod.generatedPhrase) {
      _originalWords = recoveryWords(
        ref.read(onboardingRecoveryCodeProvider) ?? '',
      );
      _shuffledWords = List<String>.of(_originalWords)..shuffle();
    }
  }

  void _selectWord(int index, String word) {
    setState(() {
      _error = null;
      final position = _selectedIndices.indexOf(index);
      if (position >= 0) {
        _selectedIndices.removeAt(position);
        _selectedWords.removeAt(position);
      } else {
        _selectedIndices.add(index);
        _selectedWords.add(word);
      }
    });
  }

  Future<void> _continue() async {
    if (_isCreating) return;
    final credential = ref.read(onboardingRecoveryCodeProvider);
    final pin = ref.read(onboardingPinProvider);
    final method = ref.read(onboardingRecoveryMethodProvider);
    if (credential == null || pin == null) {
      setState(() => _error = 'Setup session expired. Set your PIN again.');
      return;
    }
    if (method == RecoveryMethod.generatedPhrase &&
        !_orderedWordsMatch(_originalWords, _selectedWords)) {
      setState(() {
        _error = _selectedWords.length == _originalWords.length
            ? 'The word order is incorrect. Try again.'
            : 'Select all 12 words in the original order.';
        _selectedWords.clear();
        _selectedIndices.clear();
      });
      return;
    }

    setState(() {
      _isCreating = true;
      _error = null;
    });
    try {
      await ref
          .read(vaultSessionProvider.notifier)
          .createVault(credential, pin: pin);
      if (mounted) context.push('/enable-biometrics');
    } on VaultLifecycleFailure catch (failure) {
      if (mounted) {
        setState(() {
          _error = failure.code == 'vault_already_exists'
              ? 'A vault already exists on this device.'
              : 'Vault creation failed: ${failure.code}';
          _isCreating = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'Vault creation could not be completed.';
          _isCreating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.onboardingColors;
    final method = ref.watch(onboardingRecoveryMethodProvider);
    return Scaffold(
      backgroundColor: colors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: colors.backgroundDeep,
        leading: const BackButton(),
        title: Text(
          method == RecoveryMethod.generatedPhrase
              ? 'Verify word order'
              : 'Confirm recovery method',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (method == RecoveryMethod.generatedPhrase) ...[
            Text(
              'Tap the words in the same order you wrote them down.',
              style: TextStyle(color: colors.textSecondary),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var index = 0; index < _originalWords.length; index++)
                    Chip(
                      label: Text(
                        index < _selectedWords.length
                            ? _selectedWords[index]
                            : '${index + 1}',
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var index = 0; index < _shuffledWords.length; index++)
                  FilterChip(
                    selected: _selectedIndices.contains(index),
                    label: Text(_shuffledWords[index]),
                    onSelected: (_) =>
                        _selectWord(index, _shuffledWords[index]),
                  ),
              ],
            ),
          ] else ...[
            const Icon(Icons.password, size: 72),
            const SizedBox(height: 20),
            const Text(
              'Your custom recovery password has been confirmed. Keep it separate from your six-digit PIN.',
              textAlign: TextAlign.center,
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 20),
            Text(_error!, style: TextStyle(color: colors.foreverRed)),
          ],
          const SizedBox(height: 32),
          FilledButton(
            onPressed: _isCreating ? null : _continue,
            child: _isCreating
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create encrypted vault'),
          ),
        ],
      ),
    );
  }
}

bool _orderedWordsMatch(List<String> expected, List<String> selected) {
  if (expected.length != 12 || selected.length != expected.length) return false;
  for (var index = 0; index < expected.length; index++) {
    if (expected[index] != selected[index]) return false;
  }
  return true;
}

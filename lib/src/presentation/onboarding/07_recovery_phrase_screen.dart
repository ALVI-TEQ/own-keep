import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'dart:math';
import '../components/ownkeep_onboarding_components.dart';
import '../../providers/vault_provider.dart';

// Temporary mock BIP39 wordlist for UI implementation purposes
const _mockWordList = [
  'apple', 'breeze', 'canvas', 'drift', 'echo', 'flame', 'globe', 'hover',
  'ignite', 'jump', 'karma', 'lunar', 'maze', 'nova', 'orbit', 'pulse',
  'quartz', 'river', 'solar', 'tide', 'umbra', 'vortex', 'wave', 'zenith'
];

class RecoveryPhraseScreen extends ConsumerStatefulWidget {
  const RecoveryPhraseScreen({super.key});

  @override
  ConsumerState<RecoveryPhraseScreen> createState() => _RecoveryPhraseScreenState();
}

class _RecoveryPhraseScreenState extends ConsumerState<RecoveryPhraseScreen> {
  List<String> _words = [];

  @override
  void initState() {
    super.initState();
    _generateWords();
  }

  void _generateWords() {
    // Generate exactly 12 words to match the premium mockup requirements
    final random = Random.secure();
    final words = List.generate(12, (_) => _mockWordList[random.nextInt(_mockWordList.length)]);
    setState(() {
      _words = words;
    });
    // Store it joined with spaces for verification in the next screen
    // Must be delayed to avoid modifying provider during widget build
    Future.microtask(() {
      if (mounted) {
        ref.read(onboardingRecoveryCodeProvider.notifier).state = words.join(' ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OwnKeepOnboardingScaffold(
      showBackButton: true,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.enter): () {
            if (_words.isNotEmpty) context.push('/verify-phrase');
          },
          const SingleActivator(LogicalKeyboardKey.numpadEnter): () {
            if (_words.isNotEmpty) context.push('/verify-phrase');
          },
        },
        child: Focus(
          autofocus: true,
          child: Column(
        children: [
          SizedBox(height: 32),
          OwnKeepOnboardingHeader(
            title: l10n.recoveryPhraseTitle,
            subtitle: l10n.recoveryPhraseDesc,
          ),
          SizedBox(height: 16),
          const OwnKeepSecurityWarning(
            text: 'Do not take a screenshot. Write these words down on paper and keep them in a safe place.',
          ),
          SizedBox(height: 32),
          Expanded(
            child: _words.isNotEmpty 
              ? SingleChildScrollView(
                  child: OwnKeepRecoveryWordGrid(words: _words),
                )
              : const Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: 24),
          OwnKeepGradientButton(
            text: l10n.btnNext,
            onPressed: _words.isNotEmpty ? () => context.push('/verify-phrase') : () {},
          ),
          SizedBox(height: 32),
        ],
      ))),
    );
  }
}

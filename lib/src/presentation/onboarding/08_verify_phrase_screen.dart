import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../../providers/vault_provider.dart';
import '../../theme/app_colors.dart';

class VerifyPhraseScreen extends ConsumerStatefulWidget {
  const VerifyPhraseScreen({super.key});

  @override
  ConsumerState<VerifyPhraseScreen> createState() => _VerifyPhraseScreenState();
}

class _VerifyPhraseScreenState extends ConsumerState<VerifyPhraseScreen> {
  List<String> _originalWords = [];
  List<String> _shuffledWords = [];
  final List<String> _selectedWords = [];
  final Set<int> _selectedIndices = {};
  String? _error;

  @override
  void initState() {
    super.initState();
    // In a real app we'd handle the case where it's null, but for onboarding flow it should be set
    final code = ref.read(onboardingRecoveryCodeProvider) ?? '';
    _originalWords = code.split(' ');
    
    _shuffledWords = List.from(_originalWords)..shuffle();
  }

  void _onWordTap(int index, String word) {
    setState(() {
      _error = null;
      if (_selectedIndices.contains(index)) {
        // Deselect
        _selectedIndices.remove(index);
        _selectedWords.remove(word);
      } else {
        // Select
        _selectedIndices.add(index);
        _selectedWords.add(word);
      }
    });
  }

  void _verify() {
    if (_selectedWords.length != _originalWords.length) {
      setState(() {
        _error = 'Please select all words.';
      });
      return;
    }

    bool isValid = true;
    for (int i = 0; i < _originalWords.length; i++) {
      if (_originalWords[i] != _selectedWords[i]) {
        isValid = false;
        break;
      }
    }

    if (isValid) {
      context.push('/enable-biometrics');
    } else {
      setState(() {
        _error = 'Incorrect order. Please try again.';
        _selectedIndices.clear();
        _selectedWords.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OwnKeepOnboardingScaffold(
      showBackButton: true,
      child: Column(
        children: [
          SizedBox(height: 32),
          OwnKeepOnboardingHeader(
            title: l10n.verifyPhraseTitle,
            subtitle: l10n.verifyPhraseDesc,
          ),
          if (_error != null) ...[
            SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(color: context.appColors.red, fontSize: 14),
            ),
          ],
          SizedBox(height: 32),
          // Show the slots for selected words
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.appColors.bgSecondary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.appColors.borderSubtle),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_originalWords.length, (index) {
                final isFilled = index < _selectedWords.length;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isFilled ? context.appColors.brandPurple : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isFilled ? context.appColors.brandPurple : context.appColors.borderStrong.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    isFilled ? _selectedWords[index] : '${index + 1}',
                    style: TextStyle(
                      color: isFilled ? context.appColors.textPrimary : context.appColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: OwnKeepRecoveryWordGrid(
                words: _shuffledWords,
                selectedIndices: _selectedIndices,
                onWordTap: _onWordTap,
              ),
            ),
          ),
          SizedBox(height: 24),
          OwnKeepGradientButton(
            text: l10n.btnVerify,
            onPressed: _selectedWords.length == _originalWords.length ? _verify : () {},
          ),
          SizedBox(height: 16),
          OwnKeepSecondaryAction(
            text: 'Clear Selection',
            onPressed: () {
              setState(() {
                _selectedIndices.clear();
                _selectedWords.clear();
                _error = null;
              });
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

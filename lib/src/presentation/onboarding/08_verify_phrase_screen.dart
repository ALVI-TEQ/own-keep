import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import 'package:ownkeep/src/citizen_vault/vault/vault_lifecycle.dart';

class VerifyPhraseScreen extends ConsumerStatefulWidget {
  const VerifyPhraseScreen({super.key});

  @override
  ConsumerState<VerifyPhraseScreen> createState() => _VerifyPhraseScreenState();
}

class _VerifyPhraseScreenState extends ConsumerState<VerifyPhraseScreen> {
  List<String> _originalWords = [];
  List<String> _shuffledWords = [];
  final List<String> _selectedWords = [];
  final List<int> _selectedIndices = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    final code = ref.read(onboardingRecoveryCodeProvider) ?? '';
    if (code.isNotEmpty) {
      final symbols = code.replaceAll('-', '');
      var offset = 0;
      _originalWords = List<String>.generate(12, (index) {
        final length = index < 8 ? 3 : 2;
        final part = symbols.substring(offset, offset + length);
        offset += length;
        return part;
      });
    }

    _shuffledWords = List.from(_originalWords)..shuffle();
  }

  void _onWordTap(int index, String word) {
    setState(() {
      _error = null;
      if (_selectedIndices.contains(index)) {
        final selectedPosition = _selectedIndices.indexOf(index);
        _selectedIndices.removeAt(selectedPosition);
        _selectedWords.removeAt(selectedPosition);
      } else {
        // Select
        _selectedIndices.add(index);
        _selectedWords.add(word);
      }
    });
  }

  bool _isCreating = false;

  void _verify() async {
    if (_isCreating) return;

    final recoveryCode = ref.read(onboardingRecoveryCodeProvider);
    final pin = ref.read(onboardingPinProvider);
    if (recoveryCode == null || pin == null || _originalWords.isEmpty) {
      setState(
        () => _error = 'Setup session expired. Please set your PIN again.',
      );
      return;
    }

    if (_selectedWords.length != _originalWords.length) {
      setState(() {
        _error = AppLocalizations.of(context)!.s08_error_incomplete;
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
      setState(() {
        _isCreating = true;
        _error = null;
      });

      try {
        await ref
            .read(vaultSessionProvider.notifier)
            .createVault(recoveryCode, pin: pin);

        if (!mounted) return;
        context.push('/enable-biometrics');
      } on VaultLifecycleFailure catch (e) {
        if (mounted) {
          setState(() {
            if (e.code == 'vault_already_exists') {
              _error = 'Vault already exists on this device.';
            } else {
              _error = 'Failed to create vault: ${e.code}';
            }
            _isCreating = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _error = 'An unexpected error occurred.';
            _isCreating = false;
          });
        }
      }
    } else {
      setState(() {
        _error = AppLocalizations.of(context)!.s08_error_incorrect;
        _selectedIndices.clear();
        _selectedWords.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.onboardingColors.backgroundDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: SvgPicture.asset(
                    OwnKeepOnboardingIcons.back_arrow,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.s08_title,
                  style: TextStyle(
                    color: context.onboardingColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.s08_body,
                  style: TextStyle(
                    color: context.onboardingColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: context.onboardingColors.foreverRed,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // Show the slots for selected words
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.onboardingColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.onboardingColors.borderSubtle,
                    width: 1.5,
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(_originalWords.length, (index) {
                    final isFilled = index < _selectedWords.length;
                    return isFilled
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.onboardingColors.brandBlue
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: context.onboardingColors.brandBlue
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Text(
                              _selectedWords[index],
                              style: TextStyle(
                                color: context.onboardingColors.brandBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.onboardingColors.surfaceChip,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: context.onboardingColors.borderSubtle,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: context.onboardingColors.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: List.generate(_shuffledWords.length, (index) {
                      final word = _shuffledWords[index];
                      final isSelected = _selectedIndices.contains(index);
                      return GestureDetector(
                        onTap: () => _onWordTap(index, word),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.onboardingColors.brandBlue.withValues(
                                    alpha: 0.15,
                                  )
                                : context.onboardingColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? context.onboardingColors.brandBlue
                                  : context.onboardingColors.borderSubtle,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            word,
                            style: TextStyle(
                              color: isSelected
                                  ? context.onboardingColors.brandBlue
                                  : context.onboardingColors.textPrimary,
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed:
                      (_selectedWords.length == _originalWords.length &&
                          !_isCreating)
                      ? _verify
                      : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isCreating
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10n.s08_action_verify,
                          style: TextStyle(
                            color: context.onboardingColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIndices.clear();
                    _selectedWords.clear();
                    _error = null;
                  });
                },
                child: Text(
                  l10n.s08_action_clear,
                  style: TextStyle(
                    color: context.onboardingColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

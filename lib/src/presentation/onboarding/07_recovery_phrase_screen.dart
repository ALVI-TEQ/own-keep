import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_platform/vault_platform.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';

class RecoveryPhraseScreen extends ConsumerStatefulWidget {
  const RecoveryPhraseScreen({super.key});

  @override
  ConsumerState<RecoveryPhraseScreen> createState() =>
      _RecoveryPhraseScreenState();
}

class _RecoveryPhraseScreenState extends ConsumerState<RecoveryPhraseScreen> {
  List<String> _words = [];
  String? _generationError;

  @override
  void initState() {
    super.initState();
    _generateWords();
  }

  Future<void> _generateWords() async {
    try {
      final code = await const RecoveryCodeGenerator(
        PlatformCryptographicRandom(),
      ).generate();
      if (!mounted) return;
      setState(() {
        final symbols = code.replaceAll('-', '');
        var offset = 0;
        _words = List<String>.generate(12, (index) {
          final length = index < 8 ? 3 : 2;
          final part = symbols.substring(offset, offset + length);
          offset += length;
          return part;
        });
        _generationError = null;
      });
      ref.read(onboardingRecoveryCodeProvider.notifier).state = code;
    } on Object {
      if (!mounted) return;
      setState(
        () => _generationError = 'Could not securely generate a recovery code.',
      );
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
                  l10n.s07_title,
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
                  l10n.s07_body,
                  style: TextStyle(
                    color: context.onboardingColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.onboardingColors.warningAmber.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.onboardingColors.warningAmber.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      OwnKeepOnboardingIcons.warning_triangle,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.s07_warning,
                        style: TextStyle(
                          color: context.onboardingColors.warningAmber,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: _generationError != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _generationError!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.onboardingColors.foreverRed,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: _generateWords,
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      )
                    : _words.isNotEmpty
                    ? SingleChildScrollView(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: List.generate(_words.length, (index) {
                            return Container(
                              width: 130, // Fixed width for responsive wrap
                              height: 48, // Fixed height
                              decoration: BoxDecoration(
                                color: context.onboardingColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: context.onboardingColors.borderSubtle,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color:
                                          context.onboardingColors.surfaceChip,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        bottomLeft: Radius.circular(14),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: context
                                              .onboardingColors
                                              .textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        _words[index],
                                        style: TextStyle(
                                          color: context
                                              .onboardingColors
                                              .textPrimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: _words.isNotEmpty
                      ? () => context.push('/verify-phrase')
                      : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.s07_action_next,
                    style: TextStyle(
                      color: context.onboardingColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

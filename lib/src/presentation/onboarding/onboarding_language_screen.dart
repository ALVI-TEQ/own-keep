import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';

class OnboardingLanguageScreen extends ConsumerWidget {
  const OnboardingLanguageScreen({super.key});

  static const _languages = <(String, String)>[
    ('en', 'English'),
    ('hi', 'हिन्दी'),
    ('ta', 'தமிழ்'),
    ('te', 'తెలుగు'),
  ];

  Future<void> _select(WidgetRef ref, String code) async {
    ref.read(appLanguageProvider.notifier).state = code;
    await (await SharedPreferences.getInstance()).setString(
      'ownkeep_ui_language',
      code,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selected = ref.watch(appLanguageProvider);
    final colors = context.onboardingColors;
    return Scaffold(
      backgroundColor: colors.backgroundDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.translate_rounded, color: colors.brandBlue, size: 64),
              const SizedBox(height: 24),
              Text(
                l10n.onboarding_language_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboarding_language_body,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.textSecondary, fontSize: 15),
              ),
              const SizedBox(height: 32),
              RadioGroup<String>(
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) _select(ref, value);
                },
                child: Column(
                  children: _languages
                      .map(
                        (language) => Card(
                          color: colors.surfaceElevated,
                          child: RadioListTile<String>(
                            value: language.$1,
                            activeColor: colors.brandBlue,
                            title: Text(
                              language.$2,
                              style: TextStyle(color: colors.textPrimary),
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.go('/welcome'),
                child: Text(l10n.common_continue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

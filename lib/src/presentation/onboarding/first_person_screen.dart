import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';

class FirstPersonScreen extends ConsumerStatefulWidget {
  const FirstPersonScreen({super.key});

  @override
  ConsumerState<FirstPersonScreen> createState() => _FirstPersonScreenState();
}

class _FirstPersonScreenState extends ConsumerState<FirstPersonScreen> {
  final _name = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error = AppLocalizations.of(context)!.person_name_error);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final controller = ref.read(ingestionControllerProvider);
      if (controller == null) throw StateError('Vault is not available');
      final languageCode = ref.read(appLanguageProvider);
      controller.setUiLanguage(
        SupportedLanguage.values.firstWhere(
          (language) => language.code == languageCode,
          orElse: () => SupportedLanguage.english,
        ),
      );
      await controller.createEntity(
        type: LifeEntityType.person,
        displayName: name,
        subtype: 'SELF',
      );
      ref.invalidate(primaryPersonProvider);
      if (mounted) context.go('/setup-complete');
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context)!.person_save_error,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.onboardingColors;
    return Scaffold(
      backgroundColor: colors.backgroundDeep,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 72),
            Icon(
              Icons.person_add_alt_1_rounded,
              color: colors.brandBlue,
              size: 72,
            ),
            const SizedBox(height: 32),
            Text(
              l10n.person_title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.person_body,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textSecondary, fontSize: 15),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _name,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _saving ? null : _continue(),
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                labelText: l10n.person_name_label,
                hintText: l10n.person_name_hint,
                errorText: _error,
                filled: true,
                fillColor: colors.surfaceElevated,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.lock_outline, color: colors.textSecondary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.person_privacy,
                    style: TextStyle(color: colors.textSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _saving ? null : _continue,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.common_continue),
            ),
          ],
        ),
      ),
    );
  }
}

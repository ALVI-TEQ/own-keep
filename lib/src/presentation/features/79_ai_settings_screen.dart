import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class AiSettingsScreen extends ConsumerStatefulWidget {
  const AiSettingsScreen({super.key});

  @override
  ConsumerState<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends ConsumerState<AiSettingsScreen> {
  bool _assistantEnabled = true;
  bool _suggestionsEnabled = true;
  bool _taggingEnabled = true;
  bool _expiryEnabled = true;
  bool _similarEnabled = true;
  bool _historyEnabled = true;
  bool _backgroundEnabled = false;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;
    final persisted = ref.watch(aiSettingsProvider).value;
    if (!_loaded && persisted != null) {
      _loaded = true;
      _assistantEnabled = persisted['assistant'] ?? true;
      _suggestionsEnabled = persisted['suggestions'] ?? true;
      _taggingEnabled = persisted['tagging'] ?? true;
      _expiryEnabled = persisted['expiry'] ?? true;
      _similarEnabled = persisted['similar'] ?? true;
      _historyEnabled = persisted['history'] ?? true;
      _backgroundEnabled = persisted['background'] ?? false;
    }

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              l10n.s79_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.s79_subtitle,
              style: TextStyle(color: colors.textMuted, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.successGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      OwnKeepMainIcons.shield_check,
                      colorFilter: ColorFilter.mode(
                        colors.successGreen,
                        BlendMode.srcIn,
                      ),
                      width: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.s79_private_title,
                            style: TextStyle(
                              color: colors.successGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s79_private_body,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Toggles
              _buildToggle(
                l10n.s79_assistant,
                l10n.s79_assistant_body,
                _assistantEnabled,
                (v) => _save('assistant', v, () => _assistantEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_suggestions,
                l10n.s79_suggestions_body,
                _suggestionsEnabled,
                (v) => _save('suggestions', v, () => _suggestionsEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_tagging,
                l10n.s79_tagging_body,
                _taggingEnabled,
                (v) => _save('tagging', v, () => _taggingEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_expiry,
                l10n.s79_expiry_body,
                _expiryEnabled,
                (v) => _save('expiry', v, () => _expiryEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_similar,
                l10n.s79_similar_body,
                _similarEnabled,
                (v) => _save('similar', v, () => _similarEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_history,
                l10n.s79_history_body,
                _historyEnabled,
                (v) => _save('history', v, () => _historyEnabled = v),
                colors,
              ),
              _buildToggle(
                l10n.s79_background,
                l10n.s79_background_body,
                _backgroundEnabled,
                (v) => _save('background', v, () => _backgroundEnabled = v),
                colors,
              ),
              const SizedBox(height: 40),

              // Clear History Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.push('/features/ai-history'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: colors.dangerRed),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        l10n.s79_clear,
                        style: TextStyle(
                          color: colors.dangerRed,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.s79_clear_body,
                        style: TextStyle(color: colors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(
    String title,
    String body,
    bool value,
    ValueChanged<bool> onChanged,
    OwnKeepMainColorsTheme colors,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(color: colors.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: colors.primaryBlue,
            inactiveTrackColor: colors.surfaceSecondary,
          ),
        ],
      ),
    );
  }

  Future<void> _save(String key, bool value, VoidCallback update) async {
    setState(update);
    final library = await ref.read(documentLibraryProvider.future);
    await library?.setAiSetting(key, value);
    ref.invalidate(aiSettingsProvider);
  }
}

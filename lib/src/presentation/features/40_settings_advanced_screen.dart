import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import '../../theme/ownkeep_spacing.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/vault_provider.dart';
import '../components/recovery_credential_dialog.dart';

class SettingsAdvancedScreen extends ConsumerStatefulWidget {
  const SettingsAdvancedScreen({super.key});

  @override
  ConsumerState<SettingsAdvancedScreen> createState() =>
      _SettingsAdvancedScreenState();
}

class _SettingsAdvancedScreenState
    extends ConsumerState<SettingsAdvancedScreen> {
  bool _biometricEnabled = false;
  bool _backupEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final biometric = await ref.read(vaultLifecycleProvider).biometricEnabled();
    if (!mounted) return;
    setState(() {
      _biometricEnabled = biometric;
      _backupEnabled = prefs.getBool('backup_reminders_enabled') ?? false;
    });
  }

  Future<void> _toggleBiometrics() async {
    if (_biometricEnabled) {
      await ref.read(vaultLifecycleProvider).disableBiometrics();
      if (mounted) setState(() => _biometricEnabled = false);
    } else if (mounted) {
      final credential = await showRecoveryCredentialDialog(
        context,
        title: 'Enable biometric unlock',
      );
      if (credential == null || !mounted) return;
      try {
        await ref
            .read(vaultSessionProvider.notifier)
            .enableBiometrics(credential);
        if (!mounted) return;
        setState(() => _biometricEnabled = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric unlock enabled.')),
        );
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not enable biometrics. Check the recovery credential and device biometric setup.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _toggleBackup() async {
    final value = !_backupEnabled;
    setState(() => _backupEnabled = value);
    await (await SharedPreferences.getInstance()).setBool(
      'backup_reminders_enabled',
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

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
        title: Text(
          l10n.s40_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: OwnKeepSpacing.lg,
          vertical: OwnKeepSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'APPEARANCE & LANGUAGE',
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    colors,
                    OwnKeepMainIcons.settings,
                    'Language & OCR',
                    value: ref.watch(appLanguageProvider).toUpperCase(),
                    onTap: () => context.push('/features/language'),
                  ),
                  _buildDivider(colors),
                  _buildSettingItem(
                    colors,
                    OwnKeepMainIcons.theme_midnight,
                    'Themes and colours',
                    onTap: () => context.push('/features/themes'),
                  ),
                  _buildDivider(colors),
                  _buildSettingItem(
                    colors,
                    OwnKeepMainIcons.theme_graphite,
                    'Dark mode',
                    isToggle: true,
                    isToggleOn: ref.watch(appDarkModeProvider),
                    onTap: () async {
                      final value = !ref.read(appDarkModeProvider);
                      ref.read(appUseSystemThemeProvider.notifier).state =
                          false;
                      ref.read(appDarkModeProvider.notifier).state = value;
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('appearance_use_system', false);
                      await prefs.setBool('app_dark_mode', value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Security Section
            Text(
              l10n.s40_security,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.auto_lock,
                      l10n.s40_auto_lock,
                      value: l10n.s40_auto_lock_value,
                      onTap: () => context.push('/features/app-lock'),
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.biometric,
                      l10n.s40_biometric,
                      isToggle: true,
                      isToggleOn: _biometricEnabled,
                      onTap: _toggleBiometrics,
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.pin_protection,
                      l10n.s40_pin,
                      value: l10n.s40_on,
                      onTap: () => context.push('/features/app-lock'),
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.vault_encryption,
                      l10n.s40_encryption,
                      value: l10n.s40_encryption_value,
                      onTap: () => context.push('/features/encryption-details'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Data Section
            Text(
              l10n.s40_data,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.backup_reminder,
                      l10n.s40_backup,
                      isToggle: true,
                      isToggleOn: _backupEnabled,
                      onTap: _toggleBackup,
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.restore,
                      'Backup and restore',
                      subtitle: 'Create a backup or restore an encrypted vault',
                      onTap: () => context.push('/features/backup-restore'),
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.data_check,
                      l10n.s40_data_check,
                      value: l10n.s40_last_check,
                      onTap: () {
                        context.push('/features/data-check');
                      },
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.wipe_data,
                      l10n.s40_wipe,
                      subtitle: l10n.s40_wipe_body,
                      isDanger: true,
                      onTap: () {
                        context.push('/features/wipe-data');
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Advanced Section
            Text(
              l10n.s40_advanced,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.developer,
                      l10n.s40_developer,
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'OwnKeep',
                          applicationVersion: 'Developer diagnostics',
                          children: const [
                            Text(
                              'Security and database diagnostics are available in Audit Logs.',
                            ),
                          ],
                        );
                      },
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.logs,
                      l10n.s40_logs,
                      onTap: () {
                        context.push('/features/security-audit');
                      },
                    ),
                    _buildDivider(colors),
                    _buildSettingItem(
                      colors,
                      OwnKeepMainIcons.reset,
                      l10n.s40_reset,
                      isDanger: true,
                      onTap: () {
                        context.push('/features/wipe-data');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title, {
    String? subtitle,
    String? value,
    bool isToggle = false,
    bool isToggleOn = false,
    bool isDanger = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isDanger ? colors.dangerRed : colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDanger ? colors.dangerRed : colors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),
            if (isToggle)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  isToggleOn
                      ? OwnKeepOnboardingIcons.toggle_on
                      : OwnKeepOnboardingIcons.toggle_off,
                  width: 40,
                ),
              )
            else if (value != null || (!isToggle && !isDanger))
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  OwnKeepMainIcons.chevron_right,
                  colorFilter: ColorFilter.mode(
                    colors.textMuted,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(
      color: colors.borderSoft,
      height: 1,
      indent: 56, // Align with text start
    );
  }
}

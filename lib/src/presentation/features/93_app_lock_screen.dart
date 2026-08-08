import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  int _autoLockIndex = 0; // 0=Immediately, 1=30s, 2=2m
  bool _biometricEnabled = false;
  bool _pinEnabled = false;

  @override
  void initState() {
    super.initState();
    Future.wait([
      ref.read(vaultLifecycleProvider).biometricEnabled(),
      ref.read(pinCredentialStoreProvider).isEnrolled(),
      SharedPreferences.getInstance(),
    ]).then((values) {
      if (!mounted) return;
      final prefs = values[2] as SharedPreferences;
      setState(() {
        _biometricEnabled = values[0] as bool;
        _pinEnabled = values[1] as bool;
        _autoLockIndex = prefs.getInt('app_auto_lock_index') ?? 0;
      });
    });
  }

  Future<void> _setAutoLock(int index) async {
    setState(() => _autoLockIndex = index);
    await (await SharedPreferences.getInstance()).setInt(
      'app_auto_lock_index',
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
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
        title: Column(
          children: [
            Text(
              l10n.s93_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.s93_subtitle,
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
              // Status Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.successGreen.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shield_rounded,
                        color: colors.successGreen,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.s93_status_label,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.s93_status,
                      style: TextStyle(
                        color: colors.successGreen,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.s93_method_summary,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Lock Methods
              Text(
                l10n.s93_methods,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildMethodItem(
                context,
                l10n.s93_biometric,
                l10n.s93_biometric_body,
                OwnKeepMainIcons.fingerprint,
                _biometricEnabled,
                colors,
              ),
              _buildMethodItem(
                context,
                l10n.s93_pin,
                l10n.s93_pin_body,
                OwnKeepMainIcons.pin,
                _pinEnabled,
                colors,
              ),
              _buildMethodItem(
                context,
                l10n.s93_recovery,
                l10n.s93_recovery_body,
                OwnKeepMainIcons.key,
                true,
                colors,
              ),

              const SizedBox(height: 32),

              // Auto Lock
              Text(
                l10n.s93_auto_lock,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Column(
                  children: [
                    _buildRadioRow(l10n.s93_immediately, 0, colors),
                    Divider(color: colors.borderSoft, height: 1),
                    _buildRadioRow(l10n.s93_after_30, 1, colors),
                    Divider(color: colors.borderSoft, height: 1),
                    _buildRadioRow(l10n.s93_after_2, 2, colors),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.info_outline, color: colors.textMuted, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.s93_background,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.textMuted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () async {
                await ref.read(vaultSessionProvider.notifier).lockVault();
                if (context.mounted) {
                  context.go('/lock');
                }
              },
              icon: const Icon(Icons.lock_outline, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.dangerRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              label: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.s93_lock_now,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    l10n.s93_lock_now_body,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodItem(
    BuildContext context,
    String title,
    String body,
    String iconPath,
    bool isActive,
    OwnKeepMainColorsTheme colors,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceSecondary,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                colors.primaryBlue,
                BlendMode.srcIn,
              ),
              width: 24,
            ),
          ),
          const SizedBox(width: 16),
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
                  style: TextStyle(color: colors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isActive)
            Icon(Icons.check_circle, color: colors.successGreen, size: 24)
          else
            Icon(Icons.circle_outlined, color: colors.textMuted, size: 24),
        ],
      ),
    );
  }

  Widget _buildRadioRow(
    String label,
    int index,
    OwnKeepMainColorsTheme colors,
  ) {
    return InkWell(
      onTap: () => _setAutoLock(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: colors.textPrimary, fontSize: 16),
            ),
            Icon(
              _autoLockIndex == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: _autoLockIndex == index
                  ? colors.primaryBlue
                  : colors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

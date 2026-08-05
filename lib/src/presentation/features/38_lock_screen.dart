import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import '../../theme/ownkeep_spacing.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vault_provider.dart';

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _pin = '';

  String? _error;
  bool _isAuthenticating = false;

  void _onKeypadTap(String value) {
    if (_pin.length < 4 && !_isAuthenticating) {
      setState(() {
        _pin += value;
        _error = null;
      });
      if (_pin.length == 4) {
        _authenticate();
      }
    }
  }

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      await ref.read(vaultSessionProvider.notifier).unlockVault(_pin);
      if (mounted) {
        context.go('/dashboard/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Incorrect PIN';
          _pin = '';
          _isAuthenticating = false;
        });
      }
    }
  }

  void _onBackspaceTap() {
    if (_pin.isNotEmpty && !_isAuthenticating) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _error = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // App Name & Prompt
            Text(
              l10n.s38_app_name,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Text(
              l10n.s38_enter_pin,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // PIN Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    index < _pin.length ? OwnKeepMainIcons.pin_dot_active : OwnKeepMainIcons.pin_dot_inactive,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      index < _pin.length ? colors.primaryBlue : colors.textMuted,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 16),
            if (_isAuthenticating)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: TextStyle(color: colors.dangerRed, fontSize: 14, fontFamily: 'Inter'),
              )
            else
              const SizedBox(height: 20),

            const Spacer(),

            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3'], ['', l10n.s38_key_2_letters, l10n.s38_key_3_letters], colors),
                  const SizedBox(height: 20),
                  _buildKeypadRow(['4', '5', '6'], [l10n.s38_key_4_letters, l10n.s38_key_5_letters, l10n.s38_key_6_letters], colors),
                  const SizedBox(height: 20),
                  _buildKeypadRow(['7', '8', '9'], [l10n.s38_key_7_letters, l10n.s38_key_8_letters, l10n.s38_key_9_letters], colors),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(OwnKeepOnboardingIcons.face_id, colors, () {}),
                      _buildNumberKey('0', '', colors),
                      _buildIconButton(OwnKeepMainIcons.keypad_backspace, colors, _onBackspaceTap),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Emergency Access
            TextButton(
              onPressed: () {},
              child: Text(
                l10n.s38_emergency,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers, List<String> letters, OwnKeepMainColorsTheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return _buildNumberKey(numbers[index], letters[index], colors);
      }),
    );
  }

  Widget _buildNumberKey(String number, String letters, OwnKeepMainColorsTheme colors) {
    return GestureDetector(
      onTap: () => _onKeypadTap(number),
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  letterSpacing: 1.5,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String icon, OwnKeepMainColorsTheme colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}

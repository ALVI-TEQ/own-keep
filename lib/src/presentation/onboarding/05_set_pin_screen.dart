import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_pin_pad.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String _pin = '';
  String? _error;

  void _onKeyPress(String value) {
    if (_pin.length < 6) {
      setState(() {
        _pin += value;
        _error = null;
      });
      if (_pin.length == 6) {
        if (_isWeakPin(_pin)) {
          setState(() {
            _pin = '';
            _error = 'Choose a PIN without repeated or sequential digits.';
          });
        } else {
          context.push('/confirm-pin', extra: _pin);
        }
      }
    }
  }

  bool _isWeakPin(String pin) {
    if (pin.split('').every((digit) => digit == pin[0])) return true;
    const sequences = <String>{
      '012345',
      '123456',
      '234567',
      '345678',
      '456789',
      '987654',
      '876543',
      '765432',
      '654321',
      '543210',
    };
    return sequences.contains(pin);
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
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
                  l10n.s05_title,
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
                  l10n.s05_body,
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
                Text(
                  _error!,
                  style: TextStyle(
                    color: context.onboardingColors.foreverRed,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
              const Spacer(),
              OwnKeepPinIndicator(length: 6, currentLength: _pin.length),
              const Spacer(),
              OwnKeepPinPad(onKeyPress: _onKeyPress, onBackspace: _onBackspace),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

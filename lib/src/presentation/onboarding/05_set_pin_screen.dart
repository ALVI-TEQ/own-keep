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

  void _onKeyPress(String value) {
    if (_pin.length < 6) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == 6) {
        context.push('/confirm-pin', extra: _pin);
      }
    }
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
                  icon: SvgPicture.asset(OwnKeepOnboardingIcons.back_arrow, width: 24, height: 24),
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
              const Spacer(),
              OwnKeepPinIndicator(length: 6, currentLength: _pin.length),
              const Spacer(),
              OwnKeepPinPad(
                onKeyPress: _onKeyPress,
                onBackspace: _onBackspace,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

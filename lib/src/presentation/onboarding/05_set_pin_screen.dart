import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../components/ownkeep_pin_pad.dart';

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
    
    return OwnKeepOnboardingScaffold(
      showBackButton: true,
      child: Column(
        children: [
          SizedBox(height: 32),
          OwnKeepOnboardingHeader(
            title: l10n.setPinTitle,
            subtitle: l10n.setPinDesc,
          ),
          const Spacer(),
          OwnKeepPinIndicator(length: 6, currentLength: _pin.length),
          const Spacer(),
          OwnKeepPinPad(
            onKeyPress: _onKeyPress,
            onBackspace: _onBackspace,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

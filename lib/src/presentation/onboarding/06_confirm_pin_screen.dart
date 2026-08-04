import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../components/ownkeep_pin_pad.dart';
import '../../theme/app_colors.dart';

class ConfirmPinScreen extends StatefulWidget {
  final String originalPin;
  const ConfirmPinScreen({super.key, required this.originalPin});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String _pin = '';
  String? _error;

  void _onKeyPress(String value) {
    setState(() {
      _error = null;
    });
    
    if (_pin.length < 6) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _verifyPin() async {
    if (_pin == widget.originalPin) {
      // In a real implementation, we would store this via vaultLifecycle
      context.push('/recovery-phrase');
    } else {
      setState(() {
        _error = AppLocalizations.of(context)!.pinMismatchError;
        _pin = '';
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _error = null;
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
            title: l10n.confirmPinTitle,
            subtitle: l10n.confirmPinDesc,
          ),
          if (_error != null) ...[
            SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(color: context.appColors.red, fontSize: 14),
            ),
          ],
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

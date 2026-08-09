import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String?> showNewPinDialog(
  BuildContext context, {
  required String title,
  String message = 'Choose a new 6-digit PIN and enter it again to confirm.',
}) async {
  final pinController = TextEditingController();
  final confirmationController = TextEditingController();
  String? error;
  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: const InputDecoration(labelText: 'New PIN'),
            ),
            TextField(
              controller: confirmationController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: const InputDecoration(labelText: 'Confirm PIN'),
            ),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final pin = pinController.text;
              if (pin.length != 6) {
                setState(() => error = 'Enter exactly 6 digits.');
                return;
              }
              if (_isWeakPin(pin)) {
                setState(
                  () => error =
                      'Choose a PIN without repeated or sequential digits.',
                );
                return;
              }
              if (pin != confirmationController.text) {
                setState(() => error = 'The PINs do not match.');
                return;
              }
              Navigator.pop(dialogContext, pin);
            },
            child: const Text('Save PIN'),
          ),
        ],
      ),
    ),
  );
  pinController.dispose();
  confirmationController.dispose();
  return result;
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

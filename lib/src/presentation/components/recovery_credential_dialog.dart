import 'package:flutter/material.dart';

import '../../domain/recovery/recovery_method.dart';

Future<String?> showRecoveryCredentialDialog(
  BuildContext context, {
  required String title,
}) => showDialog<String>(
  context: context,
  barrierDismissible: false,
  builder: (_) => _RecoveryCredentialDialog(title: title),
);

class _RecoveryCredentialDialog extends StatefulWidget {
  const _RecoveryCredentialDialog({required this.title});

  final String title;

  @override
  State<_RecoveryCredentialDialog> createState() =>
      _RecoveryCredentialDialogState();
}

class _RecoveryCredentialDialogState extends State<_RecoveryCredentialDialog> {
  final _words = List.generate(12, (_) => TextEditingController());
  final _password = TextEditingController();
  RecoveryMethod _method = RecoveryMethod.generatedPhrase;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    for (final controller in _words) {
      controller.dispose();
    }
    _password.dispose();
    super.dispose();
  }

  void _distributePastedWords(String value) {
    final words = recoveryWords(value);
    if (words.length != 12) return;
    for (var index = 0; index < words.length; index++) {
      _words[index].text = words[index];
    }
    setState(() => _error = null);
  }

  void _submit() {
    final String value;
    if (_method == RecoveryMethod.generatedPhrase) {
      final words = _words.map((field) => field.text.trim()).toList();
      if (words.any((word) => word.isEmpty)) {
        setState(() => _error = 'Enter all 12 words in order.');
        return;
      }
      value = words.join(' ').toLowerCase();
    } else {
      value = _password.text.trim();
      if (value.isEmpty) {
        setState(() => _error = 'Enter your recovery password or legacy code.');
        return;
      }
    }
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: SizedBox(
      width: 480,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SegmentedButton<RecoveryMethod>(
              segments: const [
                ButtonSegment(
                  value: RecoveryMethod.generatedPhrase,
                  label: Text('12 words'),
                ),
                ButtonSegment(
                  value: RecoveryMethod.customPassphrase,
                  label: Text('Password/code'),
                ),
              ],
              selected: {_method},
              onSelectionChanged: (selection) => setState(() {
                _method = selection.single;
                _error = null;
              }),
            ),
            const SizedBox(height: 16),
            if (_method == RecoveryMethod.generatedPhrase) ...[
              const Text(
                'Enter the words in their numbered order. You can paste the full phrase into word 1.',
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 64,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => TextField(
                  controller: _words[index],
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: index == 11
                      ? TextInputAction.done
                      : TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Word ${index + 1}',
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: index == 0 ? _distributePastedWords : null,
                ),
              ),
            ] else ...[
              const Text(
                'Enter your custom recovery password. Existing OwnKeep recovery codes also remain supported.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _password,
                obscureText: _obscure,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: 'Recovery password or legacy code',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Continue')),
    ],
  );
}

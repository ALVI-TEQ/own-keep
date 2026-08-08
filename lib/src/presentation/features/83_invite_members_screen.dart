import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/ownkeep_main_colors.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  String _role = 'Adult';
  String _method = 'Direct device transfer';

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Prepare secure access'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Offline transfer only'),
                subtitle: Text(
                  'OwnKeep does not create a remote member account. The recipient must be present for a secure device transfer or receive an encrypted backup.',
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Recipient name',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a recipient name'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _role,
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
              items: const ['Adult', 'Child', 'Trusted contact']
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _role = value ?? _role),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _method,
              decoration: const InputDecoration(
                labelText: 'Transfer method',
                border: OutlineInputBorder(),
              ),
              items: const ['Direct device transfer', 'Encrypted backup file']
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _method = value ?? _method),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                context.push(
                  _method == 'Direct device transfer'
                      ? '/features/device-migration'
                      : '/features/backup-restore',
                );
              },
              icon: const Icon(Icons.lock),
              label: Text(
                _method == 'Direct device transfer'
                    ? 'Continue to device transfer'
                    : 'Create encrypted backup',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

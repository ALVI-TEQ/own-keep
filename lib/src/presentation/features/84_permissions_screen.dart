import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/ownkeep_main_colors.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

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
        title: const Text('Access permissions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text('No remote member selected'),
              subtitle: Text(
                'OwnKeep has no cloud membership service. Access is defined by the documents placed into an encrypted transfer package.',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Recipient access'),
            subtitle: Text(
              'A recipient can view only the records explicitly included in the exported package.',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.edit_off),
            title: Text('No live edits'),
            subtitle: Text(
              'Changes are not synchronized back into this vault.',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.key),
            title: Text('Encryption boundary'),
            subtitle: Text(
              'Transfer and backup flows preserve the encrypted vault boundary.',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.push('/features/device-migration'),
            icon: const Icon(Icons.devices),
            label: const Text('Configure secure transfer'),
          ),
        ],
      ),
    );
  }
}

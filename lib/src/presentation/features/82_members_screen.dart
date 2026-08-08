import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/ownkeep_main_colors.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Members'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: colors.surfacePrimary,
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('This device owner'),
              subtitle: Text('Full access to the local encrypted vault'),
              trailing: Chip(label: Text('Owner')),
            ),
          ),
          const SizedBox(height: 20),
          const Text('No additional member has been paired on this device.'),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Invite or pair a member'),
            subtitle: const Text('Prepare an explicit invitation package'),
            onTap: () => context.push('/features/invite-members'),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Secure device transfer'),
            onTap: () => context.push('/features/device-migration'),
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Encrypted backup package'),
            onTap: () => context.push('/features/backup-restore'),
          ),
        ],
      ),
    );
  }
}

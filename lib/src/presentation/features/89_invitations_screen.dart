import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/ownkeep_main_colors.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key});

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
        title: const Text('Invitations'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 56),
              const SizedBox(height: 16),
              const Text(
                'No pending invitations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'OwnKeep does not use a cloud invitation inbox. Secure access is prepared as an explicit encrypted transfer.',
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.push('/features/invite-members'),
                icon: const Icon(Icons.person_add),
                label: const Text('Prepare secure access'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

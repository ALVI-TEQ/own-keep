import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../citizen_vault/vault/encrypted_local_state_repository.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class InvitationsScreen extends ConsumerStatefulWidget {
  const InvitationsScreen({super.key});

  @override
  ConsumerState<InvitationsScreen> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends ConsumerState<InvitationsScreen> {
  late Future<List<OfflineInvitation>> _invitations;

  @override
  void initState() {
    super.initState();
    _invitations =
        ref.read(ingestionControllerProvider)?.offlineInvitations() ??
        Future.value(const <OfflineInvitation>[]);
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
        title: const Text('Offline invitations'),
        actions: [
          IconButton(
            onPressed: () => context.push('/features/invite-members'),
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: FutureBuilder<List<OfflineInvitation>>(
        future: _invitations,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final values = snapshot.data ?? const <OfflineInvitation>[];
          if (values.isEmpty) {
            return const Center(
              child: Text('No secure access packages prepared.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final invitation = values[index];
              return Card(
                color: colors.surfacePrimary,
                child: ListTile(
                  leading: const Icon(Icons.lock_person_outlined),
                  title: Text(invitation.recipientName),
                  subtitle: Text(
                    '${invitation.role} • ${invitation.method}\n'
                    '${invitation.createdAt.toLocal().toString().split('.')[0]}',
                  ),
                  isThreeLine: true,
                  trailing: Chip(
                    label: Text(
                      invitation.completed ? 'Completed' : 'Prepared',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/features/invite-members'),
        icon: const Icon(Icons.add),
        label: const Text('Prepare access'),
      ),
    );
  }
}

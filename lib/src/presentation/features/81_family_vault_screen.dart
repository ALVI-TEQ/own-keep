import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class FamilyVaultScreen extends ConsumerWidget {
  const FamilyVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final documents = ref.watch(allDocumentsProvider);
    final collections = ref.watch(customCollectionsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Family Vault'),
        actions: [
          IconButton(
            onPressed: () => context.push('/features/access-history'),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: colors.surfacePrimary,
            child: const ListTile(
              leading: Icon(Icons.security),
              title: Text('Explicit offline sharing'),
              subtitle: Text(
                'OwnKeep does not upload vault records or silently create remote family accounts.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          _action(
            context,
            'Members and invitations',
            '/features/members',
            Icons.people,
          ),
          _action(
            context,
            'Trusted contacts',
            '/features/trusted-contacts',
            Icons.contact_emergency,
          ),
          _action(
            context,
            'Emergency access',
            '/features/emergency-access',
            Icons.emergency,
          ),
          _action(
            context,
            'Shared activity',
            '/features/shared-activity',
            Icons.history,
          ),
          const SizedBox(height: 20),
          Text('Vault summary', style: Theme.of(context).textTheme.titleLarge),
          documents.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
            data: (items) => ListTile(
              title: const Text('Encrypted documents'),
              trailing: Text('${items.length}'),
            ),
          ),
          collections.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
            data: (items) => ListTile(
              title: const Text('Custom collections'),
              trailing: Text('${items.length}'),
            ),
          ),
          FilledButton.icon(
            onPressed: () => context.push('/features/device-migration'),
            icon: const Icon(Icons.devices),
            label: const Text('Start secure device transfer'),
          ),
        ],
      ),
    );
  }

  Widget _action(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    ),
  );
}

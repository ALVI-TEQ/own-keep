import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SharedCollectionsScreen extends ConsumerWidget {
  const SharedCollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final collections = ref.watch(customCollectionsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Collections for sharing'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text('Nothing is shared automatically'),
              subtitle: Text(
                'Choose records explicitly in the export or device-transfer flow.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          collections.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Unable to load collections: $error'),
            data: (items) => items.isEmpty
                ? const ListTile(title: Text('No custom collections yet'))
                : Column(
                    children: items
                        .map(
                          (item) => Card(
                            child: ListTile(
                              leading: const Icon(Icons.folder),
                              title: Text(item.name),
                              subtitle: const Text('Stored locally'),
                              onTap: () =>
                                  context.push('/collections/${item.id}'),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => context.push('/features/share-export'),
            icon: const Icon(Icons.ios_share),
            label: const Text('Select documents to export'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AiHistoryScreen extends ConsumerWidget {
  const AiHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final controller = ref.watch(ingestionControllerProvider);
    final suggestions = controller?.attentionItems ?? const [];
    final events = controller?.events ?? const [];
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Local AI History'),
      ),
      body: suggestions.isEmpty && events.isEmpty
          ? const Center(child: Text('No local intelligence activity yet.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...suggestions.map(
                  (item) => Card(
                    color: colors.surfacePrimary,
                    child: ListTile(
                      leading: const Icon(Icons.auto_awesome),
                      title: Text(item.title),
                      subtitle: Text(item.explanation),
                      trailing: Text(item.status.name),
                    ),
                  ),
                ),
                ...events.map(
                  (event) => Card(
                    color: colors.surfacePrimary,
                    child: ListTile(
                      leading: const Icon(Icons.timeline),
                      title: Text(event.title),
                      subtitle: Text(event.type.displayName),
                      trailing: Text(event.status.name),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

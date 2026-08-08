import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AiTimelineScreen extends ConsumerWidget {
  const AiTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final events = [...?ref.watch(ingestionControllerProvider)?.events]
      ..sort((a, b) => b.startAt.compareTo(a.startAt));
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('AI Timeline'),
      ),
      body: events.isEmpty
          ? const Center(
              child: Text('No confirmed or suggested timeline events yet.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  color: colors.surfacePrimary,
                  child: ListTile(
                    leading: const Icon(Icons.timeline),
                    title: Text(event.title),
                    subtitle: Text(
                      '${event.type.displayName} • ${event.status.name}',
                    ),
                    trailing: Text(
                      '${event.startAt.day}/${event.startAt.month}/${event.startAt.year}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}

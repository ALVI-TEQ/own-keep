import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AccessHistoryScreen extends ConsumerWidget {
  const AccessHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final logs =
        ref
            .watch(ingestionControllerProvider)
            ?.emergencyStorage
            .envelope
            .accessLog ??
        const <String>[];
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Access history'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.verified_user),
                title: Text('${logs.length} recorded accesses'),
                subtitle: const Text(
                  'Emergency-card access events stored in the isolated local envelope.',
                ),
              ),
            ),
          ),
          Expanded(
            child: logs.isEmpty
                ? const Center(child: Text('No access events recorded.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final timestamp = DateTime.tryParse(
                        logs[index],
                      )?.toLocal();
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.history),
                          title: const Text('Emergency card accessed'),
                          subtitle: Text(timestamp?.toString() ?? logs[index]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: OutlinedButton.icon(
            onPressed: () => context.push('/features/backup-restore'),
            icon: const Icon(Icons.archive),
            label: const Text('Back up vault and audit data'),
          ),
        ),
      ),
    );
  }
}

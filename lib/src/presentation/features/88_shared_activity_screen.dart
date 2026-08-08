import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SharedActivityScreen extends ConsumerWidget {
  const SharedActivityScreen({super.key});

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
        title: const Text('Local access activity'),
      ),
      body: logs.isEmpty
          ? const Center(child: Text('No recorded local access activity.'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final timestamp = DateTime.tryParse(logs[index])?.toLocal();
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.emergency),
                    title: const Text('Emergency card accessed'),
                    subtitle: Text(timestamp?.toString() ?? logs[index]),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../citizen_vault/intelligence/encrypted_ai_history_repository.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AiHistoryScreen extends ConsumerStatefulWidget {
  const AiHistoryScreen({super.key});

  @override
  ConsumerState<AiHistoryScreen> createState() => _AiHistoryScreenState();
}

class _AiHistoryScreenState extends ConsumerState<AiHistoryScreen> {
  late Future<List<AiHistoryEntry>> _history;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _history =
        ref.read(ingestionControllerProvider)?.aiHistory() ??
        Future.value(const <AiHistoryEntry>[]);
  }

  Future<void> _clear() async {
    await ref.read(ingestionControllerProvider)?.clearAiHistory();
    if (mounted) setState(_reload);
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
        title: const Text('Encrypted AI history'),
        actions: [
          IconButton(
            tooltip: 'Clear history',
            onPressed: _clear,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<AiHistoryEntry>>(
        future: _history,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data ?? const <AiHistoryEntry>[];
          if (entries.isEmpty) {
            return const Center(
              child: Text('No AI questions have been saved yet.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                color: colors.surfacePrimary,
                child: ExpansionTile(
                  leading: const Icon(Icons.auto_awesome),
                  title: Text(entry.query),
                  subtitle: Text(
                    entry.createdAt.toLocal().toString().split('.')[0],
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.answer),
                    if (entry.evidenceDocumentIds.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        '${entry.evidenceDocumentIds.length} evidence documents',
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

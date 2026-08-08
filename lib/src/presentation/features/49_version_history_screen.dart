import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

/// Honest persisted processing history for encrypted records.
class VersionHistoryScreen extends ConsumerStatefulWidget {
  const VersionHistoryScreen({super.key, this.documentId});

  final String? documentId;

  @override
  ConsumerState<VersionHistoryScreen> createState() =>
      _VersionHistoryScreenState();
}

class _VersionHistoryScreenState extends ConsumerState<VersionHistoryScreen> {
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.documentId;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final documents = ref.watch(allDocumentsProvider);
    final detail = _selectedId == null
        ? null
        : ref.watch(documentDetailProvider(_selectedId!));
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Document history'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          documents.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
            data: (items) => DropdownButtonFormField<String>(
              initialValue: _selectedId,
              decoration: const InputDecoration(
                labelText: 'Document',
                border: OutlineInputBorder(),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.logicalFilename),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _selectedId = value),
            ),
          ),
          const SizedBox(height: 20),
          if (detail != null)
            detail.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('$error'),
              data: (document) {
                if (document == null) return const Text('Document not found.');
                if (document.processingHistory.isEmpty) {
                  return const Text('No processing history is recorded.');
                }
                return Column(
                  children: document.processingHistory
                      .map((step) => _historyCard(step, colors))
                      .toList(),
                );
              },
            )
          else
            const Text(
              'Choose a document to inspect its persisted processing history.',
            ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Original-file versions'),
              subtitle: Text(
                'OwnKeep keeps one authenticated original per record. Renaming, tags and OCR reprocessing do not create misleading file snapshots.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyCard(
    ProcessingHistoryView step,
    OwnKeepMainColorsTheme colors,
  ) => Card(
    color: colors.surfacePrimary,
    child: ListTile(
      leading: Icon(
        step.status.toUpperCase() == 'COMPLETE' ||
                step.status.toUpperCase() == 'COMPLETED'
            ? Icons.check_circle
            : step.errorCode == null
            ? Icons.schedule
            : Icons.error_outline,
      ),
      title: Text(step.stepName),
      subtitle: Text(
        '${step.status} • ${step.attemptCount} attempt(s)'
        '${step.errorCode == null ? '' : '\n${step.errorCode}'}',
      ),
      trailing: Text(
        step.completedAt?.toLocal().toString().split('.')[0] ?? 'Pending',
      ),
      isThreeLine: step.errorCode != null,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AiSearchResultsScreen extends ConsumerWidget {
  const AiSearchResultsScreen({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final responseAsync = ref.watch(vaultContentAnswerProvider(query));
    final response = responseAsync.value;
    final documents = ref.watch(allDocumentsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('AI Search Results'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(query, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Card(
            color: colors.surfacePrimary,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: responseAsync.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      response?.answerText ??
                          'No matching content was found in the local index.',
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Evidence', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          documents.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('$error'),
            data: (items) {
              final evidenceIds = response?.evidenceDocumentIds.toSet() ?? {};
              final evidence = items
                  .where((item) => evidenceIds.contains(item.id))
                  .toList();
              if (evidence.isEmpty) {
                return Text(
                  response?.isAvailable == true
                      ? 'The answer uses local structured vault data.'
                      : 'No supporting document was found.',
                  style: TextStyle(color: colors.textSecondary),
                );
              }
              return Column(
                children: evidence
                    .map(
                      (document) => Card(
                        color: colors.surfacePrimary,
                        child: ListTile(
                          title: Text(document.logicalFilename),
                          subtitle: Text(document.documentType.displayName),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(
                            '/features/document-preview?id=${Uri.encodeQueryComponent(document.id)}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

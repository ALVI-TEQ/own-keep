import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SimilarDocumentsScreen extends ConsumerWidget {
  const SimilarDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Similar Documents'),
      ),
      body: ref
          .watch(allDocumentsProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('$error')),
            data: (documents) {
              final groups = similarDocumentGroups(documents);
              if (groups.isEmpty) {
                return const Center(
                  child: Text('No similar document groups found.'),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: groups.entries
                    .map(
                      (entry) => Card(
                        color: colors.surfacePrimary,
                        child: ListTile(
                          title: Text(entry.key.displayName),
                          subtitle: Text('${entry.value.length} documents'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            final first = entry.value[0].id;
                            final second = entry.value[1].id;
                            context.push(
                              '/features/duplicate-resolution?first=${Uri.encodeQueryComponent(first)}&second=${Uri.encodeQueryComponent(second)}',
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
    );
  }
}

Map<DocumentType, List<DocumentListItemView>> similarDocumentGroups(
  List<DocumentListItemView> documents,
) {
  final groups = <DocumentType, List<DocumentListItemView>>{};
  for (final document in documents) {
    groups.putIfAbsent(document.documentType, () => []).add(document);
  }
  groups.removeWhere((_, items) => items.length < 2);
  return groups;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class UncategorizedDocumentsScreen extends ConsumerWidget {
  const UncategorizedDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(allDocumentsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Review Categories')),
      body: documents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            const Center(child: Text('Documents could not be loaded.')),
        data: (items) {
          final uncategorized = items
              .where((item) => item.documentType == DocumentType.unknown)
              .toList();
          if (uncategorized.isEmpty) {
            return const Center(
              child: Text('Every document has been categorized.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: uncategorized.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final document = uncategorized[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(document.logicalFilename),
                  subtitle: Text(document.mimeType),
                  onTap: () => context.push(
                    '/features/document-preview?id=${Uri.encodeQueryComponent(document.id)}',
                  ),
                  trailing: PopupMenuButton<DocumentType>(
                    tooltip: 'Choose category',
                    onSelected: (type) async {
                      await ref
                          .read(ingestionControllerProvider)
                          ?.setDocumentType(document.id, type);
                      ref.invalidate(allDocumentsProvider);
                      ref.invalidate(recentDocumentsProvider);
                    },
                    itemBuilder: (_) => DocumentType.values
                        .where((type) => type != DocumentType.unknown)
                        .map(
                          (type) => PopupMenuItem(
                            value: type,
                            child: Text(type.displayName),
                          ),
                        )
                        .toList(),
                    child: const Chip(label: Text('Categorize')),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

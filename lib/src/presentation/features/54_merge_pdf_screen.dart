import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../citizen_vault/library/pdf_document_tools.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class MergePdfScreen extends ConsumerStatefulWidget {
  const MergePdfScreen({super.key});

  @override
  ConsumerState<MergePdfScreen> createState() => _MergePdfScreenState();
}

class _MergePdfScreenState extends ConsumerState<MergePdfScreen> {
  final _selected = <String>[];
  bool _busy = false;

  Future<void> _merge(List<DocumentListItemView> pdfs) async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null || _selected.length < 2) return;
    setState(() => _busy = true);
    try {
      final details = <DocumentDetailView>[];
      for (final id in _selected) {
        final detail = await ref.read(documentDetailProvider(id).future);
        if (detail != null) details.add(detail);
      }
      final message = await const PdfDocumentTools().merge(
        controller: controller,
        documents: details,
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('PDF merge failed: $error')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final documents = ref.watch(allDocumentsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Merge PDFs'),
      ),
      body: documents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) {
          final pdfs = items
              .where((item) => item.mimeType.toLowerCase() == 'application/pdf')
              .toList();
          if (pdfs.isEmpty) {
            return const Center(child: Text('No PDF files in this vault.'));
          }
          return ReorderableListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            header: const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Select at least two PDFs. Drag selected files to set their order.',
              ),
            ),
            onReorderItem: (oldIndex, newIndex) {
              final selectedItems = pdfs
                  .where((item) => _selected.contains(item.id))
                  .toList();
              if (oldIndex >= selectedItems.length) {
                return;
              }
              final id = selectedItems.removeAt(oldIndex).id;
              selectedItems.insert(
                newIndex.clamp(0, selectedItems.length),
                pdfs.firstWhere((d) => d.id == id),
              );
              setState(() {
                _selected
                  ..clear()
                  ..addAll(selectedItems.map((item) => item.id));
              });
            },
            children: pdfs.map((item) {
              final checked = _selected.contains(item.id);
              return CheckboxListTile(
                key: ValueKey(item.id),
                value: checked,
                secondary: const Icon(Icons.picture_as_pdf),
                title: Text(item.logicalFilename),
                subtitle: Text(
                  checked
                      ? 'Position ${_selected.indexOf(item.id) + 1}'
                      : 'Not selected',
                ),
                onChanged: (value) => setState(() {
                  value == true
                      ? _selected.add(item.id)
                      : _selected.remove(item.id);
                }),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _busy || _selected.length < 2
              ? null
              : () => _merge(ref.read(allDocumentsProvider).value ?? const []),
          icon: _busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.merge_type),
          label: Text(_busy ? 'Merging locally…' : 'Merge and save'),
        ),
      ),
    );
  }
}

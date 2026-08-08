import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../citizen_vault/library/pdf_document_tools.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SplitPdfScreen extends ConsumerStatefulWidget {
  const SplitPdfScreen({super.key});

  @override
  ConsumerState<SplitPdfScreen> createState() => _SplitPdfScreenState();
}

class _SplitPdfScreenState extends ConsumerState<SplitPdfScreen> {
  String? _documentId;
  int _pageCount = 0;
  final _selectedPages = <int>{};
  PdfSplitMode _mode = PdfSplitMode.extract;
  bool _busy = false;

  Future<void> _select(DocumentListItemView item) async {
    final controller = ref.read(ingestionControllerProvider);
    final detail = await ref.read(documentDetailProvider(item.id).future);
    if (controller == null || detail == null) return;
    setState(() {
      _busy = true;
      _documentId = item.id;
      _selectedPages.clear();
    });
    try {
      final count = await const PdfDocumentTools().pageCount(
        controller: controller,
        document: detail,
      );
      if (mounted) setState(() => _pageCount = count);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _split() async {
    final id = _documentId;
    final controller = ref.read(ingestionControllerProvider);
    if (id == null || controller == null || _selectedPages.isEmpty) return;
    final detail = await ref.read(documentDetailProvider(id).future);
    if (detail == null) return;
    setState(() => _busy = true);
    try {
      final message = await const PdfDocumentTools().split(
        controller: controller,
        document: detail,
        selectedPages: _selectedPages,
        mode: _mode,
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
        ).showSnackBar(SnackBar(content: Text('PDF split failed: $error')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final pdfs =
        (ref.watch(allDocumentsProvider).value ??
                const <DocumentListItemView>[])
            .where((item) => item.mimeType.toLowerCase() == 'application/pdf')
            .toList();
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Split PDF'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _documentId,
            decoration: const InputDecoration(
              labelText: 'PDF file',
              border: OutlineInputBorder(),
            ),
            items: pdfs
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.logicalFilename),
                  ),
                )
                .toList(),
            onChanged: (id) {
              if (id != null) _select(pdfs.firstWhere((item) => item.id == id));
            },
          ),
          const SizedBox(height: 16),
          SegmentedButton<PdfSplitMode>(
            segments: const [
              ButtonSegment(
                value: PdfSplitMode.extract,
                label: Text('Extract'),
              ),
              ButtonSegment(
                value: PdfSplitMode.separate,
                label: Text('Separate'),
              ),
              ButtonSegment(value: PdfSplitMode.remove, label: Text('Remove')),
            ],
            selected: {_mode},
            onSelectionChanged: (value) => setState(() => _mode = value.first),
          ),
          const SizedBox(height: 16),
          if (_busy && _pageCount == 0)
            const Center(child: CircularProgressIndicator()),
          if (_pageCount > 0) ...[
            Text('Select pages • $_pageCount total'),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: _pageCount,
              itemBuilder: (context, index) {
                final page = index + 1;
                return FilterChip(
                  label: Text('$page'),
                  selected: _selectedPages.contains(page),
                  onSelected: (selected) => setState(() {
                    selected
                        ? _selectedPages.add(page)
                        : _selectedPages.remove(page);
                  }),
                );
              },
            ),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _busy || _selectedPages.isEmpty ? null : _split,
          icon: _busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.call_split),
          label: Text(_busy ? 'Processing locally…' : 'Create and save PDF'),
        ),
      ),
    );
  }
}

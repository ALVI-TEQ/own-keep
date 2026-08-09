import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class OcrScanTextScreen extends ConsumerStatefulWidget {
  const OcrScanTextScreen({super.key, required this.documentId});

  final String? documentId;

  @override
  ConsumerState<OcrScanTextScreen> createState() => _OcrScanTextScreenState();
}

class _OcrScanTextScreenState extends ConsumerState<OcrScanTextScreen> {
  String _query = '';
  bool _runningOcr = false;

  Future<void> _runOcr() async {
    final id = widget.documentId;
    final controller = ref.read(ingestionControllerProvider);
    if (id == null || controller == null || _runningOcr) return;
    setState(() => _runningOcr = true);
    try {
      await controller.reprocessDocument(id);
      ref.invalidate(documentDetailProvider(id));
    } finally {
      if (mounted) setState(() => _runningOcr = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final id = widget.documentId;
    final document = id == null
        ? null
        : ref.watch(documentDetailProvider(id)).value;
    final pages =
        document?.textPages
            .where((page) => page.text.trim().isNotEmpty)
            .toList() ??
        const [];
    final query = _query.trim().toLowerCase();
    final visiblePages = query.isEmpty
        ? pages
        : pages
              .where((page) => page.text.toLowerCase().contains(query))
              .toList();
    final allText = pages.map((page) => page.text.trim()).join('\n\n');

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Extracted Text'),
            Text(
              'Private on-device OCR',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: document == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
              children: [
                Text(
                  document.summary.logicalFilename,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _statChip(
                      colors,
                      Icons.description_outlined,
                      '${pages.length} pages',
                    ),
                    const SizedBox(width: 8),
                    _statChip(
                      colors,
                      Icons.text_fields,
                      '${allText.length} characters',
                    ),
                  ],
                ),
                if (document.fields.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Key information',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: document.fields
                        .where((field) => field.effectiveValue.isNotEmpty)
                        .map(
                          (field) => Container(
                            constraints: const BoxConstraints(minWidth: 150),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colors.surfacePrimary,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: colors.borderSoft),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  field.type.displayName,
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SelectableText(
                                  field.effectiveValue,
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Search inside extracted text',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () => setState(() => _query = ''),
                            icon: const Icon(Icons.close),
                          ),
                    filled: true,
                    fillColor: colors.surfacePrimary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.borderSoft),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (pages.isEmpty)
                  _emptyState(colors)
                else if (visiblePages.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'No extracted text matches “$_query”.',
                        style: TextStyle(color: colors.textSecondary),
                      ),
                    ),
                  )
                else
                  ...visiblePages.map(
                    (page) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: colors.borderSoft),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.article_outlined,
                                color: colors.primaryBlue,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Page ${page.pageNumber ?? pages.indexOf(page) + 1}',
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                tooltip: 'Copy page',
                                onPressed: () => Clipboard.setData(
                                  ClipboardData(text: page.text.trim()),
                                ),
                                icon: const Icon(Icons.copy_outlined, size: 19),
                              ),
                            ],
                          ),
                          Divider(color: colors.borderSoft),
                          SelectableText(
                            _formatText(page.text),
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: colors.successGreen,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Text extraction stays on this device',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: allText.isEmpty
                      ? null
                      : () async {
                          await Clipboard.setData(ClipboardData(text: allText));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All text copied.')),
                            );
                          }
                        },
                  icon: const Icon(Icons.copy_all_outlined),
                  label: const Text('Copy all'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _runningOcr ? null : _runOcr,
                  icon: _runningOcr
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.document_scanner_outlined),
                  label: Text(_runningOcr ? 'Processing…' : 'Run OCR again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statChip(
    OwnKeepMainColorsTheme colors,
    IconData icon,
    String label,
  ) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: colors.surfacePrimary,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: colors.borderSoft),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: colors.textSecondary),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: colors.textSecondary, fontSize: 12),
        ),
      ],
    ),
  );

  Widget _emptyState(OwnKeepMainColorsTheme colors) => Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: colors.surfacePrimary,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: colors.borderSoft),
    ),
    child: Column(
      children: [
        Icon(
          Icons.text_snippet_outlined,
          color: colors.textSecondary,
          size: 48,
        ),
        const SizedBox(height: 12),
        Text(
          'No extracted text yet',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Run private on-device OCR to make this document searchable.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.textSecondary),
        ),
      ],
    ),
  );

  String _formatText(String text) => text
      .split(RegExp(r'\r?\n'))
      .map((line) => line.trimRight())
      .fold<List<String>>(<String>[], (output, line) {
        if (line.trim().isEmpty && (output.isEmpty || output.last.isEmpty)) {
          return output;
        }
        output.add(line.trim());
        return output;
      })
      .join('\n')
      .trim();
}

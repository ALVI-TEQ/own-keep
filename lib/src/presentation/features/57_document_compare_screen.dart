import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class DocumentCompareScreen extends ConsumerStatefulWidget {
  const DocumentCompareScreen({super.key});

  @override
  ConsumerState<DocumentCompareScreen> createState() =>
      _DocumentCompareScreenState();
}

class _DocumentCompareScreenState extends ConsumerState<DocumentCompareScreen> {
  String? _firstId;
  String? _secondId;
  bool _loading = false;
  _Comparison? _comparison;

  Future<void> _compare() async {
    final firstId = _firstId;
    final secondId = _secondId;
    if (firstId == null || secondId == null || firstId == secondId) return;
    setState(() => _loading = true);
    try {
      final values = await Future.wait([
        ref.read(documentDetailProvider(firstId).future),
        ref.read(documentDetailProvider(secondId).future),
      ]);
      if (!mounted) return;
      final first = values[0];
      final second = values[1];
      setState(() {
        _comparison = first == null || second == null
            ? null
            : _Comparison.from(first, second);
      });
    } finally {
      if (mounted) setState(() => _loading = false);
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
        title: const Text('Compare documents'),
      ),
      body: documents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Select two encrypted records. Comparison runs locally using saved metadata and OCR text.',
            ),
            const SizedBox(height: 20),
            _picker('Version A', _firstId, items, (value) {
              setState(() {
                _firstId = value;
                _comparison = null;
              });
            }),
            const SizedBox(height: 12),
            _picker('Version B', _secondId, items, (value) {
              setState(() {
                _secondId = value;
                _comparison = null;
              });
            }),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed:
                  _loading ||
                      _firstId == null ||
                      _secondId == null ||
                      _firstId == _secondId
                  ? null
                  : _compare,
              icon: _loading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.compare_arrows),
              label: const Text('Compare locally'),
            ),
            if (_comparison case final comparison?) ...[
              const SizedBox(height: 24),
              Text(
                comparison.differences.isEmpty
                    ? 'No differences found'
                    : '${comparison.differences.length} differences found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...comparison.differences.map(
                (difference) => Card(
                  color: colors.surfacePrimary,
                  child: ListTile(
                    leading: const Icon(Icons.change_circle_outlined),
                    title: Text(difference.label),
                    subtitle: Text(
                      'A: ${difference.first}\nB: ${difference.second}',
                    ),
                  ),
                ),
              ),
              if (comparison.onlyInFirst.isNotEmpty ||
                  comparison.onlyInSecond.isNotEmpty)
                Card(
                  color: colors.surfacePrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OCR text changes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (comparison.onlyInFirst.isNotEmpty)
                          Text(
                            'Removed:\n${comparison.onlyInFirst.take(20).join('\n')}',
                          ),
                        if (comparison.onlyInSecond.isNotEmpty)
                          Text(
                            'Added:\n${comparison.onlyInSecond.take(20).join('\n')}',
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _picker(
    String label,
    String? value,
    List<DocumentListItemView> items,
    ValueChanged<String?> onChanged,
  ) => DropdownButtonFormField<String>(
    initialValue: value,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items
        .map(
          (item) => DropdownMenuItem(
            value: item.id,
            child: Text(
              item.logicalFilename.isEmpty ? 'Untitled' : item.logicalFilename,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList(),
    onChanged: onChanged,
  );
}

final class _Difference {
  const _Difference(this.label, this.first, this.second);
  final String label;
  final String first;
  final String second;
}

final class _Comparison {
  const _Comparison({
    required this.differences,
    required this.onlyInFirst,
    required this.onlyInSecond,
  });

  factory _Comparison.from(
    DocumentDetailView first,
    DocumentDetailView second,
  ) {
    final differences = <_Difference>[];
    void compare(String label, String a, String b) {
      if (a.trim() != b.trim()) differences.add(_Difference(label, a, b));
    }

    compare(
      'Filename',
      first.summary.logicalFilename,
      second.summary.logicalFilename,
    );
    compare(
      'Document type',
      first.summary.documentType.displayName,
      second.summary.documentType.displayName,
    );
    compare('MIME type', first.summary.mimeType, second.summary.mimeType);
    final firstFields = {
      for (final field in first.fields) field.type.name: field.effectiveValue,
    };
    final secondFields = {
      for (final field in second.fields) field.type.name: field.effectiveValue,
    };
    for (final key in {...firstFields.keys, ...secondFields.keys}) {
      compare(key, firstFields[key] ?? '—', secondFields[key] ?? '—');
    }
    final firstLines = _textLines(first).toSet();
    final secondLines = _textLines(second).toSet();
    return _Comparison(
      differences: differences,
      onlyInFirst: firstLines.difference(secondLines).toList(),
      onlyInSecond: secondLines.difference(firstLines).toList(),
    );
  }

  final List<_Difference> differences;
  final List<String> onlyInFirst;
  final List<String> onlyInSecond;

  static List<String> _textLines(DocumentDetailView document) => document
      .textPages
      .expand((page) => page.text.split(RegExp(r'\r?\n')))
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
}

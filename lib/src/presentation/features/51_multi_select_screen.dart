import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import '../dashboard/dashboard_document_presentation.dart';

class MultiSelectScreen extends ConsumerStatefulWidget {
  const MultiSelectScreen({super.key, this.collectionName, this.initialKind});

  final String? collectionName;
  final String? initialKind;

  @override
  ConsumerState<MultiSelectScreen> createState() => _MultiSelectScreenState();
}

class _MultiSelectScreenState extends ConsumerState<MultiSelectScreen> {
  final _selectedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final documents = ref.watch(allDocumentsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.close, width: 24),
          onPressed: () => context.pop(),
        ),
        title: Text('${_selectedIds.length} selected'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: documents.value == null
                ? null
                : () => setState(() {
                    final all = documents.value!
                        .where(_matchesInitialKind)
                        .map((item) => item.id)
                        .toSet();
                    _selectedIds
                      ..clear()
                      ..addAll(
                        _selectedIds.length == all.length ? const [] : all,
                      );
                  }),
            child: const Text('All'),
          ),
        ],
      ),
      body: documents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Unable to load documents: $error')),
        data: (allItems) {
          final items = allItems.where(_matchesInitialKind).toList();
          return items.isEmpty
              ? const Center(child: Text('No documents available.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(OwnKeepSpacing.md),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final selected = _selectedIds.contains(item.id);
                    return Card(
                      color: selected
                          ? colors.surfaceSelected
                          : colors.surfacePrimary,
                      child: CheckboxListTile(
                        value: selected,
                        onChanged: (_) => setState(() {
                          selected
                              ? _selectedIds.remove(item.id)
                              : _selectedIds.add(item.id);
                        }),
                        secondary: SvgPicture.asset(
                          dashboardDocumentIcon(item),
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            colors.primaryBlue,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(item.logicalFilename),
                        subtitle: Text(item.mimeType),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OwnKeepSpacing.md),
          child: Row(
            children: [
              if (widget.collectionName != null) ...[
                Expanded(
                  child: FilledButton(
                    onPressed: _selectedIds.isEmpty ? null : _addToCollection,
                    child: const Text('Add'),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: OutlinedButton(
                  onPressed: _selectedIds.length == 1
                      ? () => context.push(
                          '/features/move-or-copy?id=${Uri.encodeQueryComponent(_selectedIds.single)}',
                        )
                      : null,
                  child: const Text('Move'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: _selectedIds.isEmpty ? null : _exportSelected,
                  child: const Text('Export'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.dangerRed,
                  ),
                  onPressed: _selectedIds.isEmpty ? null : _trashSelected,
                  child: const Text('Trash'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _matchesInitialKind(DocumentListItemView item) {
    final kind = widget.initialKind;
    if (kind == null) return true;
    final mimeType = item.mimeType.toString().toLowerCase();
    return switch (kind) {
      'media' => mimeType.startsWith('image/') || mimeType.startsWith('video/'),
      'documents' =>
        !mimeType.startsWith('image/') && !mimeType.startsWith('video/'),
      _ => true,
    };
  }

  Future<void> _exportSelected() async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    var exported = 0;
    var cancelled = 0;
    for (final id in _selectedIds.toList()) {
      final detail = await ref.read(documentDetailProvider(id).future);
      if (detail == null) continue;
      final message = await controller.exportDocument(detail);
      if (message.startsWith('Document copy saved')) {
        exported++;
      } else {
        cancelled++;
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          cancelled == 0
              ? '$exported item(s) exported.'
              : '$exported item(s) exported; $cancelled skipped or failed.',
        ),
      ),
    );
  }

  Future<void> _trashSelected() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Move selected items to trash?'),
        content: Text('${_selectedIds.length} item(s) can be restored later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Move'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref
        .read(ingestionControllerProvider)
        ?.moveDocumentsToTrash(_selectedIds);
    ref.invalidate(allDocumentsProvider);
    if (mounted) setState(_selectedIds.clear);
  }

  Future<void> _addToCollection() async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null || widget.collectionName == null) return;
    for (final id in _selectedIds) {
      final detail = await ref.read(documentDetailProvider(id).future);
      if (detail == null) continue;
      await controller.replaceTags(
        id,
        <String>{
          ...detail.summary.tags.map((tag) => tag.name),
          widget.collectionName!,
        }.toList(),
      );
    }
    ref.invalidate(allDocumentsProvider);
    if (mounted) context.pop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class DuplicateResolutionScreen extends ConsumerStatefulWidget {
  const DuplicateResolutionScreen({super.key, required this.documentIds});

  final List<String> documentIds;

  @override
  ConsumerState<DuplicateResolutionScreen> createState() =>
      _DuplicateResolutionScreenState();
}

class _DuplicateResolutionScreenState
    extends ConsumerState<DuplicateResolutionScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final documents = ref.watch(allDocumentsProvider).value ?? const [];
    final candidates = documents
        .where((item) => widget.documentIds.contains(item.id))
        .toList();
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Resolve Duplicates'),
      ),
      body: candidates.length < 2
          ? const Center(child: Text('Two valid documents are required.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: candidates.length,
              itemBuilder: (context, index) => Card(
                color: colors.surfacePrimary,
                child: RadioListTile<int>(
                  value: index,
                  groupValue: _selectedIndex,
                  onChanged: (value) =>
                      setState(() => _selectedIndex = value ?? 0),
                  title: Text(candidates[index].logicalFilename),
                  subtitle: Text(
                    '${candidates[index].mimeType} • ${candidates[index].importedAt.toLocal()}',
                  ),
                ),
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: candidates.length < 2
                ? null
                : () => _keepSelected(candidates),
            child: const Text('Keep selected; move others to trash'),
          ),
        ),
      ),
    );
  }

  Future<void> _keepSelected(List<dynamic> candidates) async {
    final keepId = candidates[_selectedIndex].id as String;
    final trashIds = candidates
        .map((item) => item.id as String)
        .where((id) => id != keepId);
    await ref.read(ingestionControllerProvider)?.moveDocumentsToTrash(trashIds);
    ref.invalidate(allDocumentsProvider);
    if (mounted) context.pop();
  }
}

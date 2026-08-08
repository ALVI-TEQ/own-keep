import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class AutoTaggingScreen extends ConsumerStatefulWidget {
  const AutoTaggingScreen({super.key});

  @override
  ConsumerState<AutoTaggingScreen> createState() => _AutoTaggingScreenState();
}

class _AutoTaggingScreenState extends ConsumerState<AutoTaggingScreen> {
  final _selectedIds = <String>{};
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final documentsAsync = ref.watch(allDocumentsProvider);
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Review Auto Tags'),
      ),
      body: documentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Unable to load documents: $error')),
        data: (documents) {
          final suggestions = documents
              .map((document) => (document, suggestedTagsForDocument(document)))
              .where((entry) => entry.$2.isNotEmpty)
              .toList();
          if (!_initialized) {
            _initialized = true;
            _selectedIds.addAll(suggestions.map((entry) => entry.$1.id));
          }
          if (suggestions.isEmpty) {
            return const Center(child: Text('No tag suggestions available.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final document = suggestions[index].$1;
              final tags = suggestions[index].$2;
              return Card(
                color: colors.surfacePrimary,
                child: CheckboxListTile(
                  value: _selectedIds.contains(document.id),
                  onChanged: (_) => setState(() {
                    _selectedIds.contains(document.id)
                        ? _selectedIds.remove(document.id)
                        : _selectedIds.add(document.id);
                  }),
                  title: Text(document.logicalFilename),
                  subtitle: Text(tags.map((tag) => '#$tag').join('  ')),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _selectedIds.isEmpty ? null : _applyTags,
            child: Text('Apply to ${_selectedIds.length} document(s)'),
          ),
        ),
      ),
    );
  }

  Future<void> _applyTags() async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    for (final id in _selectedIds) {
      final detail = await ref.read(documentDetailProvider(id).future);
      if (detail == null) continue;
      await controller.replaceTags(
        id,
        <String>{
          ...detail.summary.tags.map((tag) => tag.name),
          ...suggestedTagsForDocument(detail.summary),
        }.toList(),
      );
    }
    ref.invalidate(allDocumentsProvider);
    if (mounted) context.pop();
  }
}

List<String> suggestedTagsForDocument(DocumentListItemView document) =>
    switch (document.documentType) {
      DocumentType.aadhaar ||
      DocumentType.pan ||
      DocumentType.voterId => const ['identity', 'important'],
      DocumentType.passport => const ['identity', 'travel', 'important'],
      DocumentType.drivingLicence => const ['identity', 'vehicle'],
      DocumentType.bankStatement ||
      DocumentType.invoice ||
      DocumentType.receipt => const ['finance'],
      DocumentType.insurancePolicy => const ['insurance', 'important'],
      DocumentType.medicalReport ||
      DocumentType.prescription => const ['health'],
      DocumentType.propertyTax => const ['property', 'finance'],
      DocumentType.vehicleDocument => const ['vehicle'],
      DocumentType.educationCertificate => const ['education'],
      _ => const <String>[],
    };

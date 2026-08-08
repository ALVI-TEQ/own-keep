import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SmartSuggestionsScreen extends ConsumerStatefulWidget {
  const SmartSuggestionsScreen({super.key});

  @override
  ConsumerState<SmartSuggestionsScreen> createState() =>
      _SmartSuggestionsScreenState();
}

class _SmartSuggestionsScreenState
    extends ConsumerState<SmartSuggestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final controller = ref.watch(ingestionControllerProvider);
    final suggestions = controller?.attentionItems ?? const [];
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Smart Suggestions'),
      ),
      body: suggestions.isEmpty
          ? const Center(child: Text('No suggestions need your attention.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return Card(
                  color: colors.surfacePrimary,
                  child: ListTile(
                    title: Text(suggestion.title),
                    subtitle: Text(suggestion.explanation),
                    leading: CircleAvatar(
                      child: Text('${suggestion.priority}'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (action) async {
                        if (action == 'task') {
                          await controller?.createTaskFromAttention(
                            suggestion.id,
                          );
                        } else {
                          await controller?.dismissAttention(suggestion.id);
                        }
                        if (mounted) setState(() {});
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'task',
                          child: Text('Create task'),
                        ),
                        PopupMenuItem(value: 'dismiss', child: Text('Dismiss')),
                      ],
                    ),
                    onTap: suggestion.evidenceDocumentId == null
                        ? null
                        : () => context.push(
                            '/features/document-preview?id=${Uri.encodeQueryComponent(suggestion.evidenceDocumentId!)}',
                          ),
                  ),
                );
              },
            ),
    );
  }
}

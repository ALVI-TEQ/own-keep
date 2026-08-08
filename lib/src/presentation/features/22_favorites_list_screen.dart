import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import '../dashboard/dashboard_document_presentation.dart';

class FavoritesListScreen extends ConsumerStatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  ConsumerState<FavoritesListScreen> createState() =>
      _FavoritesListScreenState();
}

class _FavoritesListScreenState extends ConsumerState<FavoritesListScreen> {
  DashboardFileKind _kind = DashboardFileKind.all;

  Future<void> _removeFavorite(String id) async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    await controller.setFavourite(id, false);
    ref.invalidate(favoriteDocumentsProvider);
    ref.invalidate(allDocumentsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoriteDocumentsProvider);
    final filters = <(String, DashboardFileKind)>[
      (l10n.common_all, DashboardFileKind.all),
      (l10n.common_documents, DashboardFileKind.documents),
      (l10n.common_images, DashboardFileKind.images),
      (l10n.common_others, DashboardFileKind.other),
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, width: 24),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.s22_title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.search, width: 24),
            onPressed: () => context.push('/dashboard/search'),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = filters[index];
                final selected = filter.$2 == _kind;
                return ChoiceChip(
                  label: Text(filter.$1),
                  selected: selected,
                  onSelected: (_) => setState(() => _kind = filter.$2),
                  selectedColor: colors.primaryBlue,
                  backgroundColor: colors.surfacePrimary,
                  side: BorderSide(
                    color: selected ? colors.primaryBlue : colors.borderSoft,
                  ),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : colors.textSecondary,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: favorites.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Could not load favorites.',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
              data: (allFavorites) {
                final documents = allFavorites
                    .where((doc) => documentMatchesKind(doc, _kind))
                    .toList();
                if (documents.isEmpty) {
                  return Center(
                    child: Text(
                      'No favorites in this category.',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(OwnKeepSpacing.lg),
                  itemCount: documents.length,
                  separatorBuilder: (_, _) => Divider(color: colors.borderSoft),
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return ListTile(
                      onTap: () => context.push(
                        '/features/document-preview?id=${document.id}',
                      ),
                      leading: SvgPicture.asset(
                        dashboardDocumentIcon(document),
                        width: 28,
                      ),
                      title: Text(
                        document.logicalFilename.isEmpty
                            ? 'Untitled'
                            : document.logicalFilename,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(document.documentType.displayName),
                      trailing: IconButton(
                        tooltip: 'Remove from favorites',
                        onPressed: () => _removeFavorite(document.id),
                        icon: SvgPicture.asset(
                          OwnKeepMainIcons.favorite,
                          width: 20,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

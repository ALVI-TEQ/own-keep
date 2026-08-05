import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;
    
    final favDocsAsync = ref.watch(favoriteDocumentsProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.surfacePrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.borderSoft),
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.backArrow,
                          colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.s15_title,
                                style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SvgPicture.asset(
                                OwnKeepMainIcons.favorite,
                                colorFilter: ColorFilter.mode(colors.favoriteYellow, BlendMode.srcIn),
                                width: 24,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s15_subtitle,
                            style: TextStyle(color: colors.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.searchBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.borderSoft),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.search,
                        colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                        width: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.s15_search_hint,
                        style: TextStyle(color: colors.textMuted, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Favorites List
              Expanded(
                child: favDocsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Failed to load favorites', style: TextStyle(color: colors.textSecondary))),
                  data: (docs) {
                    if (docs.isEmpty) {
                      return Center(child: Text('No favorites yet', style: TextStyle(color: colors.textSecondary)));
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.9,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        return _buildFavoriteCard(
                          context,
                          doc.logicalFilename.isNotEmpty ? doc.logicalFilename : 'Untitled',
                          doc.documentType.toString().split('.').last, // Just for testing
                          OwnKeepMainIcons.filePdf, // Map actual icons later
                          colors.dangerRed,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, String title, String meta, String iconPath, Color iconColor) {
    final colors = context.mainColors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  width: 24,
                ),
              ),
              SvgPicture.asset(
                OwnKeepMainIcons.favorite,
                colorFilter: ColorFilter.mode(colors.favoriteYellow, BlendMode.srcIn),
                width: 20,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            meta,
            style: TextStyle(color: colors.textMuted, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

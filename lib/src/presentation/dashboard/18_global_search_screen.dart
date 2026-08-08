import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import 'dashboard_document_presentation.dart';

class GlobalSearchScreen extends ConsumerStatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  ConsumerState<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends ConsumerState<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  DashboardFileKind _selectedKind = DashboardFileKind.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          colorFilter: ColorFilter.mode(
                            colors.textPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.s18_title,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s18_subtitle,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Search Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.searchBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.primaryBlue),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.search,
                        colorFilter: ColorFilter.mode(
                          colors.primaryBlue,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: l10n.s18_query,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: colors.textMuted,
                              fontSize: 16,
                            ),
                          ),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 16,
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colors.borderSoft,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: colors.textPrimary,
                              size: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Filters
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildFilterChip(
                      l10n.s18_search_everywhere,
                      DashboardFileKind.all,
                    ),
                    _buildFilterChip(
                      l10n.filter_documents,
                      DashboardFileKind.documents,
                    ),
                    _buildFilterChip(
                      l10n.filter_notes,
                      DashboardFileKind.notes,
                    ),
                    _buildFilterChip(
                      l10n.filter_images,
                      DashboardFileKind.images,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: _searchController.text.isEmpty
                    ? Center(
                        child: Text(
                          'Type to search globally',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      )
                    : ref
                          .watch(
                            searchDocumentsProvider(_searchController.text),
                          )
                          .when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => Center(
                              child: Text(
                                'Search failed',
                                style: TextStyle(color: colors.textSecondary),
                              ),
                            ),
                            data: (allDocs) {
                              final docs = allDocs
                                  .where(
                                    (doc) =>
                                        documentMatchesKind(doc, _selectedKind),
                                  )
                                  .toList();
                              if (docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No results found',
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final doc = docs[index];
                                  return _buildResultItem(
                                    context,
                                    doc.id,
                                    doc.logicalFilename.isNotEmpty
                                        ? doc.logicalFilename
                                        : 'Untitled',
                                    doc.documentType.displayName,
                                    dashboardDocumentIcon(doc),
                                    colors.primaryBlue,
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

  Widget _buildFilterChip(String label, DashboardFileKind kind) {
    final colors = context.mainColors;
    final isSelected = _selectedKind == kind;
    return GestureDetector(
      onTap: () => setState(() => _selectedKind = kind),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : colors.textPrimary,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(
    BuildContext context,
    String documentId,
    String title,
    String meta,
    String iconPath,
    Color iconColor,
  ) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: () => context.push('/features/document-preview?id=$documentId'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meta,
                    style: TextStyle(color: colors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

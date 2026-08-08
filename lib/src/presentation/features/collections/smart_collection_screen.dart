import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../../theme/ownkeep_main_colors.dart';
import '../../../theme/ownkeep_main_icons.dart';
import '../../../providers/document_provider.dart';
import 'package:vault_domain/vault_domain.dart';
import '../../dashboard/dashboard_document_presentation.dart';
import 'smart_collection_category.dart';

class SmartCollectionScreen extends ConsumerWidget {
  final SmartCollectionCategory category;

  const SmartCollectionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;
    final accentColor = category.color;
    final documentsAsync = ref.watch(allDocumentsProvider);

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.search,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/dashboard/search'),
          ),
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.add,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/add-item-menu'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        category.icon,
                        colorFilter: ColorFilter.mode(
                          accentColor,
                          BlendMode.srcIn,
                        ),
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title and Subtitle
                    Text(
                      category.getTitle(l10n),
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.getSubtitle(l10n),
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Quick Search Bar
                    GestureDetector(
                      onTap: () => context.push('/dashboard/search'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfacePrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.borderSoft),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              OwnKeepMainIcons.search,
                              colorFilter: ColorFilter.mode(
                                colors.textMuted,
                                BlendMode.srcIn,
                              ),
                              width: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _getSearchHint(category, l10n),
                                style: TextStyle(
                                  color: colors.textMuted,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    documentsAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Text(
                        'Could not load this collection.',
                        style: TextStyle(color: colors.textSecondary),
                      ),
                      data: (allDocuments) {
                        final documents = allDocuments
                            .where(
                              (document) =>
                                  _matchesCategory(document.documentType),
                            )
                            .toList();
                        return Column(
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.2,
                              children: _buildStatCards(documents, colors),
                            ),
                            const SizedBox(height: 32),
                            ..._buildContentSections(
                              context,
                              documents,
                              l10n,
                              colors,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSearchHint(
    SmartCollectionCategory category,
    AppLocalizations l10n,
  ) {
    return l10n.common_search_collection;
  }

  List<Widget> _buildStatCards(
    List<DocumentListItemView> documents,
    OwnKeepMainColorsTheme colors,
  ) {
    final recentCutoff = DateTime.now().subtract(const Duration(days: 30));
    final stats = <Map<String, Object>>[
      {
        'title': 'Documents',
        'value': '${documents.length}',
        'icon': OwnKeepMainIcons.file_doc,
      },
      {
        'title': 'Important',
        'value': '${documents.where((d) => d.isFavourite).length}',
        'icon': OwnKeepMainIcons.reminder,
      },
      {
        'title': 'Recent',
        'value':
            '${documents.where((d) => d.importedAt.isAfter(recentCutoff)).length}',
        'icon': OwnKeepMainIcons.history,
      },
      {
        'title': 'Archived',
        'value': '${documents.where((d) => d.isArchived).length}',
        'icon': OwnKeepMainIcons.archive,
      },
    ];

    return stats
        .map(
          (stat) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfacePrimary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.borderSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      stat['icon'] as String,
                      colorFilter: ColorFilter.mode(
                        colors.primaryBlue,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                    ),
                    Flexible(
                      child: Text(
                        stat['value'] as String,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  stat['title'] as String,
                  style: TextStyle(color: colors.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildContentSections(
    BuildContext context,
    List<DocumentListItemView> documents,
    AppLocalizations l10n,
    OwnKeepMainColorsTheme colors,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Recent Items',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.common_view_all,
            style: TextStyle(color: colors.primaryBlue, fontSize: 14),
          ),
        ],
      ),
      const SizedBox(height: 16),
      if (documents.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'No documents in this collection.',
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
      ...documents
          .take(10)
          .map(
            (document) => GestureDetector(
              onTap: () =>
                  context.push('/features/document-preview?id=${document.id}'),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        dashboardDocumentIcon(document),
                        colorFilter: ColorFilter.mode(
                          category.color,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.logicalFilename.isEmpty
                                ? 'Untitled'
                                : document.logicalFilename,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            document.documentType.displayName,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      OwnKeepMainIcons.chevron_right,
                      colorFilter: ColorFilter.mode(
                        colors.textSecondary,
                        BlendMode.srcIn,
                      ),
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
    ];
  }

  bool _matchesCategory(DocumentType type) => switch (category) {
    SmartCollectionCategory.identity => const {
      DocumentType.aadhaar,
      DocumentType.pan,
      DocumentType.passport,
      DocumentType.drivingLicence,
      DocumentType.voterId,
    }.contains(type),
    SmartCollectionCategory.finance => const {
      DocumentType.bankStatement,
      DocumentType.receipt,
      DocumentType.invoice,
    }.contains(type),
    SmartCollectionCategory.health => const {
      DocumentType.medicalReport,
      DocumentType.prescription,
    }.contains(type),
    SmartCollectionCategory.property => const {
      DocumentType.electricityBill,
      DocumentType.waterBill,
      DocumentType.gasBill,
      DocumentType.propertyTax,
    }.contains(type),
    SmartCollectionCategory.vehicle => type == DocumentType.vehicleDocument,
    SmartCollectionCategory.education =>
      type == DocumentType.educationCertificate,
    SmartCollectionCategory.insurance => type == DocumentType.insurancePolicy,
    SmartCollectionCategory.travel => type == DocumentType.passport,
    SmartCollectionCategory.work => const {
      DocumentType.generalDocument,
      DocumentType.invoice,
    }.contains(type),
  };
}

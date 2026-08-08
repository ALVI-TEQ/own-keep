import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    final docsAsync = ref.watch(allDocumentsProvider);
    final customCollectionsAsync = ref.watch(customCollectionsProvider);

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
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              // Header
              Row(
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
                          l10n.s12_title,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s12_subtitle,
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
              const SizedBox(height: 32),

              // Search
              GestureDetector(
                onTap: () => context.push('/dashboard/search'),
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
                        colorFilter: ColorFilter.mode(
                          colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.s12_search_hint,
                          overflow: TextOverflow.ellipsis,
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

              // Summary
              docsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text('Error loading collections')),
                data: (docs) {
                  int countTypes(Set<String> types) => docs
                      .where((d) => types.contains(d.documentType.storageValue))
                      .length;

                  final personalCount = countTypes(const {
                    'AADHAAR',
                    'PAN',
                    'PASSPORT',
                    'DRIVING_LICENCE',
                    'VOTER_ID',
                  });
                  final financeCount = countTypes(const {
                    'BANK_STATEMENT',
                    'RECEIPT',
                    'INVOICE',
                  });
                  final healthCount = countTypes(const {
                    'MEDICAL_REPORT',
                    'PRESCRIPTION',
                  });
                  final propertyCount = countTypes(const {
                    'ELECTRICITY_BILL',
                    'WATER_BILL',
                    'GAS_BILL',
                    'PROPERTY_TAX',
                  });
                  final vehicleCount = countTypes(const {'VEHICLE_DOCUMENT'});
                  final educationCount = countTypes(const {
                    'EDUCATION_CERTIFICATE',
                  });

                  final otherCount =
                      docs.length -
                      (personalCount +
                          financeCount +
                          healthCount +
                          propertyCount +
                          vehicleCount +
                          educationCount);

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              l10n.s12_total_collections,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '6 ${l10n.s12_collection_total.replaceAll('7 ', '')} • ${docs.length} ${l10n.s12_item_total.replaceAll('63 ', '')}',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Collections Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.05,
                        children: [
                          _buildCollectionCard(
                            context,
                            l10n.collection_personal,
                            '$personalCount items',
                            OwnKeepMainIcons.profile,
                            colors.primaryBlue,
                            () => context.push('/collections/identity'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_finance,
                            '$financeCount items',
                            OwnKeepMainIcons.finance,
                            colors.successGreen,
                            () => context.push('/collections/finance'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_health,
                            '$healthCount items',
                            OwnKeepMainIcons.health,
                            colors.dangerRed,
                            () => context.push('/collections/health'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_property,
                            '$propertyCount items',
                            OwnKeepMainIcons.property,
                            colors.warningOrange,
                            () => context.push('/collections/property'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_vehicle,
                            '$vehicleCount items',
                            OwnKeepMainIcons.vehicle,
                            colors.accentCyan,
                            () => context.push('/collections/vehicle'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_education,
                            '$educationCount items',
                            OwnKeepMainIcons.education,
                            colors.aiPurple,
                            () => context.push('/collections/education'),
                          ),
                          _buildCollectionCard(
                            context,
                            l10n.collection_others,
                            '${otherCount > 0 ? otherCount : 0} items',
                            OwnKeepMainIcons.collections,
                            colors.favoriteYellow,
                            () {
                              final current = ref.read(
                                dashboardDocumentFilterProvider,
                              );
                              ref
                                  .read(
                                    dashboardDocumentFilterProvider.notifier,
                                  )
                                  .update(
                                    current.copyWith(
                                      kind: DashboardFileKind.other,
                                    ),
                                  );
                              context.push('/dashboard/all-files');
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Custom collections',
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => context.push('/collections/custom/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('Create'),
                  ),
                ],
              ),
              customCollectionsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text(
                  'Could not load custom collections.',
                  style: TextStyle(color: colors.textSecondary),
                ),
                data: (collections) {
                  if (collections.isEmpty) {
                    return Text(
                      'No custom collections yet.',
                      style: TextStyle(color: colors.textSecondary),
                    );
                  }
                  final documents = docsAsync.value ?? const [];
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.05,
                    children: collections.map((collection) {
                      final count = documents
                          .where(
                            (document) => document.tags.any(
                              (tag) =>
                                  tag.name.toLowerCase() ==
                                  collection.name.toLowerCase(),
                            ),
                          )
                          .length;
                      return _buildCollectionCard(
                        context,
                        collection.name,
                        '$count items',
                        collection.iconKey,
                        Color(collection.colorValue),
                        () => context.push(
                          '/collections/custom/${collection.id}',
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(
    BuildContext context,
    String title,
    String count,
    String iconPath,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(color: colors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

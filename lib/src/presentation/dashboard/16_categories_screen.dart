import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    final docsAsync = ref.watch(allDocumentsProvider);

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
              GestureDetector(
                onTap: () => context.push('/dashboard/search'),
                child: Padding(
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
                              l10n.s16_title,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.s16_subtitle,
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
                        colorFilter: ColorFilter.mode(
                          colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.s16_search_hint,
                          style: TextStyle(
                            color: colors.textMuted,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Categories List
              Expanded(
                child: docsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('Error loading categories')),
                  data: (docs) {
                    int countTypes(Set<String> types) => docs
                        .where(
                          (d) => types.contains(d.documentType.storageValue),
                        )
                        .length;

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      children: [
                        _buildCategoryItem(
                          context,
                          l10n.collection_identity,
                          '${countTypes(const {'AADHAAR', 'PAN', 'PASSPORT', 'DRIVING_LICENCE', 'VOTER_ID'})} items',
                          OwnKeepMainIcons.identity,
                          colors.dangerRed,
                          () => context.push('/collections/identity'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_finance,
                          '${countTypes(const {'BANK_STATEMENT', 'RECEIPT', 'INVOICE'})} items',
                          OwnKeepMainIcons.finance,
                          colors.successGreen,
                          () => context.push('/collections/finance'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_insurance,
                          '${countTypes(const {'INSURANCE_POLICY'})} items',
                          OwnKeepMainIcons.insurance,
                          colors.primaryBlue,
                          () => context.push('/collections/insurance'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_health,
                          '${countTypes(const {'MEDICAL_REPORT', 'PRESCRIPTION'})} items',
                          OwnKeepMainIcons.health,
                          colors.healthPink,
                          () => context.push('/collections/health'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_property,
                          '${countTypes(const {'ELECTRICITY_BILL', 'WATER_BILL', 'GAS_BILL', 'PROPERTY_TAX'})} items',
                          OwnKeepMainIcons.property,
                          colors.warningOrange,
                          () => context.push('/collections/property'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_vehicle,
                          '${countTypes(const {'VEHICLE_DOCUMENT', 'DRIVING_LICENCE'})} items',
                          OwnKeepMainIcons.vehicle,
                          colors.accentCyan,
                          () => context.push('/collections/vehicle'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_education,
                          '${countTypes(const {'EDUCATION_CERTIFICATE'})} items',
                          OwnKeepMainIcons.education,
                          colors.aiPurple,
                          () => context.push('/collections/education'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_work,
                          '${countTypes(const {'GENERAL_DOCUMENT', 'INVOICE'})} items',
                          OwnKeepMainIcons.work,
                          colors.primaryBlue,
                          () => context.push('/collections/work'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_personal,
                          '${countTypes(const {'NOTE', 'PASSWORD'})} items',
                          OwnKeepMainIcons.profile,
                          colors.successGreen,
                          () => context.push('/dashboard/all-files'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_travel,
                          '${countTypes(const {'PASSPORT'})} items',
                          OwnKeepMainIcons.travel,
                          colors.warningOrange,
                          () => context.push('/collections/travel'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_family,
                          '0 items',
                          OwnKeepMainIcons.family,
                          colors.healthPink,
                          () => context.push('/dashboard/all-files'),
                        ),
                        _buildCategoryItem(
                          context,
                          l10n.collection_important,
                          '${docs.where((d) => d.isFavourite).length} items',
                          OwnKeepMainIcons.favorite,
                          colors.dangerRed,
                          () => context.push('/dashboard/favorites'),
                        ),
                      ],
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

  Widget _buildCategoryItem(
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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
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
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              count,
              style: TextStyle(color: colors.textMuted, fontSize: 14),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              OwnKeepMainIcons.chevronRight,
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}

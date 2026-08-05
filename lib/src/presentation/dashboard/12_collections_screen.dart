import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;
    
    final controller = ref.watch(ingestionControllerProvider);

    if (controller == null) {
      return Scaffold(backgroundColor: colors.backgroundTop);
    }

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
                        Text(
                          l10n.s12_title,
                          style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s12_subtitle,
                          style: TextStyle(color: colors.textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Search
              Container(
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
                      l10n.s12_search_hint,
                      style: TextStyle(color: colors.textMuted, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Summary
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  final docs = controller.dashboardDocuments;
                  
                  int getCount(String tag) => docs.where((d) => d.tags.any((t) => t.name.toLowerCase() == tag.toLowerCase())).length;
                  
                  final personalCount = getCount('personal');
                  final financeCount = getCount('finance');
                  final healthCount = getCount('health');
                  final propertyCount = getCount('property');
                  final vehicleCount = getCount('vehicle');
                  final educationCount = getCount('education');
                  // Others could be docs with no recognized tag
                  final otherCount = docs.where((d) => d.tags.isEmpty).length;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.s12_total_collections, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                          Text('7 ${l10n.s12_collection_total.replaceAll('7 ', '')} • ${docs.length} ${l10n.s12_item_total.replaceAll('63 ', '')}', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
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
                        childAspectRatio: 1.2,
                        children: [
                          _buildCollectionCard(context, l10n.collection_personal, '$personalCount items', OwnKeepMainIcons.profile, colors.primaryBlue, () => context.push('/collections/identity')),
                          _buildCollectionCard(context, l10n.collection_finance, '$financeCount items', OwnKeepMainIcons.finance, colors.successGreen, () => context.push('/collections/finance')),
                          _buildCollectionCard(context, l10n.collection_health, '$healthCount items', OwnKeepMainIcons.health, colors.dangerRed, () => context.push('/collections/health')),
                          _buildCollectionCard(context, l10n.collection_property, '$propertyCount items', OwnKeepMainIcons.property, colors.warningOrange, () => context.push('/collections/property')),
                          _buildCollectionCard(context, l10n.collection_vehicle, '$vehicleCount items', OwnKeepMainIcons.vehicle, colors.accentCyan, () => context.push('/collections/vehicle')),
                          _buildCollectionCard(context, l10n.collection_education, '$educationCount items', OwnKeepMainIcons.education, colors.aiPurple, () => context.push('/collections/education')),
                          _buildCollectionCard(context, l10n.collection_others, '$otherCount items', OwnKeepMainIcons.collections, colors.favoriteYellow, () => context.push('/collections/custom/new')),
                        ],
                      ),
                    ],
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

  Widget _buildCollectionCard(BuildContext context, String title, String count, String iconPath, Color iconColor, VoidCallback onTap) {
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
                  style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
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

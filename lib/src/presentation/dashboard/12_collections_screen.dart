import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.s12_total_collections, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                  Text('${l10n.s12_collection_total} • ${l10n.s12_item_total}', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
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
                  _buildCollectionCard(context, l10n.collection_personal, l10n.s12_personal_count, OwnKeepMainIcons.profile, colors.primaryBlue, () {}),
                  _buildCollectionCard(context, l10n.collection_finance, l10n.s12_finance_count, OwnKeepMainIcons.finance, colors.successGreen, () {}),
                  _buildCollectionCard(context, l10n.collection_health, l10n.s12_health_count, OwnKeepMainIcons.health, colors.dangerRed, () {}),
                  _buildCollectionCard(context, l10n.collection_property, l10n.s12_property_count, OwnKeepMainIcons.property, colors.warningOrange, () {}),
                  _buildCollectionCard(context, l10n.collection_vehicle, l10n.s12_vehicle_count, OwnKeepMainIcons.vehicle, colors.accentCyan, () {}),
                  _buildCollectionCard(context, l10n.collection_education, l10n.s12_education_count, OwnKeepMainIcons.education, colors.aiPurple, () {}),
                  _buildCollectionCard(context, l10n.collection_others, l10n.s12_others_count, OwnKeepMainIcons.collections, colors.favoriteYellow, () {}),
                ],
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

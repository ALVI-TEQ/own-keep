import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
                          Text(
                            l10n.s16_title,
                            style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s16_subtitle,
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
                        l10n.s16_search_hint,
                        style: TextStyle(color: colors.textMuted, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Categories List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildCategoryItem(context, l10n.collection_identity, l10n.s16_identity_count, OwnKeepMainIcons.identity, colors.dangerRed),
                    _buildCategoryItem(context, l10n.collection_finance, l10n.s16_finance_count, OwnKeepMainIcons.finance, colors.successGreen),
                    _buildCategoryItem(context, l10n.collection_insurance, l10n.s16_insurance_count, OwnKeepMainIcons.insurance, colors.primaryBlue),
                    _buildCategoryItem(context, l10n.collection_health, l10n.s16_health_count, OwnKeepMainIcons.health, colors.healthPink),
                    _buildCategoryItem(context, l10n.collection_property, l10n.s16_property_count, OwnKeepMainIcons.property, colors.warningOrange),
                    _buildCategoryItem(context, l10n.collection_vehicle, l10n.s16_vehicle_count, OwnKeepMainIcons.vehicle, colors.accentCyan),
                    _buildCategoryItem(context, l10n.collection_education, l10n.s16_education_count, OwnKeepMainIcons.education, colors.aiPurple),
                    _buildCategoryItem(context, l10n.collection_work, l10n.s16_work_count, OwnKeepMainIcons.work, colors.primaryBlue),
                    _buildCategoryItem(context, l10n.collection_personal, l10n.s16_personal_count, OwnKeepMainIcons.profile, colors.successGreen),
                    _buildCategoryItem(context, l10n.collection_travel, l10n.s16_travel_count, OwnKeepMainIcons.travel, colors.warningOrange),
                    _buildCategoryItem(context, l10n.collection_family, l10n.s16_family_count, OwnKeepMainIcons.family, colors.healthPink),
                    _buildCategoryItem(context, l10n.collection_important, l10n.s16_important_count, OwnKeepMainIcons.favorite, colors.dangerRed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, String count, String iconPath, Color iconColor) {
    final colors = context.mainColors;
    return Container(
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
              style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
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
    );
  }
}

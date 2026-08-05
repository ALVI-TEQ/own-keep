import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class TagManagerScreen extends StatelessWidget {
  const TagManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final smartTags = [
      {'icon': OwnKeepMainIcons.identity, 'title': l10n.s28_identity, 'count': l10n.s28_identity_count},
      {'icon': OwnKeepMainIcons.finance, 'title': l10n.s28_finance, 'count': l10n.s28_finance_count},
      {'icon': OwnKeepMainIcons.insurance, 'title': l10n.s28_insurance, 'count': l10n.s28_insurance_count},
      {'icon': OwnKeepMainIcons.health, 'title': l10n.s28_health, 'count': l10n.s28_health_count},
      {'icon': OwnKeepMainIcons.property, 'title': l10n.s28_property, 'count': l10n.s28_property_count},
      {'icon': OwnKeepMainIcons.vehicle, 'title': l10n.s28_vehicle, 'count': l10n.s28_vehicle_count},
      {'icon': OwnKeepMainIcons.work, 'title': l10n.s28_work, 'count': l10n.s28_work_count},
      {'icon': OwnKeepMainIcons.important, 'title': l10n.s28_important, 'count': l10n.s28_important_count},
    ];

    final customTags = [
      {'icon': OwnKeepMainIcons.travel, 'title': l10n.s28_travel, 'count': l10n.s28_travel_count},
      {'icon': OwnKeepMainIcons.education, 'title': l10n.s28_education, 'count': l10n.s28_education_count},
      {'icon': OwnKeepMainIcons.profile, 'title': l10n.s28_personal, 'count': l10n.s28_personal_count},
      {'icon': OwnKeepMainIcons.family, 'title': l10n.s28_family, 'count': l10n.s28_family_count},
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s28_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.add, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.s28_search,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Smart Tags Section
            _buildSectionHeader(l10n.s28_smart_tags, l10n.s28_smart_count, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            ...smartTags.map((tag) => Padding(
              padding: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
              child: _buildTagRow(colors, tag['icon']!, tag['title']!, tag['count']!),
            )),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Custom Tags Section
            _buildSectionHeader(l10n.s28_custom_tags, l10n.s28_custom_count, colors),
            const SizedBox(height: OwnKeepSpacing.md),
            ...customTags.map((tag) => Padding(
              padding: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
              child: _buildTagRow(colors, tag['icon']!, tag['title']!, tag['count']!),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String count, OwnKeepMainColorsTheme colors) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colors.surfaceSelected,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagRow(OwnKeepMainColorsTheme colors, String icon, String title, String count) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(OwnKeepMainIcons.more_vertical, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

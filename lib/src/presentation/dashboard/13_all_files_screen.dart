import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AllFilesScreen extends StatelessWidget {
  const AllFilesScreen({super.key});

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.s13_title,
                                style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/dashboard/filter-and-sort'),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colors.surfacePrimary,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: colors.borderSoft),
                                  ),
                                  child: SvgPicture.asset(
                                    OwnKeepMainIcons.sort,
                                    colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
                                    width: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s13_subtitle,
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
                        l10n.s13_search_hint,
                        style: TextStyle(color: colors.textMuted, fontSize: 16),
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
                    _buildFilterChip(context, l10n.filter_all, true),
                    _buildFilterChip(context, l10n.filter_documents, false),
                    _buildFilterChip(context, l10n.filter_images, false),
                    _buildFilterChip(context, l10n.filter_videos, false),
                    _buildFilterChip(context, l10n.filter_others, false),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Total Files Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text('${l10n.s13_all_count} files', style: TextStyle(color: colors.textMuted, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Files List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildFileItem(context, l10n.s13_passport_title, l10n.s13_passport_meta, OwnKeepMainIcons.filePdf, colors.dangerRed),
                    _buildFileItem(context, l10n.s13_insurance_title, l10n.s13_insurance_meta, OwnKeepMainIcons.filePdf, colors.dangerRed),
                    _buildFileItem(context, l10n.s13_licence_title, l10n.s13_licence_meta, OwnKeepMainIcons.image, colors.successGreen),
                    _buildFileItem(context, l10n.s13_bank_title, l10n.s13_bank_meta, OwnKeepMainIcons.filePdf, colors.dangerRed),
                    _buildFileItem(context, l10n.s13_family_photo_title, l10n.s13_family_photo_meta, OwnKeepMainIcons.image, colors.successGreen),
                    _buildFileItem(context, l10n.s13_investment_title, l10n.s13_investment_meta, OwnKeepMainIcons.spreadsheet, colors.warningOrange),
                    _buildFileItem(context, l10n.s13_property_title, l10n.s13_property_meta, OwnKeepMainIcons.filePdf, colors.dangerRed),
                    _buildFileItem(context, l10n.s13_project_title, l10n.s13_project_meta, OwnKeepMainIcons.document, colors.primaryBlue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    final colors = context.mainColors;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? colors.primaryBlue : colors.borderSoft),
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
    );
  }

  Widget _buildFileItem(BuildContext context, String title, String meta, String iconPath, Color iconColor) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: TextStyle(color: colors.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            OwnKeepMainIcons.moreVertical,
            colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
            width: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
              // Header & Search Input
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
                              colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                              width: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              l10n.s17_query,
                              style: TextStyle(color: colors.textPrimary, fontSize: 16),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: colors.borderSoft,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: colors.textPrimary, size: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
                    _buildFilterChip(context, l10n.filter_notes, false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    // Top Result
                    Text(l10n.s17_top_result, style: TextStyle(color: colors.textMuted, fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surfaceSelected,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.primaryBlue.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colors.primaryBlue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              OwnKeepMainIcons.filePdf,
                              colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                              width: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.s17_top_title,
                                  style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.s17_top_location,
                                  style: TextStyle(color: colors.primaryBlue, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.s17_top_meta,
                                  style: TextStyle(color: colors.textSecondary, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Other Results
                    Text(l10n.s17_other_results, style: TextStyle(color: colors.textMuted, fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _buildResultItem(context, l10n.s17_vehicle_title, l10n.s17_vehicle_meta, OwnKeepMainIcons.filePdf, colors.primaryBlue),
                    _buildResultItem(context, l10n.s17_health_title, l10n.s17_health_meta, OwnKeepMainIcons.image, colors.successGreen),
                    _buildResultItem(context, l10n.s17_claim_title, l10n.s17_claim_meta, OwnKeepMainIcons.document, colors.dangerRed),
                    _buildResultItem(context, l10n.s17_receipts_title, l10n.s17_receipts_meta, OwnKeepMainIcons.spreadsheet, colors.warningOrange),

                    const SizedBox(height: 32),
                    
                    // Not found / Try AI Search
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.aiPurple.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            OwnKeepMainIcons.aiAssistant,
                            colorFilter: ColorFilter.mode(colors.aiPurple, BlendMode.srcIn),
                            width: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.s17_not_found,
                            style: TextStyle(color: colors.textSecondary, fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: OwnKeepMainGradients.primaryAction,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              l10n.s17_try_ai,
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
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

  Widget _buildResultItem(BuildContext context, String title, String meta, String iconPath, Color iconColor) {
    final colors = context.mainColors;
    return Container(
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
                // Highlight part of the string 'insurance'
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: colors.textPrimary, fontSize: 15, fontFamily: 'Inter'),
                    children: [
                      TextSpan(text: title), // Assuming simple text for now, could use sophisticated highlight based on query
                    ],
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
    );
  }
}

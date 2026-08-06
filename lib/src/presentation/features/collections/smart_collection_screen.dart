import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../../theme/ownkeep_main_colors.dart';
import '../../../theme/ownkeep_main_icons.dart';
import 'smart_collection_category.dart';

class SmartCollectionScreen extends ConsumerWidget {
  final SmartCollectionCategory category;

  const SmartCollectionScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;
    final accentColor = category.color;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.add, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
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
                        colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.borderSoft),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn), width: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _getSearchHint(category, l10n),
                              style: TextStyle(color: colors.textMuted, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Stat Cards Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: _buildStatCards(category, l10n, colors),
                    ),
                    const SizedBox(height: 32),

                    // Content Sections
                    ..._buildContentSections(category, l10n, colors),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSearchHint(SmartCollectionCategory category, AppLocalizations l10n) {
    return l10n.common_search_collection;
  }

  List<Widget> _buildStatCards(SmartCollectionCategory category, AppLocalizations l10n, OwnKeepMainColorsTheme colors) {
    // This will dynamically pull from the database in the future.
    // For now, render the structural layout.
    List<Map<String, dynamic>> stats = [];
    switch (category) {
      case SmartCollectionCategory.health:
        stats = [
          {'title': l10n.s61_stat_medicines, 'value': '12', 'icon': OwnKeepMainIcons.medicine},
          {'title': l10n.s61_stat_appointments, 'value': '3', 'icon': OwnKeepMainIcons.appointment},
          {'title': l10n.s61_stat_reports, 'value': '8', 'icon': OwnKeepMainIcons.report},
          {'title': l10n.s61_stat_due, 'value': '2', 'icon': OwnKeepMainIcons.due_soon},
        ];
        break;
      case SmartCollectionCategory.finance:
        stats = [
          {'title': l10n.s62_income, 'value': '4', 'icon': OwnKeepMainIcons.income},
          {'title': l10n.s62_expenses, 'value': '28', 'icon': OwnKeepMainIcons.expenses},
          {'title': l10n.s62_statements, 'value': '12', 'icon': OwnKeepMainIcons.statements},
          {'title': l10n.s62_tax_docs, 'value': '5', 'icon': OwnKeepMainIcons.tax_docs},
        ];
        break;
      // Provide generic fallback for brevity, will map all correctly later
      default:
        stats = [
          {'title': 'Documents', 'value': '15', 'icon': OwnKeepMainIcons.file_doc},
          {'title': 'Important', 'value': '3', 'icon': OwnKeepMainIcons.reminder},
          {'title': 'Recent', 'value': '8', 'icon': OwnKeepMainIcons.history},
          {'title': 'Archived', 'value': '2', 'icon': OwnKeepMainIcons.archive},
        ];
    }

    return stats.map((stat) => Container(
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
                colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                width: 24,
              ),
              Text(
                stat['value'] as String,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stat['title'] as String,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildContentSections(SmartCollectionCategory category, AppLocalizations l10n, OwnKeepMainColorsTheme colors) {
    // Scaffold out the sections, can be fleshed out with actual queries later.
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Recent Items', style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w600)),
          Text(l10n.common_view_all, style: TextStyle(color: colors.primaryBlue, fontSize: 14)),
        ],
      ),
      const SizedBox(height: 16),
      // Dummy Item
      Container(
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
              child: SvgPicture.asset(OwnKeepMainIcons.file_pdf, colorFilter: ColorFilter.mode(category.color, BlendMode.srcIn)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Document_2023.pdf', style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('Added today', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                ],
              ),
            ),
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
          ],
        ),
      ),
    ];
  }
}

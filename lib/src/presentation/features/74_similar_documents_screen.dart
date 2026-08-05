import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SimilarDocumentsScreen extends StatelessWidget {
  const SimilarDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final similarGroups = [
      {
        'title': l10n.s74_vehicle,
        'meta': l10n.s74_vehicle_meta,
        'icon': OwnKeepMainIcons.vehicle,
        'color': colors.accentCyan,
      },
      {
        'title': l10n.s74_salary,
        'meta': l10n.s74_salary_meta,
        'icon': OwnKeepMainIcons.finance,
        'color': colors.successGreen,
      },
      {
        'title': l10n.s74_health,
        'meta': l10n.s74_health_meta,
        'icon': OwnKeepMainIcons.health,
        'color': colors.healthPink,
      },
      {
        'title': l10n.s74_property,
        'meta': l10n.s74_property_meta,
        'icon': OwnKeepMainIcons.property,
        'color': colors.warningOrange,
      },
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
        title: Column(
          children: [
            Text(l10n.s74_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s74_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
          ],
        ),
        centerTitle: true,
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(OwnKeepMainIcons.ai_sparkle, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.s74_found, style: TextStyle(color: colors.primaryBlue, fontSize: 16, fontWeight: FontWeight.w600)),
                                Text(l10n.s74_local, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final group = similarGroups[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.borderSoft),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: (group['color'] as Color).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(group['icon'] as String, colorFilter: ColorFilter.mode(group['color'] as Color, BlendMode.srcIn), width: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(group['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(group['meta'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: colors.borderSoft)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(l10n.common_view_all, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                                SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: similarGroups.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

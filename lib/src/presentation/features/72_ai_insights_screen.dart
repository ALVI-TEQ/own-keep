import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AiInsightsScreen extends StatelessWidget {
  const AiInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

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
            Text(l10n.s72_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s72_subtitle, style: TextStyle(color: colors.primaryBlue, fontSize: 12)),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primaryBlue.withValues(alpha: 0.2), colors.aiPurple.withValues(alpha: 0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colors.primaryBlue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(OwnKeepMainIcons.ai_sparkle, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                        const SizedBox(width: 8),
                        Text(l10n.s72_monthly, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.s72_hero_title, style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(l10n.s72_hero_body, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard(l10n.s72_organized_value, l10n.s72_organized, OwnKeepMainIcons.collection, colors),
                  _buildStatCard(l10n.s72_duplicates_value, l10n.s72_duplicates, OwnKeepMainIcons.copy, colors),
                  _buildStatCard(l10n.s72_reminders_value, l10n.s72_reminders, OwnKeepMainIcons.reminder, colors),
                  _buildStatCard(l10n.s72_space_value, l10n.s72_space, OwnKeepMainIcons.pie_chart, colors),
                ],
              ),
              const SizedBox(height: 40),

              // Insights List
              Text(l10n.s72_insights, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildInsightRow(OwnKeepMainIcons.tag, l10n.s72_tags_title, l10n.s72_tags_body, colors.warningOrange, colors),
              _buildInsightRow(OwnKeepMainIcons.due_soon, l10n.s72_expiry_title, l10n.s72_expiry_body, colors.dangerRed, colors),
              _buildInsightRow(OwnKeepMainIcons.duplicate, l10n.s72_duplicate_title, l10n.s72_duplicate_body, colors.aiPurple, colors),
              _buildInsightRow(OwnKeepMainIcons.folder, l10n.s72_uncategorized_title, l10n.s72_uncategorized_body, colors.primaryBlue, colors),
              _buildInsightRow(OwnKeepMainIcons.calendar, l10n.s72_outdated_title, l10n.s72_outdated_body, colors.textSecondary, colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, String iconPath, OwnKeepMainColorsTheme colors) {
    return Container(
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
              SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 24),
              Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildInsightRow(String iconPath, String title, String body, Color iconColor, OwnKeepMainColorsTheme colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), width: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
        ],
      ),
    );
  }
}

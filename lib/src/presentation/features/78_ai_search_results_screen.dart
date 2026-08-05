import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AiSearchResultsScreen extends StatelessWidget {
  const AiSearchResultsScreen({super.key});

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
        title: Text(l10n.s78_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
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
              // Search Question Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(l10n.s78_question, style: TextStyle(color: colors.textPrimary, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // AI Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(OwnKeepMainIcons.ai_sparkle, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                        const SizedBox(width: 8),
                        Text(l10n.s78_summary_label, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(l10n.s78_summary, style: TextStyle(color: colors.textPrimary, fontSize: 16, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Result Cards
              _buildResultCard(l10n.s78_vehicle, l10n.s78_vehicle_meta, l10n.s78_vehicle_days, OwnKeepMainIcons.vehicle, colors.accentCyan, colors),
              const SizedBox(height: 16),
              _buildResultCard(l10n.s78_health, l10n.s78_health_meta, l10n.s78_health_days, OwnKeepMainIcons.health, colors.healthPink, colors),
              const SizedBox(height: 16),
              _buildResultCard(l10n.s78_licence, l10n.s78_licence_meta, l10n.s78_licence_days, OwnKeepMainIcons.profile, colors.primaryBlue, colors),
              const SizedBox(height: 40),

              // Suggested Actions
              Text(l10n.s78_suggested, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              _buildActionCard(l10n.s78_create_title, l10n.s78_create_body, OwnKeepMainIcons.reminder, colors),
              const SizedBox(height: 12),
              _buildActionCard(l10n.s78_open_title, l10n.s78_open_body, OwnKeepMainIcons.open, colors),
              const SizedBox(height: 12),
              _buildActionCard(l10n.s78_compare_title, l10n.s78_compare_body, OwnKeepMainIcons.compare, colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String meta, String badge, String iconPath, Color iconColor, OwnKeepMainColorsTheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: colors.dangerRed.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                      child: Text(badge, style: TextStyle(color: colors.dangerRed, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(meta, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String body, String iconPath, OwnKeepMainColorsTheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
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

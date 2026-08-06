import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AiHistoryScreen extends StatelessWidget {
  const AiHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final history = [
      {
        'title': l10n.s80_vehicle_title,
        'body': l10n.s80_vehicle_body,
        'time': l10n.s80_vehicle_time,
        'icon': OwnKeepMainIcons.vehicle,
        'color': colors.accentCyan,
      },
      {
        'title': l10n.s80_expiry_title,
        'body': l10n.s80_expiry_body,
        'time': l10n.s80_expiry_time,
        'icon': OwnKeepMainIcons.reminder,
        'color': colors.dangerRed,
      },
      {
        'title': l10n.s80_finance_title,
        'body': l10n.s80_finance_body,
        'time': l10n.s80_finance_time,
        'icon': OwnKeepMainIcons.finance,
        'color': colors.successGreen,
      },
      {
        'title': l10n.s80_health_title,
        'body': l10n.s80_health_body,
        'time': l10n.s80_health_time,
        'icon': OwnKeepMainIcons.health,
        'color': colors.healthPink,
      },
      {
        'title': l10n.s80_duplicate_title,
        'body': l10n.s80_duplicate_body,
        'time': l10n.s80_duplicate_time,
        'icon': OwnKeepMainIcons.copy,
        'color': colors.warningOrange,
      },
      {
        'title': l10n.s80_reminder_title,
        'body': l10n.s80_reminder_body,
        'time': l10n.s80_reminder_time,
        'icon': OwnKeepMainIcons.profile,
        'color': colors.aiPurple,
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
            Text(l10n.s80_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s80_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History Cleared')));
            },
            child: Text(l10n.s80_clear, style: TextStyle(color: colors.dangerRed)),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, color: colors.textMuted, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.s80_local_notice, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing ${item['title']}')));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                              color: (item['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(item['icon'] as String, colorFilter: ColorFilter.mode(item['color'] as Color, BlendMode.srcIn), width: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(item['body'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                                const SizedBox(height: 8),
                                Text(item['time'] as String, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AccessHistoryScreen extends StatelessWidget {
  const AccessHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final historyLogs = [
      {'event': l10n.s90_event_1, 'time': l10n.s90_time_1, 'initial': 'H', 'color': const Color(0xFFFF4C9A)},
      {'event': l10n.s90_event_2, 'time': l10n.s90_time_2, 'initial': 'A', 'color': const Color(0xFF4668FF)},
      {'event': l10n.s90_event_3, 'time': l10n.s90_time_3, 'initial': 'C', 'color': const Color(0xFF28CC91), 'isAlert': true},
      {'event': l10n.s90_event_4, 'time': l10n.s90_time_4, 'initial': 'A', 'color': const Color(0xFF8548FF)},
      {'event': l10n.s90_event_5, 'time': l10n.s90_time_5, 'initial': 'H', 'color': const Color(0xFFFF4C9A)},
      {'event': l10n.s90_event_6, 'time': l10n.s90_time_6, 'initial': 'R', 'color': const Color(0xFFFFA42F)},
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
            Text(l10n.s90_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s90_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
        child: Column(
          children: [
            // Summary Dashboard
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(l10n.s90_period, l10n.s90_summary, colors.primaryBlue, colors),
                    Container(width: 1, height: 40, color: colors.borderSoft),
                    _buildSummaryStat('Status', l10n.s90_warnings, colors.successGreen, colors),
                  ],
                ),
              ),
            ),

            // Log List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: historyLogs.length,
                itemBuilder: (context, index) {
                  final log = historyLogs[index];
                  final isAlert = log['isAlert'] == true;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isAlert ? colors.warningOrange.withValues(alpha: 0.1) : colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isAlert ? colors.warningOrange.withValues(alpha: 0.3) : colors.borderSoft),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: log['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(log['initial'] as String, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(log['event'] as String, style: TextStyle(color: isAlert ? colors.warningOrange : colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(log['time'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                            ],
                          ),
                        ),
                        if (isAlert)
                          Icon(Icons.warning_amber_rounded, color: colors.warningOrange, size: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Audit log exported')));
              },
              icon: Icon(Icons.download, color: colors.primaryBlue),
              label: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.s90_export, style: TextStyle(color: colors.primaryBlue, fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(l10n.s90_export_body, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                ],
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: colors.primaryBlue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String title, String value, Color valueColor, OwnKeepMainColorsTheme colors) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

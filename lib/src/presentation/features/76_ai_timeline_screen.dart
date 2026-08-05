import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AiTimelineScreen extends StatelessWidget {
  const AiTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final timelineEvents = [
      {
        'title': l10n.s76_vehicle_title,
        'body': l10n.s76_vehicle_body,
        'icon': OwnKeepMainIcons.vehicle,
        'color': colors.accentCyan,
        'date': 'Today',
      },
      {
        'title': l10n.s76_health_title,
        'body': l10n.s76_health_body,
        'icon': OwnKeepMainIcons.health,
        'color': colors.healthPink,
        'date': 'Yesterday',
      },
      {
        'title': l10n.s76_service_title,
        'body': l10n.s76_service_body,
        'icon': OwnKeepMainIcons.settings,
        'color': colors.primaryBlue,
        'date': 'May 14',
      },
      {
        'title': l10n.s76_passport_title,
        'body': l10n.s76_passport_body,
        'icon': OwnKeepMainIcons.profile,
        'color': colors.aiPurple,
        'date': 'May 10',
      },
      {
        'title': l10n.s76_doctor_title,
        'body': l10n.s76_doctor_body,
        'icon': OwnKeepMainIcons.appointment,
        'color': colors.healthPink,
        'date': 'April 28',
      },
      {
        'title': l10n.s76_tax_title,
        'body': l10n.s76_tax_body,
        'icon': OwnKeepMainIcons.finance,
        'color': colors.successGreen,
        'date': 'April 15',
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
            Text(l10n.s76_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s76_subtitle, style: TextStyle(color: colors.primaryBlue, fontSize: 12)),
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
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          itemCount: timelineEvents.length,
          itemBuilder: (context, index) {
            final event = timelineEvents[index];
            final showLine = index != timelineEvents.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline line & dot
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (event['color'] as Color).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: event['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      if (showLine)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: colors.borderSoft,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  
                  // Content Card
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
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
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (event['color'] as Color).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(event['icon'] as String, colorFilter: ColorFilter.mode(event['color'] as Color, BlendMode.srcIn), width: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(event['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                                      ),
                                      Text(event['date'] as String, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(event['body'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

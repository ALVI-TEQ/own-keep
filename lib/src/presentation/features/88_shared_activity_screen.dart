import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SharedActivityScreen extends StatelessWidget {
  const SharedActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final activities = [
      {'time': l10n.s88_time_1, 'event': l10n.s88_event_1, 'collection': l10n.s88_collection_1, 'initial': 'H', 'color': const Color(0xFFFF4C9A)},
      {'time': l10n.s88_time_2, 'event': l10n.s88_event_2, 'collection': l10n.s88_collection_2, 'initial': 'A', 'color': const Color(0xFF4668FF)},
      {'time': l10n.s88_time_3, 'event': l10n.s88_event_3, 'collection': l10n.s88_collection_3, 'initial': 'A', 'color': const Color(0xFF8548FF)},
      {'time': l10n.s88_time_4, 'event': l10n.s88_event_4, 'collection': l10n.s88_collection_4, 'initial': 'H', 'color': const Color(0xFFFF4C9A)},
      {'time': l10n.s88_time_5, 'event': l10n.s88_event_5, 'collection': l10n.s88_collection_5, 'initial': 'C', 'color': const Color(0xFF28CC91)},
      {'time': l10n.s88_time_6, 'event': l10n.s88_event_6, 'collection': l10n.s88_collection_6, 'initial': 'A', 'color': const Color(0xFF4668FF)},
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
            Text(l10n.s88_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s88_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
                    Text('${l10n.s88_location}: ', style: TextStyle(color: colors.textMuted, fontSize: 12)),
                    Text(l10n.s88_location_value, style: TextStyle(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = activities[index];
                  final showLine = index != activities.length - 1;

                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing detail for ${item['event']}')));
                    },
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: item['color'] as Color,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(item['initial'] as String, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['event'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4),
                                  Text(item['collection'] as String, style: TextStyle(color: colors.primaryBlue, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  Text(item['time'] as String, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                                ],
                              ),
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

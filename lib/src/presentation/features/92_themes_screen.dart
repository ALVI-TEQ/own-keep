import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  int _selectedThemeIndex = 0; // 0=Midnight, 1=Indigo, 2=Forest, 3=Graphite
  bool _useSystem = true;
  bool _reduceMotion = false;
  bool _increaseContrast = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final themes = [
      {'title': l10n.s92_midnight, 'body': l10n.s92_midnight_body, 'color': const Color(0xFF030B19)},
      {'title': l10n.s92_indigo, 'body': l10n.s92_indigo_body, 'color': const Color(0xFF1E2640)},
      {'title': l10n.s92_forest, 'body': l10n.s92_forest_body, 'color': const Color(0xFF0A1F1A)},
      {'title': l10n.s92_graphite, 'body': l10n.s92_graphite_body, 'color': const Color(0xFF1E1E1E)},
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
            Text(l10n.s92_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s92_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              Text(l10n.s92_app_theme, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              ...List.generate(themes.length, (index) {
                final theme = themes[index];
                final isSelected = index == _selectedThemeIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedThemeIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? colors.primaryBlue : colors.borderSoft, width: isSelected ? 2 : 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme['color'] as Color,
                            shape: BoxShape.circle,
                            border: Border.all(color: colors.borderSoft),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(theme['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(theme['body'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: colors.primaryBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(l10n.s92_active, style: TextStyle(color: colors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold)),
                          )
                        else
                          Icon(Icons.circle_outlined, color: colors.textMuted, size: 24),
                      ],
                    ),
                  ),
                );
              }),
              
              const SizedBox(height: 32),
              Text(l10n.s92_appearance, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              _buildToggle(l10n.s92_system_brightness, l10n.s92_system_brightness_body, _useSystem, (v) => setState(() => _useSystem = v), colors),
              _buildToggle(l10n.s92_reduce_motion, l10n.s92_reduce_motion_body, _reduceMotion, (v) => setState(() => _reduceMotion = v), colors),
              _buildToggle(l10n.s92_increase_contrast, l10n.s92_increase_contrast_body, _increaseContrast, (v) => setState(() => _increaseContrast = v), colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(String title, String body, bool value, ValueChanged<bool> onChanged, OwnKeepMainColorsTheme colors) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: colors.primaryBlue.withValues(alpha: 0.5),
            activeThumbColor: colors.primaryBlue,
            inactiveTrackColor: colors.surfaceSecondary,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});
  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  int _selected = 0;
  bool _sysBrightness = false;
  bool _reduceMotion = false;
  bool _increaseContrast = true;

  final _themes = [
    ('Midnight', 'Dark premium theme', const Color(0xFF4F6EF7), const Color(0xFF0D1327)),
    ('Indigo', 'Dark premium theme', const Color(0xFF7C3AED), const Color(0xFF180D2F)),
    ('Forest', 'Dark premium theme', const Color(0xFF22C55E), const Color(0xFF0D1F14)),
    ('Graphite', 'Dark premium theme', const Color(0xFF9CA3AF), const Color(0xFF18191A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Themes', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Personalize your vault', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('App Theme', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ..._themes.asMap().entries.map((e) {
            final t = e.value;
            final isSelected = _selected == e.key;
            return GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: t.$4.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(
                    color: isSelected ? t.$3 : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  // Theme swatch
                  Container(
                    width: 110, height: 60,
                    decoration: BoxDecoration(color: t.$4, borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 12, width: 80, decoration: BoxDecoration(color: t.$3, borderRadius: BorderRadius.circular(4))),
                      Container(height: 10, width: 50, decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(4))),
                    ]),
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    Text(t.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                  if (isSelected)
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: t.$3,
                        side: BorderSide(color: t.$3),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text('Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: t.$3, fontFamily: 'Inter')),
                    ),
                ]),
              ),
            );
          }),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Appearance', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...[
            ('Use system brightness', 'Follow device dark/light setting', _sysBrightness, (v) => setState(() => _sysBrightness = v)),
            ('Reduce motion', 'Use simpler transitions', _reduceMotion, (v) => setState(() => _reduceMotion = v)),
            ('Increase contrast', 'Stronger text and borders', _increaseContrast, (v) => setState(() => _increaseContrast = v)),
          ].map((row) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(row.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(row.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Switch(value: row.$3, onChanged: row.$4, activeThumbColor: OwnKeepColors.primary),
            ]),
          )),
        ]),
      ),
    );
  }
}

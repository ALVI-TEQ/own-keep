import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});
  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  bool _biometric = true;
  bool _pinFallback = true;
  bool _recoveryPhrase = true;
  int _autoLockIndex = 1; // After 30 seconds selected

  final _autoLockOptions = [
    'Immediately',
    'After 30 seconds',
    'After 2 minutes',
    'When app goes to background',
  ];

  @override
  Widget build(BuildContext context) {
    final lockMethods = [
      (Icons.fingerprint_rounded, const Color(0xFF0A4A2E), OwnKeepColors.success, 'Biometric unlock', 'Use fingerprint or face unlock', _biometric, (v) => setState(() => _biometric = v)),
      (Icons.circle_rounded, const Color(0xFF1A3D7A), OwnKeepColors.primary, 'PIN fallback', 'Required after device restart', _pinFallback, (v) => setState(() => _pinFallback = v)),
      (Icons.grid_view_rounded, const Color(0xFF3D1A7A), const Color(0xFF7C3AED), 'Recovery phrase', 'Emergency recovery only', _recoveryPhrase, (v) => setState(() => _recoveryPhrase = v)),
    ];

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
          Text('App Lock', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Control when OwnKeep locks', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
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
          // Status card
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.4)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Vault Lock Status', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('Protected', style: TextStyle(color: OwnKeepColors.success, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
              ]),
              Text('Biometric + PIN', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Lock Methods', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...lockMethods.map((m) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: m.$2, borderRadius: BorderRadius.circular(9)),
                child: Icon(m.$1, color: m.$3, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(m.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Switch(value: m.$6, onChanged: m.$7, activeThumbColor: OwnKeepColors.primary),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Auto Lock', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ..._autoLockOptions.asMap().entries.map((e) {
            final isSelected = _autoLockIndex == e.key;
            return GestureDetector(
              onTap: () => setState(() => _autoLockIndex = e.key),
              child: Container(
                margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(
                    color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(e.value, style: TextStyle(
                    color: isSelected ? OwnKeepColors.darkTextPrimary : OwnKeepColors.darkTextSecondary,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: 'Inter',
                  )),
                  if (isSelected)
                    Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 18),
                ]),
              ),
            );
          }),
          SizedBox(height: OwnKeepSpacing.sm),
          // Lock Now row (danger)
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.danger.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.danger.withValues(alpha: 0.3)),
            ),
            child: Row(children: const [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Lock Now', style: TextStyle(color: OwnKeepColors.danger, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text('Immediately secure all vault content', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

class OnboardingGuideScreen extends StatefulWidget {
  const OnboardingGuideScreen({super.key});

  @override
  State<OnboardingGuideScreen> createState() => _OnboardingGuideScreenState();
}

class _OnboardingGuideScreenState extends State<OnboardingGuideScreen> {
  final int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 60),
                  Text('Welcome to OwnKeep', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: Text('Skip', style: TextStyle(color: OwnKeepColors.primary, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.xl),
                child: Column(
                  children: [
                    SizedBox(height: OwnKeepSpacing.xl),
                    // Glowing vault icon
                    Container(
                      width: 130, height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [OwnKeepColors.ai.withValues(alpha: 0.25), Colors.transparent]),
                      ),
                      child: Center(
                        child: Container(
                          width: 96, height: 96,
                          decoration: BoxDecoration(
                            color: OwnKeepColors.darkSurfaceElevated,
                            borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
                            boxShadow: [
                              BoxShadow(color: OwnKeepColors.ai.withValues(alpha: 0.3), blurRadius: 24, spreadRadius: 4),
                            ],
                          ),
                          child: Icon(Icons.lock_rounded, color: OwnKeepColors.ai, size: 52),
                        ),
                      ),
                    ),
                    SizedBox(height: OwnKeepSpacing.xl),
                    Text('Your Data. Your Control.', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter'), textAlign: TextAlign.center),
                    SizedBox(height: OwnKeepSpacing.sm),
                    Text('100% Offline. End-to-End Encrypted.', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter'), textAlign: TextAlign.center),
                    SizedBox(height: OwnKeepSpacing.xl),
                    // Feature list
                    _FeatureRow(icon: Icons.lock_outline, label: 'Keep everything private', subtitle: 'Your data never leaves your device.', color: OwnKeepColors.primary),
                    _FeatureRow(icon: Icons.label_outline_rounded, label: 'Organize with ease', subtitle: 'Smart tags and AI suggestions.', color: OwnKeepColors.success),
                    _FeatureRow(icon: Icons.notifications_outlined, label: 'Never miss important things', subtitle: 'Reminders for expiries and events.', color: OwnKeepColors.danger),
                    _FeatureRow(icon: Icons.verified_outlined, label: 'Secure forever', subtitle: 'Your vault, your rules.', color: OwnKeepColors.success),
                    const Spacer(),
                    // Page dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: i == _page ? 24 : 8, height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: i == _page ? OwnKeepColors.primary : OwnKeepColors.darkTextMuted,
                          borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
                        ),
                      )),
                    ),
                    SizedBox(height: OwnKeepSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: OwnKeepColors.primary,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                        ),
                        child: Text('Get Started', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ),
                    ),
                    SizedBox(height: OwnKeepSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label, required this.subtitle, required this.color});
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: OwnKeepSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

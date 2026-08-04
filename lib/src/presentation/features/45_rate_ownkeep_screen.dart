import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RateOwnKeepScreen extends StatefulWidget {
  const RateOwnKeepScreen({super.key});

  @override
  State<RateOwnKeepScreen> createState() => _RateOwnKeepScreenState();
}

class _RateOwnKeepScreenState extends State<RateOwnKeepScreen> {
  int _selectedStars = 5;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Rate OwnKeep',
      showBottomNav: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: OwnKeepSpacing.xl),
            // Hero emoji illustration
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(
                      color: OwnKeepColors.ai.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Center(child: Icon(Icons.star_rounded, color: OwnKeepColors.warning, size: 64)),
                  ),
                  Positioned(
                    right: -12, bottom: -8,
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: OwnKeepColors.pink.withValues(alpha: 0.2), shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.favorite_rounded, color: OwnKeepColors.pink, size: 20)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            Text('Enjoying OwnKeep?', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text('Your feedback helps us build a better app for you.', textAlign: TextAlign.center,
                  style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter', height: 1.5)),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            // Star row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _selectedStars = i + 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.star_rounded, color: i < _selectedStars ? OwnKeepColors.warning : OwnKeepColors.darkSurfaceMuted, size: 44),
                ),
              )),
            ),
            SizedBox(height: 8),
            Text('Tap a star to rate', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 13, fontFamily: 'Inter')),
            SizedBox(height: OwnKeepSpacing.xl),
            // Text feedback
            Padding(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
              child: Container(
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(OwnKeepSpacing.md),
                      child: TextField(
                        controller: _controller,
                        maxLines: 4,
                        style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'),
                        decoration: const InputDecoration(
                          hintText: 'Tell us what you love about OwnKeep...',
                          hintStyle: TextStyle(color: OwnKeepColors.darkTextMuted, fontFamily: 'Inter'),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.md, 0, OwnKeepSpacing.md, OwnKeepSpacing.sm),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                        Text('(Optional)', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                        Text('0/500', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Submit button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: OwnKeepColors.primary,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                ),
                child: Text('Submit Rating', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ),
            SizedBox(height: OwnKeepSpacing.lg),
            // Share & Feedback tiles
            Container(
              margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  _RateTile(icon: Icons.share_outlined, iconColor: OwnKeepColors.primary, title: 'Share OwnKeep', subtitle: 'Recommend to your friends', isFirst: true),
                  Divider(height: 1, color: OwnKeepColors.darkBorder.withValues(alpha: 0.25), indent: 64),
                  _RateTile(icon: Icons.mail_outline_rounded, iconColor: OwnKeepColors.ai, title: 'Send Feedback', subtitle: "We'd love to hear from you", isLast: true),
                ],
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _RateTile extends StatelessWidget {
  const _RateTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, this.isFirst = false, this.isLast = false});
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
        bottom: isLast ? Radius.circular(OwnKeepRadius.md) : Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
        child: Row(children: [
          OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
            Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ])),
          Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
        ]),
      ),
    );
  }
}

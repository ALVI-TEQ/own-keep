import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class RateOwnKeepScreen extends StatefulWidget {
  const RateOwnKeepScreen({super.key});

  @override
  State<RateOwnKeepScreen> createState() => _RateOwnKeepScreenState();
}

class _RateOwnKeepScreenState extends State<RateOwnKeepScreen> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
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
        title: Text(
          l10n.s45_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Illustration
            Center(
              child: SvgPicture.asset(
                'assets/main/illustrations/rate_ownkeep_illustration.svg', // Assumed illustration path
                height: 180,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Hero Text
            Text(
              l10n.s45_hero_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.s45_hero_body,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 15,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isSelected = index < _selectedRating;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.rating_star, // using rating_star icon for both states here and tinting
                      colorFilter: ColorFilter.mode(
                        isSelected ? colors.warningOrange : colors.surfaceSelected,
                        BlendMode.srcIn,
                      ),
                      width: 40,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.s45_rate_hint,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Comment Box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s45_optional,
                  style: TextStyle(
                    color: colors.textMuted,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  l10n.s45_counter,
                  style: TextStyle(
                    color: colors.textMuted,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                maxLines: 4,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
                decoration: InputDecoration(
                  hintText: l10n.s45_comment_hint,
                  hintStyle: TextStyle(
                    color: colors.textMuted,
                    fontSize: 15,
                    fontFamily: 'Inter',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedRating > 0 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  disabledBackgroundColor: colors.surfaceSelected,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: colors.textMuted,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.s45_submit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Alternative Links
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildLinkItem(colors, OwnKeepMainIcons.share, l10n.s45_share, l10n.s45_share_body, colors.aiPurple),
                  Divider(color: colors.borderSoft, height: 1, indent: 64),
                  _buildLinkItem(colors, OwnKeepMainIcons.contact_email, l10n.s45_feedback, l10n.s45_feedback_body, const Color(0xFF27C5E8)),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(
    OwnKeepMainColorsTheme colors, 
    String icon, 
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                icon, 
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              OwnKeepMainIcons.chevron_right, 
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

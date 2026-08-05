import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class RecoveryCenterScreen extends StatelessWidget {
  const RecoveryCenterScreen({super.key});

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
          l10n.s31_title,
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
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          children: [
            // Hero Illustration
            Center(
              child: SvgPicture.asset(
                'assets/main/illustrations/recovery_shield_key_illustration.svg',
                height: 160,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
            
            // Hero Text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 24,
                  fontFamily: 'Inter',
                ),
                children: [
                  TextSpan(
                    text: '${l10n.s31_hero_title}\n',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: l10n.s31_hero_body,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Status Card
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.s31_status_title,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.successGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.successGreen.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(OwnKeepMainIcons.verified_shield, colorFilter: ColorFilter.mode(colors.successGreen, BlendMode.srcIn), width: 14),
                            const SizedBox(width: 4),
                            Text(
                              l10n.s31_status_verified,
                              style: TextStyle(
                                color: colors.successGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.md),
                  const Divider(color: Color(0xFF1B2940)),
                  const SizedBox(height: OwnKeepSpacing.md),
                  Text(
                    l10n.s31_last_verified,
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Options List
            _buildActionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.eye,
              title: l10n.s31_view_title,
              subtitle: l10n.s31_view_body,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildActionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.recovery_phrase,
              title: l10n.s31_verify_title,
              subtitle: l10n.s31_verify_body,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildActionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.recovery_instructions,
              title: l10n.s31_instructions_title,
              subtitle: l10n.s31_instructions_body,
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildActionTile(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.emergency,
              title: l10n.s31_emergency_title,
              subtitle: l10n.s31_emergency_body,
            ),
            
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Tip box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceSelected.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(OwnKeepMainIcons.recovery_shield_key, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                  const SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.s31_tip,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
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
                      fontSize: 16,
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
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

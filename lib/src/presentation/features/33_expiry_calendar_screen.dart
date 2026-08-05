import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class ExpiryCalendarScreen extends StatelessWidget {
  const ExpiryCalendarScreen({super.key});

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
          l10n.s33_title,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Header
            Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s33_month,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(OwnKeepMainIcons.chevron_left, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Weekday Headers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildWeekdayLabel(colors, l10n.weekday_sun),
                  _buildWeekdayLabel(colors, l10n.weekday_mon),
                  _buildWeekdayLabel(colors, l10n.weekday_tue),
                  _buildWeekdayLabel(colors, l10n.weekday_wed),
                  _buildWeekdayLabel(colors, l10n.weekday_thu),
                  _buildWeekdayLabel(colors, l10n.weekday_fri),
                  _buildWeekdayLabel(colors, l10n.weekday_sat),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Calendar Grid (Mock representation for 12-18 May 2025 week)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDayCell(colors, '11', false, false),
                  _buildDayCell(colors, '12', true, false), // Has event
                  _buildDayCell(colors, '13', false, false),
                  _buildDayCell(colors, '14', false, false),
                  _buildDayCell(colors, '15', true, true),  // Selected and has event
                  _buildDayCell(colors, '16', false, false),
                  _buildDayCell(colors, '17', false, false),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Upcoming Expiries Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s33_this_month,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    l10n.common_view_all,
                    style: TextStyle(
                      color: colors.primaryBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Expiry List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Column(
                children: [
                  _buildExpiryCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.identity,
                    iconColor: colors.primaryBlue,
                    title: l10n.s33_driving_licence,
                    subtitle: l10n.s33_driving_expiry,
                    date: l10n.s33_driving_days,
                    isCritical: true,
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildExpiryCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.file_pdf,
                    iconColor: const Color(0xFF27C5E8),
                    title: l10n.s33_health_policy,
                    subtitle: l10n.s33_health_expiry,
                    date: l10n.s33_health_days,
                    isCritical: false,
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildExpiryCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.identity,
                    iconColor: colors.aiPurple,
                    title: l10n.s33_passport,
                    subtitle: l10n.s33_passport_expiry,
                    date: l10n.s33_passport_days,
                    isCritical: false,
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildExpiryCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.vehicle,
                    iconColor: colors.warningOrange,
                    title: l10n.s33_car,
                    subtitle: l10n.s33_car_expiry,
                    date: l10n.s33_car_days,
                    isCritical: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // padding for floating action button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colors.primaryBlue,
        child: SvgPicture.asset(OwnKeepMainIcons.add, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      ),
    );
  }

  Widget _buildWeekdayLabel(OwnKeepMainColorsTheme colors, String label) {
    return SizedBox(
      width: 40,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildDayCell(OwnKeepMainColorsTheme colors, String day, bool hasEvent, bool isSelected) {
    return Container(
      width: 40,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : colors.textPrimary,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
          if (hasEvent) ...[
            const SizedBox(height: 4),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : colors.dangerRed,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpiryCard({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String date,
    required bool isCritical,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isCritical ? colors.dangerRed.withOpacity(0.5) : colors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceSelected,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(OwnKeepMainIcons.calendar, colorFilter: ColorFilter.mode(isCritical ? colors.dangerRed : colors.textMuted, BlendMode.srcIn), width: 14),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: isCritical ? colors.dangerRed : colors.textMuted,
                        fontSize: 12,
                        fontWeight: isCritical ? FontWeight.w600 : FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SvgPicture.asset(OwnKeepMainIcons.more_vertical, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
        ],
      ),
    );
  }
}

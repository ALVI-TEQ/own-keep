import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class HealthRemindersScreen extends StatefulWidget {
  const HealthRemindersScreen({super.key});

  @override
  State<HealthRemindersScreen> createState() => _HealthRemindersScreenState();
}

class _HealthRemindersScreenState extends State<HealthRemindersScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final filters = [
      l10n.common_all,
      l10n.s32_medicines,
      l10n.s32_appointments,
      l10n.s32_reports,
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
        title: Text(
          l10n.s32_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.notification, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SizedBox(
              height: 56,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.sm),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: OwnKeepSpacing.sm),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? colors.primaryBlue : colors.borderSoft,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : colors.textSecondary,
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Today Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Text(
                l10n.common_today,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: _buildReminderCard(
                context: context,
                colors: colors,
                icon: OwnKeepMainIcons.medicine_capsule,
                iconColor: const Color(0xFF27C5E8), // accentCyan
                title: l10n.s32_vitamin,
                subtitle: l10n.s32_vitamin_body,
                time: l10n.s32_vitamin_time,
                isCompleted: false,
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Upcoming Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s32_upcoming,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Column(
                children: [
                  _buildUpcomingCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.doctor_appointment,
                    iconColor: colors.warningOrange,
                    title: l10n.s32_doctor,
                    subtitle: l10n.s32_doctor_name,
                    time: l10n.s32_doctor_time,
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildUpcomingCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.blood_test,
                    iconColor: colors.dangerRed,
                    title: l10n.s32_blood,
                    subtitle: l10n.s32_blood_body,
                    time: l10n.s32_blood_time,
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  _buildUpcomingCard(
                    context: context,
                    colors: colors,
                    icon: OwnKeepMainIcons.medicine_bottle,
                    iconColor: colors.successGreen,
                    title: l10n.s32_refill,
                    subtitle: l10n.s32_refill_body,
                    time: l10n.s32_refill_time,
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Health Summary Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Text(
                l10n.s32_summary,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryBox(
                      colors: colors,
                      icon: OwnKeepMainIcons.medicine_box,
                      iconColor: const Color(0xFF27C5E8),
                      title: l10n.s32_medicines_count,
                    ),
                  ),
                  const SizedBox(width: OwnKeepSpacing.sm),
                  Expanded(
                    child: _buildSummaryBox(
                      colors: colors,
                      icon: OwnKeepMainIcons.doctor_appointment,
                      iconColor: colors.warningOrange,
                      title: l10n.s32_appointments_count,
                    ),
                  ),
                  const SizedBox(width: OwnKeepSpacing.sm),
                  Expanded(
                    child: _buildSummaryBox(
                      colors: colors,
                      icon: OwnKeepMainIcons.reports,
                      iconColor: colors.aiPurple,
                      title: l10n.s32_reports_count,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // padding for floating action button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: colors.primaryBlue,
        icon: SvgPicture.asset(OwnKeepMainIcons.add, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        label: Text(
          l10n.s32_add,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildReminderCard({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.all(OwnKeepSpacing.md),
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
                    SvgPicture.asset(OwnKeepMainIcons.clock, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn), width: 14),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.primaryBlue, width: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingCard({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                shape: BoxShape.circle,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time.split(',').first, // Date part
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                if (time.contains(',')) ...[
                  const SizedBox(height: 4),
                  Text(
                    time.split(',').last.trim(), // Time part
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 11,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBox({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
          const SizedBox(height: 8),
          Text(
            title.split(' ').first, // Number
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title.split(' ').last, // Label
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

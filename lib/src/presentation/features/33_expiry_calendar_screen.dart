import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class ExpiryCalendarScreen extends StatelessWidget {
  const ExpiryCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Expiry Calendar',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today_outlined, color: OwnKeepColors.darkTextPrimary, size: 20)),
      ],
      body: ListView(
        children: [
          // Calendar header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left, color: OwnKeepColors.darkTextPrimary)),
                Text('May 2025', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right, color: OwnKeepColors.darkTextPrimary)),
              ],
            ),
          ),
          // Day headers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((d) => SizedBox(width: 36, child: Center(child: Text(d, style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')))))
                  .toList(),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // Calendar grid
          _CalendarGrid(),
          SizedBox(height: OwnKeepSpacing.base),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Row(
              children: const [
                _Chip(label: 'All', isSelected: true),
                _Chip(label: 'Documents'),
                _Chip(label: 'Insurance'),
                _Chip(label: 'Licenses'),
                _Chip(label: 'Others'),
              ],
            ),
          ),
          // This Month
          OwnKeepSectionHeader(title: 'This Month', actionText: 'View All', onAction: () {}),
          _ExpiryItem(name: 'Driving License', date: 'Expires on 28 May 2025', daysLeft: 13, color: OwnKeepColors.warning),
          _ExpiryItem(name: 'Health Insurance Policy', date: 'Expires on 31 May 2025', daysLeft: 16, color: OwnKeepColors.success),
          _ExpiryItem(name: 'Passport', date: 'Expires on 10 Jun 2025', daysLeft: 26, color: OwnKeepColors.primary),
          _ExpiryItem(name: 'Car Insurance', date: 'Expires on 20 Jun 2025', daysLeft: 36, color: OwnKeepColors.ai),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = [
      [27, 28, 29, 30, 1, 2, 3],
      [4, 5, 6, 7, 8, 9, 10],
      [11, 12, 13, 14, 15, 16, 17],
      [18, 19, 20, 21, 22, 23, 24],
      [25, 26, 27, 28, 29, 30, 31],
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
      child: Column(
        children: days.asMap().entries.map((weekEntry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekEntry.value.map((day) {
                final isCurrentMonth = weekEntry.key == 0 ? day <= 3 : (weekEntry.key == 4 ? day >= 25 : true);
                final isToday = day == 15 && weekEntry.key == 2;
                final hasExpiry = [8, 15, 28, 31].contains(day) && isCurrentMonth;
                return SizedBox(
                  width: 36, height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          color: isToday ? OwnKeepColors.primary : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: isToday ? Colors.white : (weekEntry.key == 0 && day > 3 ? OwnKeepColors.darkTextMuted : OwnKeepColors.darkTextPrimary),
                              fontSize: 14,
                              fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      if (hasExpiry)
                        Container(width: 4, height: 4, decoration: BoxDecoration(color: OwnKeepColors.danger, shape: BoxShape.circle)),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.isSelected = false});
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: OwnKeepSpacing.sm),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
        border: Border.all(color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
    );
  }
}

class _ExpiryItem extends StatelessWidget {
  const _ExpiryItem({required this.name, required this.date, required this.daysLeft, required this.color});
  final String name;
  final String date;
  final int daysLeft;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.xs),
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          OwnKeepIconBadge(icon: Icons.description_outlined, color: color),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text(date, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$daysLeft', style: TextStyle(color: daysLeft < 20 ? OwnKeepColors.warning : OwnKeepColors.success, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              Text('Days Left', style: TextStyle(color: daysLeft < 20 ? OwnKeepColors.warning : OwnKeepColors.success, fontSize: 11, fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }
}

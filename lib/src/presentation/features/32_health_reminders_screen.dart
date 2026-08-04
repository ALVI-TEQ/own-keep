import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class HealthRemindersScreen extends StatelessWidget {
  const HealthRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Health Reminders',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
            child: Row(
              children: const [
                _FilterChip(label: 'All', isSelected: true),
                _FilterChip(label: 'Medicines'),
                _FilterChip(label: 'Appointments'),
                _FilterChip(label: 'Reports'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Today section
                _SectionLabel(title: 'Today'),
                _ReminderItem(
                  title: 'Vitamin D3',
                  subtitle: '1 Tablet after breakfast',
                  time: '08:00 AM',
                  icon: Icons.medication_outlined,
                  color: OwnKeepColors.warning,
                ),
                // Upcoming section
                OwnKeepSectionHeader(title: 'Upcoming', actionText: 'View All', onAction: () {}),
                _ReminderItem(
                  title: 'Doctor Appointment',
                  subtitle: 'Dr. K. Sharma\n15 May 2025, 04:00 PM',
                  icon: Icons.local_hospital_outlined,
                  color: OwnKeepColors.primary,
                ),
                _ReminderItem(
                  title: 'Blood Test',
                  subtitle: 'Complete Blood Count\n17 May 2025, 08:00 AM',
                  icon: Icons.science_outlined,
                  color: OwnKeepColors.danger,
                ),
                _ReminderItem(
                  title: 'Medicine Refill',
                  subtitle: 'Your medicines are running low\n20 May 2025',
                  icon: Icons.medication_liquid_outlined,
                  color: OwnKeepColors.pink,
                ),
                // Health Summary
                _SectionLabel(title: 'Health Summary'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
                  child: Row(
                    children: [
                      _SummaryCard(icon: Icons.medication_outlined, label: 'Medicines', value: '8 Active', color: OwnKeepColors.warning),
                      SizedBox(width: OwnKeepSpacing.sm),
                      _SummaryCard(icon: Icons.calendar_month_outlined, label: 'Appointments', value: '3 Upcoming', color: OwnKeepColors.pink),
                      SizedBox(width: OwnKeepSpacing.sm),
                      _SummaryCard(icon: Icons.description_outlined, label: 'Reports', value: '12 Stored', color: OwnKeepColors.primary),
                    ],
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.base),
                // Add button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 20),
                    label: Text('Add New Reminder', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
                    style: FilledButton.styleFrom(
                      backgroundColor: OwnKeepColors.primary,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                    ),
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.isSelected = false});
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: OwnKeepSpacing.sm),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.pill),
        border: Border.all(color: isSelected ? OwnKeepColors.primary : OwnKeepColors.darkBorder),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, OwnKeepSpacing.lg, OwnKeepSpacing.base, OwnKeepSpacing.sm),
      child: Text(title, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
    );
  }
}

class _ReminderItem extends StatelessWidget {
  const _ReminderItem({required this.title, required this.subtitle, this.time, required this.icon, required this.color});
  final String title;
  final String subtitle;
  final String? time;
  final IconData icon;
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
          OwnKeepIconBadge(icon: icon, color: color),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          if (time != null)
            Text(time!, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          SizedBox(width: 8),
          Icon(Icons.alarm_outlined, color: OwnKeepColors.darkTextMuted, size: 18),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            OwnKeepIconBadge(icon: icon, color: color, size: 36, iconSize: 18),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
            SizedBox(height: 2),
            Text(value, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

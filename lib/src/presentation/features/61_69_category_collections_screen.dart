import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../components/ownkeep_ui_kit.dart';

/// Generic category collection detail screen — used for Health, Finance,
/// Property, Vehicle, Education, Identity, Insurance, Travel, Work.
class _CategoryCollectionScreen extends StatelessWidget {
  const _CategoryCollectionScreen({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.accentColor,
    required this.itemCount,
    required this.countLabel,
    required this.stats,
    required this.section1Title,
    required this.section1Items,
    required this.section2Title,
    required this.section2Items,
  });

  final String title;
  final String subtitle;
  final IconData iconData;
  final Color accentColor;
  final int itemCount;
  final String countLabel;
  final List<(String, dynamic, String, Color)>
  stats; // label, value, sub, color
  final String section1Title;
  final List<_DocEntry> section1Items;
  final String section2Title;
  final List<_DocEntry> section2Items;

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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: OwnKeepColors.darkTextPrimary,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: OwnKeepColors.darkTextSecondary,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_rounded,
                color: OwnKeepColors.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Search bar
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: OwnKeepSpacing.md,
                vertical: 12,
              ),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.crop_square_rounded,
                    color: OwnKeepColors.darkTextMuted,
                    size: 20,
            ),
              SizedBox(width: 8),
                  Text(
                    'Search this collection...',
                    style: TextStyle(
                      color: OwnKeepColors.darkTextMuted,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Hero card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accentColor.withValues(alpha: 0.5)),
            ),
              child: Row(
                children: [
              Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                child: Icon(iconData, color: accentColor, size: 28),
              ),
              SizedBox(width: OwnKeepSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: OwnKeepColors.darkTextPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: OwnKeepColors.darkTextSecondary,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                SizedBox(height: 4),
                      Text(
                        '$itemCount',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        countLabel,
                        style: TextStyle(
                          color: OwnKeepColors.darkTextMuted,
                          fontSize: 11,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          // Stats row
          Row(
              children: stats
                  .asMap()
                  .entries
                  .map(
                    (e) => Expanded(
              child: Container(
                        margin: EdgeInsets.only(
                          right: e.key < stats.length - 1 ? 8 : 0,
                        ),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: OwnKeepColors.darkBorder.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${e.value.$2}',
                              style: TextStyle(
                                color: e.value.$4,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                ),
                  SizedBox(height: 2),
                            Text(
                              e.value.$1,
                              style: TextStyle(
                                color: OwnKeepColors.darkTextMuted,
                                fontSize: 10,
                                fontFamily: 'Inter',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
              ),
                      ),
                    ),
                  )
                  .toList(),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          // Section 1
          _SectionHeader(title: section1Title),
          SizedBox(height: OwnKeepSpacing.sm),
          ...section1Items.map((item) => _DocTile(entry: item)),
          SizedBox(height: OwnKeepSpacing.lg),
          // Section 2
          _SectionHeader(title: section2Title),
          SizedBox(height: OwnKeepSpacing.sm),
          ...section2Items.map((item) => _DocTile(entry: item)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: OwnKeepColors.darkTextPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        Text(
          'View all',
          style: TextStyle(
            color: OwnKeepColors.primary,
            fontSize: 12,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

class _DocEntry {
  const _DocEntry({
    required this.tag,
    required this.tagColor,
    required this.name,
    required this.sub,
    required this.badgeLabel,
    required this.badgeColor,
  });
  final String tag, name, sub, badgeLabel;
  final Color tagColor, badgeColor;
}

class _DocTile extends StatelessWidget {
  const _DocTile({required this.entry});
  final _DocEntry entry;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
      padding: EdgeInsets.all(OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: entry.tagColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                entry.tag,
                style: TextStyle(
                  color: entry.tagColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ),
        SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    color: OwnKeepColors.darkTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  entry.sub,
                  style: TextStyle(
                    color: OwnKeepColors.darkTextSecondary,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: entry.badgeColor),
            borderRadius: BorderRadius.circular(6),
          ),
            child: Text(
              entry.badgeLabel,
              style: TextStyle(
                color: entry.badgeColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
        ),
        SizedBox(width: 8),
          Icon(
            Icons.chevron_right_rounded,
            color: OwnKeepColors.darkTextMuted,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ─── Concrete screens ──────────────────────────────────────────────────────

class HealthCollectionScreen extends StatelessWidget {
  const HealthCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Health',
    subtitle: 'Medical records and reminders',
    iconData: Icons.favorite_rounded,
    accentColor: OwnKeepColors.pink,
    itemCount: 22,
    countLabel: 'health items',
    stats: const [
      ('Medicines', 8, '', Color(0xFFF59E0B)),
      ('Appointments', 3, '', Color(0xFF7C3AED)),
      ('Reports', 12, '', OwnKeepColors.primary),
      ('Due Soon', 2, '', OwnKeepColors.danger),
    ],
    section1Title: 'Upcoming',
    section1Items: const [
      _DocEntry(
        tag: '💊',
        tagColor: Color(0xFFF59E0B),
        name: 'Vitamin D3',
        sub: 'Today  •  8:00 AM',
        badgeLabel: 'Reminder',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: '📋',
        tagColor: Color(0xFF7C3AED),
        name: 'Doctor Appointment',
        sub: '15 May  •  4:00 PM',
        badgeLabel: 'Upcoming',
        badgeColor: Color(0xFF7C3AED),
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.danger,
        name: 'Blood Test Report',
        sub: 'Added 2 days ago',
        badgeLabel: 'Report',
        badgeColor: OwnKeepColors.danger,
      ),
    ],
    section2Title: 'Documents',
    section2Items: const [
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.success,
        name: 'Health Insurance Card',
        sub: 'Expires in 16 days',
        badgeLabel: 'Active',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'DOC',
        tagColor: OwnKeepColors.primary,
        name: 'Prescription - April',
        sub: '3 medicines listed',
        badgeLabel: 'Recent',
        badgeColor: OwnKeepColors.primary,
      ),
    ],
  );
}

class FinanceCollectionScreen extends StatelessWidget {
  const FinanceCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Finance',
    subtitle: 'Money, tax and investments',
    iconData: Icons.currency_rupee_rounded,
    accentColor: OwnKeepColors.success,
    itemCount: 38,
    countLabel: 'finance items',
    stats: const [
      ('Income', '₹2.4L', '', OwnKeepColors.success),
      ('Expenses', '₹68K', '', OwnKeepColors.danger),
      ('Statements', 12, '', OwnKeepColors.primary),
      ('Tax Docs', 6, '', Color(0xFFF59E0B)),
    ],
    section1Title: 'This Month',
    section1Items: const [
      _DocEntry(
        tag: '₹',
        tagColor: OwnKeepColors.success,
        name: 'Salary Slip - July',
        sub: 'Income  •  ₹1,25,000',
        badgeLabel: 'Income',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.danger,
        name: 'Credit Card Bill',
        sub: 'Due in 4 days  •  ₹18,420',
        badgeLabel: 'Due',
        badgeColor: OwnKeepColors.danger,
      ),
      _DocEntry(
        tag: 'XLS',
        tagColor: Color(0xFF7C3AED),
        name: 'Mutual Fund Summary',
        sub: 'Updated yesterday',
        badgeLabel: 'Invest',
        badgeColor: Color(0xFF7C3AED),
      ),
    ],
    section2Title: 'Pinned Documents',
    section2Items: const [
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.primary,
        name: 'PAN Card',
        sub: 'Identity  •  1.1 MB',
        badgeLabel: 'Pinned',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: Color(0xFFF59E0B),
        name: 'Income Tax Return 2025',
        sub: 'Filed  •  2.8 MB',
        badgeLabel: 'Tax',
        badgeColor: Color(0xFFF59E0B),
      ),
    ],
  );
}

class PropertyCollectionScreen extends StatelessWidget {
  const PropertyCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Property',
    subtitle: 'Home, land and ownership',
    iconData: Icons.home_rounded,
    accentColor: Color(0xFFF59E0B),
    itemCount: 18,
    countLabel: 'property items',
    stats: const [
      ('Properties', 2, '', Color(0xFFF59E0B)),
      ('Legal Docs', 5, '', OwnKeepColors.primary),
      ('Payments', 3, '', OwnKeepColors.success),
      ('Due Soon', 1, '', OwnKeepColors.danger),
    ],
    section1Title: 'Important',
    section1Items: const [
      _DocEntry(
        tag: 'PDF',
        tagColor: Color(0xFFF59E0B),
        name: 'Sale Deed',
        sub: 'Apartment  •  8.4 MB',
        badgeLabel: 'Primary',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.success,
        name: 'Property Tax Receipt',
        sub: 'Paid for 2025',
        badgeLabel: 'Paid',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'DOC',
        tagColor: OwnKeepColors.primary,
        name: 'Home Loan Agreement',
        sub: 'HDFC Bank  •  14 pages',
        badgeLabel: 'Loan',
        badgeColor: OwnKeepColors.primary,
      ),
    ],
    section2Title: 'Maintenance',
    section2Items: const [
      _DocEntry(
        tag: '₹',
        tagColor: OwnKeepColors.danger,
        name: 'Society Maintenance',
        sub: 'Due 10 Aug  •  ₹4,500',
        badgeLabel: 'Due',
        badgeColor: OwnKeepColors.danger,
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: Color(0xFF7C3AED),
        name: 'Home Insurance',
        sub: 'Expires in 42 days',
        badgeLabel: 'Active',
        badgeColor: Color(0xFF7C3AED),
      ),
    ],
  );
}

class VehicleCollectionScreen extends StatelessWidget {
  const VehicleCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Vehicle',
    subtitle: 'Documents, service and expenses',
    iconData: Icons.directions_car_rounded,
    accentColor: OwnKeepColors.ai,
    itemCount: 14,
    countLabel: 'vehicle items',
    stats: const [
      ('Vehicle', 1, '', OwnKeepColors.primary),
      ('Documents', 4, '', Color(0xFF7C3AED)),
      ('Reminders', 2, '', OwnKeepColors.danger),
      ('Fuel', '₹4.8K', '', Color(0xFFF59E0B)),
    ],
    section1Title: 'Vehicle Documents',
    section1Items: const [
      _DocEntry(
        tag: 'RC',
        tagColor: OwnKeepColors.primary,
        name: 'Registration Certificate',
        sub: 'KA 03 MN 4582',
        badgeLabel: 'Active',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.danger,
        name: 'Vehicle Insurance',
        sub: 'Expires in 15 days',
        badgeLabel: 'Due',
        badgeColor: OwnKeepColors.danger,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.success,
        name: 'PUC Certificate',
        sub: 'Valid until 30 Sep',
        badgeLabel: 'Valid',
        badgeColor: OwnKeepColors.success,
      ),
    ],
    section2Title: 'Service & Expenses',
    section2Items: const [
      _DocEntry(
        tag: '🔧',
        tagColor: Color(0xFFF59E0B),
        name: 'Last Service',
        sub: '12 Jul  •  18,450 km',
        badgeLabel: 'Done',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: '₹',
        tagColor: OwnKeepColors.success,
        name: 'Fuel Log',
        sub: '₹4,820 this month',
        badgeLabel: 'Monthly',
        badgeColor: OwnKeepColors.success,
      ),
    ],
  );
}

class EducationCollectionScreen extends StatelessWidget {
  const EducationCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Education',
    subtitle: 'Certificates and learning',
    iconData: Icons.diamond_rounded,
    accentColor: Color(0xFF7C3AED),
    itemCount: 12,
    countLabel: 'education items',
    stats: const [
      ('Certificates', 6, '', Color(0xFF7C3AED)),
      ('Notes', 12, '', OwnKeepColors.primary),
      ('Courses', 3, '', OwnKeepColors.success),
      ('Reminder', 1, '', OwnKeepColors.danger),
    ],
    section1Title: 'Certificates',
    section1Items: const [
      _DocEntry(
        tag: 'DOC',
        tagColor: Color(0xFF7C3AED),
        name: 'B.Tech Degree',
        sub: 'Computer Science  •  4.2 MB',
        badgeLabel: 'Degree',
        badgeColor: Color(0xFF7C3AED),
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.primary,
        name: 'Class X Certificate',
        sub: 'CBSE  •  1.8 MB',
        badgeLabel: 'Academic',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.success,
        name: 'Course Certificate',
        sub: 'Flutter Advanced  •  940 KB',
        badgeLabel: 'Skill',
        badgeColor: OwnKeepColors.success,
      ),
    ],
    section2Title: 'Learning',
    section2Items: const [
      _DocEntry(
        tag: '📝',
        tagColor: Color(0xFFF59E0B),
        name: 'Study Notes',
        sub: '12 notes',
        badgeLabel: 'Notes',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: '📅',
        tagColor: OwnKeepColors.danger,
        name: 'Exam Reminder',
        sub: '20 Aug  •  9:00 AM',
        badgeLabel: 'Upcoming',
        badgeColor: OwnKeepColors.danger,
      ),
    ],
  );
}

class IdentityCollectionScreen extends StatelessWidget {
  const IdentityCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Identity',
    subtitle: 'Your verified identity documents',
    iconData: Icons.credit_card_rounded,
    accentColor: OwnKeepColors.primary,
    itemCount: 24,
    countLabel: 'identity items',
    stats: const [
      ('Primary IDs', 5, '', OwnKeepColors.primary),
      ('Verified', 4, '', OwnKeepColors.success),
      ('Expiring', 1, '', OwnKeepColors.danger),
      ('Copies', 2, '', Color(0xFF7C3AED)),
    ],
    section1Title: 'Government IDs',
    section1Items: const [
      _DocEntry(
        tag: 'ID',
        tagColor: Color(0xFF7C3AED),
        name: 'Aadhaar Card',
        sub: 'Updated 3 months ago',
        badgeLabel: 'Verified',
        badgeColor: Color(0xFF7C3AED),
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.primary,
        name: 'PAN Card',
        sub: 'Permanent account number',
        badgeLabel: 'Verified',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.danger,
        name: 'Passport',
        sub: 'Expires 14 Jun 2031',
        badgeLabel: 'Active',
        badgeColor: OwnKeepColors.danger,
      ),
    ],
    section2Title: 'Other Identity',
    section2Items: const [
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.success,
        name: 'Driving Licence',
        sub: 'Expires in 26 days',
        badgeLabel: 'Due Soon',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: Color(0xFFF59E0B),
        name: 'Voter ID',
        sub: 'Added 12 May',
        badgeLabel: 'Stored',
        badgeColor: Color(0xFFF59E0B),
      ),
    ],
  );
}

class InsuranceCollectionScreen extends StatelessWidget {
  const InsuranceCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Insurance',
    subtitle: 'Policies, claims and renewals',
    iconData: Icons.shield_outlined,
    accentColor: OwnKeepColors.ai,
    itemCount: 16,
    countLabel: 'insurance items',
    stats: const [
      ('Policies', 3, '', OwnKeepColors.primary),
      ('Due Soon', 2, '', OwnKeepColors.danger),
      ('Receipts', 4, '', OwnKeepColors.success),
      ('Claim', 1, '', Color(0xFFF59E0B)),
    ],
    section1Title: 'Policies',
    section1Items: const [
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.success,
        name: 'Health Insurance',
        sub: 'Expires in 16 days',
        badgeLabel: 'Health',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.primary,
        name: 'Vehicle Insurance',
        sub: 'Expires in 15 days',
        badgeLabel: 'Vehicle',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: Color(0xFF7C3AED),
        name: 'Life Insurance',
        sub: 'Premium due 28 Aug',
        badgeLabel: 'Life',
        badgeColor: Color(0xFF7C3AED),
      ),
    ],
    section2Title: 'Claims & Receipts',
    section2Items: const [
      _DocEntry(
        tag: 'PDF',
        tagColor: Color(0xFFF59E0B),
        name: 'Claim Form',
        sub: 'Submitted 12 Apr',
        badgeLabel: 'Claim',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.success,
        name: 'Premium Receipt',
        sub: 'Paid 02 Jul',
        badgeLabel: 'Paid',
        badgeColor: OwnKeepColors.success,
      ),
    ],
  );
}

class TravelCollectionScreen extends StatelessWidget {
  const TravelCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Travel',
    subtitle: 'Trips, tickets and plans',
    iconData: Icons.flight_rounded,
    accentColor: OwnKeepColors.ai,
    itemCount: 6,
    countLabel: 'travel items',
    stats: const [
      ('Upcoming Trip', 1, '', OwnKeepColors.primary),
      ('Bookings', 2, '', Color(0xFF7C3AED)),
      ('Documents', 3, '', OwnKeepColors.success),
      ('Checklist', 1, '', Color(0xFFF59E0B)),
    ],
    section1Title: 'Upcoming Trip',
    section1Items: const [
      _DocEntry(
        tag: '✈️',
        tagColor: OwnKeepColors.primary,
        name: 'Flight Ticket',
        sub: 'Bengaluru → Singapore',
        badgeLabel: '12 Sep',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: '🏨',
        tagColor: Color(0xFF7C3AED),
        name: 'Hotel Booking',
        sub: 'Marina Bay  •  4 nights',
        badgeLabel: 'Booked',
        badgeColor: Color(0xFF7C3AED),
      ),
      _DocEntry(
        tag: 'ID',
        tagColor: OwnKeepColors.success,
        name: 'Travel Insurance',
        sub: 'Valid 11–17 Sep',
        badgeLabel: 'Active',
        badgeColor: OwnKeepColors.success,
      ),
    ],
    section2Title: 'Travel Documents',
    section2Items: const [
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.danger,
        name: 'Passport Copy',
        sub: 'Encrypted copy',
        badgeLabel: 'Ready',
        badgeColor: OwnKeepColors.danger,
      ),
      _DocEntry(
        tag: '📋',
        tagColor: Color(0xFFF59E0B),
        name: 'Packing Checklist',
        sub: '18 items  •  6 completed',
        badgeLabel: 'Checklist',
        badgeColor: Color(0xFFF59E0B),
      ),
    ],
  );
}

class WorkCollectionScreen extends StatelessWidget {
  const WorkCollectionScreen({super.key});
  @override
  Widget build(BuildContext context) => _CategoryCollectionScreen(
    title: 'Work',
    subtitle: 'Career and professional records',
    iconData: Icons.work_outline_rounded,
    accentColor: Color(0xFFF59E0B),
    itemCount: 9,
    countLabel: 'work items',
    stats: const [
      ('Employers', 2, '', OwnKeepColors.primary),
      ('Contracts', 4, '', Color(0xFF7C3AED)),
      ('Payslips', 12, '', OwnKeepColors.success),
      ('Projects', 3, '', Color(0xFFF59E0B)),
    ],
    section1Title: 'Employment',
    section1Items: const [
      _DocEntry(
        tag: 'DOC',
        tagColor: OwnKeepColors.primary,
        name: 'Employment Contract',
        sub: 'CleanDesk AI  •  14 pages',
        badgeLabel: 'Active',
        badgeColor: OwnKeepColors.primary,
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.success,
        name: 'Salary Slip - July',
        sub: '₹1,25,000  •  PDF',
        badgeLabel: 'Recent',
        badgeColor: OwnKeepColors.success,
      ),
      _DocEntry(
        tag: 'DOC',
        tagColor: Color(0xFF7C3AED),
        name: 'Experience Letter',
        sub: 'Previous employer  •  2 pages',
        badgeLabel: 'Archived',
        badgeColor: Color(0xFF7C3AED),
      ),
    ],
    section2Title: 'Projects',
    section2Items: const [
      _DocEntry(
        tag: '📝',
        tagColor: Color(0xFFF59E0B),
        name: 'Project Notes',
        sub: 'OwnKeep  •  28 notes',
        badgeLabel: 'Personal',
        badgeColor: Color(0xFFF59E0B),
      ),
      _DocEntry(
        tag: 'PDF',
        tagColor: OwnKeepColors.danger,
        name: 'Portfolio PDF',
        sub: 'Updated last week',
        badgeLabel: 'Portfolio',
        badgeColor: OwnKeepColors.danger,
      ),
    ],
  );
}

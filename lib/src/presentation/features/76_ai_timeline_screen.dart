import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiTimelineScreen extends StatefulWidget {
  const AiTimelineScreen({super.key});
  @override
  State<AiTimelineScreen> createState() => _AiTimelineScreenState();
}

class _AiTimelineScreenState extends State<AiTimelineScreen> {
  int _tab = 0;
  final _tabs = ['All', 'Documents', 'Events', 'Reminders', 'Insights'];

  final _events = [
    (Color(0xFFF59E0B), Color(0xFF7A3D0A), Icons.notifications_outlined, 'Vehicle insurance reminder created', 'Expires in 15 days', 'Today'),
    (OwnKeepColors.pink, Color(0xFF7A1A2E), Icons.favorite_rounded, 'Health report added', 'AI detected 4 lab values', 'Yesterday'),
    (OwnKeepColors.ai, Color(0xFF0A3D3D), Icons.crop_square_rounded, 'Vehicle serviced', 'Odometer: 18,450 km', '12 July'),
    (OwnKeepColors.primary, Color(0xFF1A3D7A), Icons.picture_as_pdf_outlined, 'Passport document updated', 'New scan replaced older copy', '10 June'),
    (Color(0xFF7C3AED), Color(0xFF3D1A7A), Icons.crop_square_rounded, 'Doctor appointment', 'Dr. R. Sharma  •  4:00 PM', '15 May'),
    (OwnKeepColors.success, Color(0xFF0A4A2E), Icons.currency_rupee_rounded, 'Income tax return filed', 'FY 2024–25', '03 April'),
  ];

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
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('AI Timeline', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('A meaningful view of your life', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.crop_square_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 2),
      body: Column(children: [
        // Filter tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
          child: Row(children: _tabs.asMap().entries.map((e) => GestureDetector(
            onTap: () => setState(() => _tab = e.key),
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _tab == e.key ? OwnKeepColors.primary : OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _tab == e.key ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Text(e.value, style: TextStyle(
                color: _tab == e.key ? Colors.white : OwnKeepColors.darkTextSecondary,
                fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter',
              )),
            ),
          )).toList()),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, 0, OwnKeepSpacing.base, OwnKeepSpacing.base),
            itemCount: _events.length,
            itemBuilder: (context, i) {
              final ev = _events[i];
              return IntrinsicHeight(
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Timeline column
                  SizedBox(width: 80,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.only(top: 14, right: 12),
                        child: Text(ev.$6, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                      ),
                    ]),
                  ),
                  // Dot + line
                  Column(children: [
                    Container(width: 14, height: 14, margin: EdgeInsets.only(top: 14), decoration: BoxDecoration(color: ev.$1, shape: BoxShape.circle)),
                    if (i < _events.length - 1)
                      Expanded(child: Container(width: 1.5, color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
                  ]),
                  SizedBox(width: 12),
                  // Card
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm, top: 6),
                      padding: EdgeInsets.all(OwnKeepSpacing.md),
                      decoration: BoxDecoration(
                        color: OwnKeepColors.darkSurfaceElevated,
                        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(color: ev.$2, borderRadius: BorderRadius.circular(10)),
                          child: Icon(ev.$3, color: Colors.white.withValues(alpha: 0.85), size: 18),
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(ev.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                          Text(ev.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                        ])),
                      ]),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

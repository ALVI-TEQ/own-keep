import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _viewShared = true;
  bool _addDocs = true;
  bool _editMeta = true;
  bool _deleteDocs = false;
  bool _exportFiles = false;

  @override
  Widget build(BuildContext context) {
    final generalToggles = [
      (Icons.crop_square_rounded, OwnKeepColors.primary, 'View shared collections', 'Can open permitted items', _viewShared, (v) => setState(() => _viewShared = v)),
      (Icons.add_box_outlined, OwnKeepColors.success, 'Add documents', 'Can add files to shared collections', _addDocs, (v) => setState(() => _addDocs = v)),
      (Icons.edit_outlined, OwnKeepColors.ai, 'Edit metadata', 'Can rename, tag and add notes', _editMeta, (v) => setState(() => _editMeta = v)),
      (Icons.delete_outline_rounded, OwnKeepColors.danger, 'Delete documents', 'Requires owner confirmation', _deleteDocs, (v) => setState(() => _deleteDocs = v)),
      (Icons.download_rounded, Color(0xFFF59E0B), 'Export shared files', 'Can create encrypted exports', _exportFiles, (v) => setState(() => _exportFiles = v)),
    ];

    const collectionAccess = [
      (Icons.crop_square_rounded, OwnKeepColors.primary, 'Family Documents', 'Full access', 'Full access', OwnKeepColors.primary),
      (Icons.favorite_rounded, OwnKeepColors.pink, 'Health Records', 'View only', 'View only', OwnKeepColors.danger),
      (Icons.home_rounded, Color(0xFFF59E0B), 'Property Papers', 'No access', 'No access', Color(0xFFF59E0B)),
      (Icons.diamond_rounded, Color(0xFF7C3AED), 'Education', 'Full access', 'Full access', OwnKeepColors.primary),
    ];

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
          Text('Permissions', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Harika  •  Adult', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Member header
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: OwnKeepColors.pink, shape: BoxShape.circle),
                child: const Center(child: Text('H', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Harika', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                Text('Family member  •  Active', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ]),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('General Access', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...generalToggles.map((t) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: t.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(9)),
                child: Icon(t.$1, color: t.$2, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                Text(t.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Switch(value: t.$5, onChanged: t.$6, activeThumbColor: OwnKeepColors.primary),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Collection Access', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...collectionAccess.map((c) => Container(
            margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: c.$2.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(9)),
                child: Icon(c.$1, color: c.$2, size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(c.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(c.$4, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: c.$6,
                  side: BorderSide(color: c.$6),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(c.$5, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.$6, fontFamily: 'Inter')),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});
  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  final _nameController = TextEditingController(text: 'Harika');
  int _selectedRole = 0; // 0=Adult, 1=Child, 2=Trusted

  final _roles = [
    ('Adult', 'Full family access'),
    ('Child', 'Limited by collection'),
    ('Trusted Contact', 'Emergency-only access'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
          Text('Invite Member', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Create an offline encrypted invitation', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.help_outline_rounded, color: OwnKeepColors.darkTextSecondary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Member Name
          Text('Member Name', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          TextField(
            controller: _nameController,
            style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            decoration: InputDecoration(
              filled: true, fillColor: OwnKeepColors.darkSurfaceElevated,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md), borderSide: const BorderSide(color: OwnKeepColors.primary, width: 1.5)),
              isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Role
          Text('Role', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ..._roles.asMap().entries.map((e) => GestureDetector(
            onTap: () => setState(() => _selectedRole = e.key),
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 14),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                border: Border.all(
                  color: _selectedRole == e.key ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                  width: _selectedRole == e.key ? 1.5 : 1,
                ),
              ),
              child: Row(children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _selectedRole == e.key ? OwnKeepColors.primary : OwnKeepColors.darkTextMuted, width: 2),
                    color: _selectedRole == e.key ? OwnKeepColors.primary : Colors.transparent,
                  ),
                  child: _selectedRole == e.key ? Icon(Icons.circle, color: Colors.white, size: 8) : null,
                ),
                SizedBox(width: OwnKeepSpacing.md),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(e.value.$1, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  Text(e.value.$2, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                ]),
              ]),
            ),
          )),
          SizedBox(height: OwnKeepSpacing.xl),
          // Invitation Method
          Text('Invitation Method', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          ...[
            (Color(0xFF7C3AED), Color(0xFF3D1A7A), Icons.grid_view_rounded, 'QR Code', 'Scan directly on the second device'),
            (OwnKeepColors.ai, Color(0xFF0A3D3D), Icons.compare_arrows_rounded, 'Nearby Transfer', 'Send over local network'),
            (OwnKeepColors.success, Color(0xFF0A4A2E), Icons.download_rounded, 'Encrypted File', 'Save a portable invitation package'),
          ].map((m) => Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: m.$2, borderRadius: BorderRadius.circular(9)),
                child: Icon(m.$3, color: Colors.white.withValues(alpha: 0.85), size: 18),
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.$4, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                Text(m.$5, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
              ])),
              Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            ]),
          )),
          SizedBox(height: OwnKeepSpacing.sm),
          // Expiry note
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Invitation expires', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 11, fontFamily: 'Inter')),
                Text('24 hours after creation', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ]),
              Text('Change', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.base),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Create Invitation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
        ]),
      ),
    );
  }
}

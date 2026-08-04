import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class MoveOrCopyScreen extends StatefulWidget {
  const MoveOrCopyScreen({super.key});

  @override
  State<MoveOrCopyScreen> createState() => _MoveOrCopyScreenState();
}

class _MoveOrCopyScreenState extends State<MoveOrCopyScreen> {
  bool _keepOriginal = true;
  String? _selected;

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Move or Copy', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Choose destination', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Column(
        children: [
          // Selected item banner
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Selected item', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
                  SizedBox(height: 2),
                  Text('Passport.pdf', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                ]),
                Text('1.2 MB', style: TextStyle(color: OwnKeepColors.primary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              ],
            ),
          ),

          // Destination label
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Destination', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),

          // Destination list
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
              children: [
                _DestTile(icon: Icons.circle, iconColor: OwnKeepColors.primary, label: 'Personal', count: '28 items', selected: _selected == 'Personal', onTap: () => setState(() => _selected = 'Personal')),
                _DestTile(icon: Icons.square_rounded, iconColor: OwnKeepColors.success, label: 'Finance', count: '16 items', selected: _selected == 'Finance', onTap: () => setState(() => _selected = 'Finance')),
                _DestTile(icon: Icons.favorite_rounded, iconColor: OwnKeepColors.pink, label: 'Health', count: '12 items', selected: _selected == 'Health', onTap: () => setState(() => _selected = 'Health')),
                _DestTile(icon: Icons.home_rounded, iconColor: OwnKeepColors.warning, label: 'Property', count: '9 items', selected: _selected == 'Property', onTap: () => setState(() => _selected = 'Property')),
                _DestTile(icon: Icons.article_rounded, iconColor: OwnKeepColors.ai, label: 'Vehicle', count: '8 items', selected: _selected == 'Vehicle', onTap: () => setState(() => _selected = 'Vehicle')),
                _DestTile(icon: Icons.diamond_rounded, iconColor: OwnKeepColors.ai, label: 'Education', count: '6 items', selected: _selected == 'Education', onTap: () => setState(() => _selected = 'Education')),
                _DestTile(icon: Icons.add, iconColor: OwnKeepColors.warning, label: 'New Folder', count: 'Create a new destination', selected: false, onTap: () {}),
              ],
            ),
          ),

          // Copy / Move buttons
          Padding(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: OwnKeepColors.primary,
                          side: BorderSide(color: OwnKeepColors.darkSurfaceElevated),
                          backgroundColor: OwnKeepColors.darkSurfaceElevated,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                        ),
                        child: Text('Copy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ),
                    ),
                    SizedBox(width: OwnKeepSpacing.md),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: OwnKeepColors.primary,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                        ),
                        child: Text('Move', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: OwnKeepSpacing.md),
                // Keep original toggle
                Container(
                  padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.sm),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.darkSurfaceElevated,
                    borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                    border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: Text('Keep original location', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'))),
                      Switch(value: _keepOriginal, onChanged: (v) => setState(() => _keepOriginal = v), activeThumbColor: OwnKeepColors.primary),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DestTile extends StatelessWidget {
  const _DestTile({required this.icon, required this.iconColor, required this.label, required this.count, required this.selected, required this.onTap});
  final IconData icon;
  final Color iconColor;
  final String label;
  final String count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
      decoration: BoxDecoration(
        color: selected ? OwnKeepColors.primary.withValues(alpha: 0.12) : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: selected ? OwnKeepColors.primary.withValues(alpha: 0.4) : OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        title: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
        subtitle: Text(count, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        trailing: Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
      ),
    );
  }
}

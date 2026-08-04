import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class MoveToScreen extends StatefulWidget {
  const MoveToScreen({super.key});

  @override
  State<MoveToScreen> createState() => _MoveToScreenState();
}

class _MoveToScreenState extends State<MoveToScreen> {
  String? _selected;

  final _collections = [
    ('Personal', '28 items', OwnKeepColors.primary, Icons.circle),
    ('Finance', '16 items', OwnKeepColors.success, Icons.currency_rupee_rounded),
    ('Health', '12 items', OwnKeepColors.pink, Icons.favorite_rounded),
    ('Property', '9 items', OwnKeepColors.warning, Icons.home_rounded),
    ('Vehicle', '8 items', OwnKeepColors.ai, Icons.article_rounded),
    ('Education', '6 items', OwnKeepColors.ai, Icons.diamond_rounded),
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Move To', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Choose destination', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected files banner
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Selected', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Text('3 files  •  6.7 MB', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            ]),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: Text('Collections', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
              children: [
                ..._collections.map((col) => _CollectionTile(
                  label: col.$1, count: col.$2, color: col.$3, icon: col.$4,
                  selected: _selected == col.$1,
                  onTap: () => setState(() => _selected = col.$1),
                )),
                _CollectionTile(
                  label: 'Create New Folder', count: 'Add destination',
                  color: OwnKeepColors.warning, icon: Icons.add,
                  selected: false, onTap: () {},
                ),
              ],
            ),
          ),
          // Move Here button
          Padding(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: OwnKeepColors.primary,
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
                ),
                child: Text('Move Here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({required this.label, required this.count, required this.color, required this.icon, required this.selected, required this.onTap});
  final String label, count;
  final Color color;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
      decoration: BoxDecoration(
        color: selected ? OwnKeepColors.primary.withValues(alpha: 0.1) : OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: selected ? OwnKeepColors.primary.withValues(alpha: 0.4) : OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
        subtitle: Text(count, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        trailing: Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class MultiSelectScreen extends StatefulWidget {
  const MultiSelectScreen({super.key});

  @override
  State<MultiSelectScreen> createState() => _MultiSelectScreenState();
}

class _MultiSelectScreenState extends State<MultiSelectScreen> {
  final List<_FileItem> _files = [
    _FileItem(name: 'Passport.pdf', type: 'PDF', size: '1.2 MB', tag: 'PDF', tagColor: const Color(0xFFCC2200), selected: true),
    _FileItem(name: 'Insurance Policy.pdf', type: 'PDF', size: '2.4 MB', tag: 'PDF', tagColor: const Color(0xFFCC2200), selected: true),
    _FileItem(name: 'Driving Licence.jpg', type: 'JPG', size: '860 KB', tag: 'IMG', tagColor: const Color(0xFF1A8C4E), selected: false),
    _FileItem(name: 'Bank Statement.pdf', type: 'PDF', size: '3.1 MB', tag: 'PDF', tagColor: const Color(0xFFCC2200), selected: true),
    _FileItem(name: 'Family Photo.jpg', type: 'JPG', size: '4.6 MB', tag: 'IMG', tagColor: const Color(0xFF1A8C4E), selected: false),
    _FileItem(name: 'Project Plan.docx', type: 'DOCX', size: '520 KB', tag: 'DOC', tagColor: const Color(0xFF1A5FA8), selected: false),
    _FileItem(name: 'Investment Summary.xlsx', type: 'XLSX', size: '540 KB', tag: 'XLS', tagColor: const Color(0xFF1A7A3C), selected: false),
  ];

  int get _selectedCount => _files.where((f) => f.selected).length;

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
          children: [
            Text('Select Items', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('$_selectedCount selected', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: OwnKeepSpacing.sm),
              itemCount: _files.length,
              itemBuilder: (context, i) {
                final file = _files[i];
                return GestureDetector(
                  onTap: () => setState(() => file.selected = !file.selected),
                  child: Container(
                    margin: EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                    decoration: BoxDecoration(
                      color: file.selected
                          ? OwnKeepColors.primary.withValues(alpha: 0.1)
                          : OwnKeepColors.darkSurfaceElevated,
                      borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                      border: Border.all(
                        color: file.selected
                            ? OwnKeepColors.primary.withValues(alpha: 0.5)
                            : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
                      child: Row(
                        children: [
                          // Checkbox or file icon
                          if (file.selected)
                            Container(
                              width: 26, height: 26,
                              decoration: BoxDecoration(color: OwnKeepColors.primary, borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.check_rounded, color: Colors.white, size: 16),
                            )
                          else
                            SizedBox(width: 26, height: 26),
                          SizedBox(width: 12),
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: file.tagColor.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)),
                            child: Center(child: Text(file.tag, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                          ),
                          SizedBox(width: OwnKeepSpacing.md),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(file.name, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                            Text('${file.type} • ${file.size}', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
                          ])),
                          Icon(Icons.more_vert_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Action bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.xl, vertical: OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(top: BorderSide(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ActionBtn(icon: Icons.drive_file_move_outlined, label: 'Move', color: OwnKeepColors.primary),
                _ActionBtn(icon: Icons.copy_outlined, label: 'Copy', color: OwnKeepColors.darkTextSecondary),
                _ActionBtn(icon: Icons.ios_share_rounded, label: 'Share', color: OwnKeepColors.success),
                _ActionBtn(icon: Icons.backspace_outlined, label: 'Delete', color: OwnKeepColors.danger),
              ],
            ),
          ),
          OwnKeepBottomNav(currentIndex: 1),
        ],
      ),
    );
  }
}

class _FileItem {
  _FileItem({required this.name, required this.type, required this.size, required this.tag, required this.tagColor, required this.selected});
  final String name, type, size, tag;
  final Color tagColor;
  bool selected;
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: color, size: 22),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontFamily: 'Inter', fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

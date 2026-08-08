import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class CustomCollectionScreen extends StatefulWidget {
  const CustomCollectionScreen({super.key});

  @override
  State<CustomCollectionScreen> createState() => _CustomCollectionScreenState();
}

class _CustomCollectionScreenState extends State<CustomCollectionScreen> {
  final _nameController = TextEditingController(text: 'Family Records');
  int _selectedIcon = 0;
  int _selectedColor = 1; // purple default

  bool _autoAdd = true;
  bool _suggestReminders = true;
  bool _aiOrg = true;
  bool _showOnHome = false;

  final _icons = [
    (Icons.favorite_rounded, const Color(0xFF7A1A2E)),
    (Icons.home_rounded, const Color(0xFF7A3D0A)),
    (Icons.circle, const Color(0xFF1A3D7A)),
    (Icons.diamond_rounded, const Color(0xFF3D1A7A)),
    (Icons.crop_square_rounded, const Color(0xFF0A4A2E)),
    (Icons.auto_awesome_rounded, const Color(0xFF0A3D3D)),
  ];

  final _colors = [
    OwnKeepColors.primary,
    const Color(0xFF7C3AED),
    OwnKeepColors.success,
    const Color(0xFFF59E0B),
    const Color(0xFFEF4444),
    OwnKeepColors.pink,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _colors[_selectedColor];
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
          children: const [
            Text(
              'Custom Collection',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Create your own category',
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
              color: OwnKeepColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_rounded,
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
          // Name
            Text(
              'Collection Name',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
          TextField(
            controller: _nameController,
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            decoration: InputDecoration(
                filled: true,
                fillColor: OwnKeepColors.darkSurfaceElevated,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: const BorderSide(color: OwnKeepColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: BorderSide(
                    color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                  borderSide: const BorderSide(
                    color: OwnKeepColors.primary,
                    width: 1.5,
                  ),
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Icon picker
            Text(
              'Choose Icon',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
          Row(
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (e) => GestureDetector(
              onTap: () => setState(() => _selectedIcon = e.key),
              child: Container(
                        margin: EdgeInsets.only(
                          right: e.key < _icons.length - 1 ? 10 : 0,
                        ),
                        width: 52,
                        height: 52,
                decoration: BoxDecoration(
                  color: e.value.$2,
                  borderRadius: BorderRadius.circular(14),
                          border: _selectedIcon == e.key
                              ? Border.all(color: accentColor, width: 2.5)
                              : null,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                e.value.$1,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 24,
                              ),
                ),
                  if (_selectedIcon == e.key)
                    const Positioned(
                                top: 3,
                                right: 3,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 14,
                    ),
              ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Color picker
            Text(
              'Theme Color',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
          Row(
              children: _colors
                  .asMap()
                  .entries
                  .map(
                    (e) => GestureDetector(
              onTap: () => setState(() => _selectedColor = e.key),
              child: Container(
                        margin: EdgeInsets.only(
                          right: e.key < _colors.length - 1 ? 10 : 0,
                        ),
                        width: 40,
                        height: 40,
                decoration: BoxDecoration(
                  color: e.value,
                  shape: BoxShape.circle,
                  border: _selectedColor == e.key
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                  boxShadow: _selectedColor == e.key
                              ? [
                                  BoxShadow(
                                    color: e.value.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                  ),
                                ]
                      : null,
                ),
              ),
                    ),
                  )
                  .toList(),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Smart Rules
            Text(
              'Smart Rules',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
            _ToggleRow(
              title: 'Auto-add by tag',
              subtitle: '#family',
              value: _autoAdd,
              onChanged: (v) => setState(() => _autoAdd = v),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
            _ToggleRow(
              title: 'Suggest reminders',
              subtitle: 'From detected dates',
              value: _suggestReminders,
              onChanged: (v) => setState(() => _suggestReminders = v),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
            _ToggleRow(
              title: 'Allow AI organization',
              subtitle: 'Runs only on device',
              value: _aiOrg,
              onChanged: (v) => setState(() => _aiOrg = v),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
            _ToggleRow(
              title: 'Show on Home',
              subtitle: 'Pin as smart collection',
              value: _showOnHome,
              onChanged: (v) => setState(() => _showOnHome = v),
            ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Live preview
            Text(
              'Preview',
              style: TextStyle(
                color: OwnKeepColors.darkTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          SizedBox(height: OwnKeepSpacing.sm),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: accentColor.withValues(alpha: 0.5)),
            ),
              child: Row(
                children: [
              Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _icons[_selectedIcon].$2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _icons[_selectedIcon].$1,
                      color: Colors.white.withValues(alpha: 0.8),
                      size: 18,
                    ),
              ),
              SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _nameController.text.isEmpty
                              ? 'Untitled'
                              : _nameController.text,
                          style: TextStyle(
                            color: OwnKeepColors.darkTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '0 items  •  Ready to use',
                          style: TextStyle(
                            color: OwnKeepColors.darkTextSecondary,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: OwnKeepColors.darkTextMuted,
                    size: 20,
                  ),
                ],
              ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: accentColor,
              minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                ),
              ),
              child: Text(
                'Create Collection',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(
          color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: OwnKeepColors.darkTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: OwnKeepColors.primary,
          ),
        ],
      ),
    );
  }
}

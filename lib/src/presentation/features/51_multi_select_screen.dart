import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class MultiSelectScreen extends StatefulWidget {
  const MultiSelectScreen({super.key});

  @override
  State<MultiSelectScreen> createState() => _MultiSelectScreenState();
}

class _MultiSelectScreenState extends State<MultiSelectScreen> {
  // Using fixture data
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'titleKey': 's51_passport',
      'metaKey': 's51_passport_meta',
      'icon': OwnKeepMainIcons.file_pdf,
      'color': const Color(0xFFEF4444), // red
      'selected': true,
    },
    {
      'id': '2',
      'titleKey': 's51_insurance',
      'metaKey': 's51_insurance_meta',
      'icon': OwnKeepMainIcons.file_pdf,
      'color': const Color(0xFFEF4444),
      'selected': true,
    },
    {
      'id': '3',
      'titleKey': 's51_licence',
      'metaKey': 's51_licence_meta',
      'icon': OwnKeepMainIcons.file_image,
      'color': const Color(0xFF06B6D4), // cyan
      'selected': true,
    },
    {
      'id': '4',
      'titleKey': 's51_bank',
      'metaKey': 's51_bank_meta',
      'icon': OwnKeepMainIcons.file_pdf,
      'color': const Color(0xFFEF4444),
      'selected': false,
    },
    {
      'id': '5',
      'titleKey': 's51_photo',
      'metaKey': 's51_photo_meta',
      'icon': OwnKeepMainIcons.file_image,
      'color': const Color(0xFF06B6D4),
      'selected': false,
    },
    {
      'id': '6',
      'titleKey': 's51_project',
      'metaKey': 's51_project_meta',
      'icon': OwnKeepMainIcons.file_doc,
      'color': const Color(0xFF4F46E5), // blue
      'selected': false,
    },
    {
      'id': '7',
      'titleKey': 's51_investment',
      'metaKey': 's51_investment_meta',
      'icon': OwnKeepMainIcons.file_xls,
      'color': const Color(0xFF10B981), // green
      'selected': false,
    },
  ];

  void _toggleSelection(int index) {
    setState(() {
      _items[index]['selected'] = !(_items[index]['selected'] as bool);
    });
  }

  String _getLocalizedString(AppLocalizations l10n, String key) {
    switch (key) {
      case 's51_passport': return l10n.s51_passport;
      case 's51_passport_meta': return l10n.s51_passport_meta;
      case 's51_insurance': return l10n.s51_insurance;
      case 's51_insurance_meta': return l10n.s51_insurance_meta;
      case 's51_licence': return l10n.s51_licence;
      case 's51_licence_meta': return l10n.s51_licence_meta;
      case 's51_bank': return l10n.s51_bank;
      case 's51_bank_meta': return l10n.s51_bank_meta;
      case 's51_photo': return l10n.s51_photo;
      case 's51_photo_meta': return l10n.s51_photo_meta;
      case 's51_project': return l10n.s51_project;
      case 's51_project_meta': return l10n.s51_project_meta;
      case 's51_investment': return l10n.s51_investment;
      case 's51_investment_meta': return l10n.s51_investment_meta;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    
    final selectedCount = _items.where((item) => item['selected'] as bool).length;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.close, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              l10n.s51_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              '$selectedCount selected', // Hardcoded fallback or we could use l10n string replacement if it supports args
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.confirm, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selection confirmed')),
              );
              context.pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final isSelected = item['selected'] as bool;
          
          return GestureDetector(
            onTap: () => _toggleSelection(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: isSelected ? colors.surfaceSelected : colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? colors.primaryBlue : colors.borderSoft,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.backgroundTop,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      item['icon'] as String,
                      colorFilter: ColorFilter.mode(item['color'] as Color, BlendMode.srcIn),
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getLocalizedString(l10n, item['titleKey'] as String),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _getLocalizedString(l10n, item['metaKey'] as String),
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    SvgPicture.asset(
                      OwnKeepMainIcons.selection_checked,
                      colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                      width: 24,
                      height: 24,
                    )
                  else
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.borderSoft, width: 1.5),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: OwnKeepSpacing.md,
          right: OwnKeepSpacing.md,
          top: OwnKeepSpacing.md,
          bottom: MediaQuery.of(context).padding.bottom + OwnKeepSpacing.md,
        ),
        decoration: BoxDecoration(
          color: colors.navigationBackground,
          border: Border(top: BorderSide(color: colors.borderSoft)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAction(colors, OwnKeepMainIcons.move, 'common_move', l10n),
            _buildAction(colors, OwnKeepMainIcons.copy, 'common_copy', l10n),
            _buildAction(colors, OwnKeepMainIcons.share, 'common_share', l10n),
            _buildAction(colors, OwnKeepMainIcons.delete, 'common_delete', l10n, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(OwnKeepMainColorsTheme colors, String icon, String key, AppLocalizations l10n, {bool isDestructive = false}) {
    final color = isDestructive ? colors.dangerRed : colors.textPrimary;
    
    String label = '';
    switch (key) {
      case 'common_move': label = l10n.common_move; break;
      case 'common_copy': label = l10n.common_copy; break;
      case 'common_share': label = l10n.common_share; break;
      case 'common_delete': label = l10n.common_delete; break;
    }

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action $label executed on selected items')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: 24, height: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

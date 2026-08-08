import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class MoveToScreen extends StatefulWidget {
  const MoveToScreen({super.key});

  @override
  State<MoveToScreen> createState() => _MoveToScreenState();
}

class _MoveToScreenState extends State<MoveToScreen> {
  String _selectedFolderId = '';

  final List<Map<String, dynamic>> _collections = [
    {
      'id': 'personal',
      'titleKey': 'collection_personal',
      'subtitleKey': 's52_personal_count',
      'icon': OwnKeepMainIcons.personal_category,
      'color': const Color(0xFF4F46E5), // blue
    },
    {
      'id': 'finance',
      'titleKey': 'collection_finance',
      'subtitleKey': 's52_finance_count',
      'icon': OwnKeepMainIcons.finance_category,
      'color': const Color(0xFF10B981), // green
    },
    {
      'id': 'health',
      'titleKey': 'collection_health',
      'subtitleKey': 's52_health_count',
      'icon': OwnKeepMainIcons.health_category,
      'color': const Color(0xFFEF4444), // red
    },
    {
      'id': 'property',
      'titleKey': 'collection_property',
      'subtitleKey': 's52_property_count',
      'icon': OwnKeepMainIcons.property_category,
      'color': const Color(0xFFF59E0B), // orange
    },
    {
      'id': 'vehicle',
      'titleKey': 'collection_vehicle',
      'subtitleKey': 's52_vehicle_count',
      'icon': OwnKeepMainIcons.vehicle_category,
      'color': const Color(0xFF06B6D4), // cyan
    },
    {
      'id': 'education',
      'titleKey': 'collection_education',
      'subtitleKey': 's52_education_count',
      'icon': OwnKeepMainIcons.education_category,
      'color': const Color(0xFF8B5CF6), // purple
    },
  ];

  String _getLocalizedString(AppLocalizations l10n, String key) {
    switch (key) {
      case 'collection_personal':
        return l10n.collection_personal;
      case 's52_personal_count':
        return l10n.s52_personal_count;
      case 'collection_finance':
        return l10n.collection_finance;
      case 's52_finance_count':
        return l10n.s52_finance_count;
      case 'collection_health':
        return l10n.collection_health;
      case 's52_health_count':
        return l10n.s52_health_count;
      case 'collection_property':
        return l10n.collection_property;
      case 's52_property_count':
        return l10n.s52_property_count;
      case 'collection_vehicle':
        return l10n.collection_vehicle;
      case 's52_vehicle_count':
        return l10n.s52_vehicle_count;
      case 'collection_education':
        return l10n.collection_education;
      case 's52_education_count':
        return l10n.s52_education_count;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              l10n.s52_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s52_subtitle,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(
              OwnKeepSpacing.md,
            ).copyWith(bottom: 100),
            children: [
              _buildSectionTitle(l10n.s52_selected, colors),
              const SizedBox(height: OwnKeepSpacing.sm),
              Container(
                padding: const EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.borderSoft),
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
                        OwnKeepMainIcons.selection_checked,
                        colorFilter: ColorFilter.mode(
                          colors.primaryBlue,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: OwnKeepSpacing.md),
                    Text(
                      l10n.s52_selected_summary,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: OwnKeepSpacing.xl),
              _buildSectionTitle(l10n.s52_collections, colors),
              const SizedBox(height: OwnKeepSpacing.sm),
              ..._collections.map((item) {
                final isSelected = _selectedFolderId == item['id'];
                return _buildFolderItem(
                  colors,
                  icon: item['icon'] as String,
                  title: _getLocalizedString(l10n, item['titleKey'] as String),
                  subtitle: _getLocalizedString(
                    l10n,
                    item['subtitleKey'] as String,
                  ),
                  iconColor: item['color'] as Color,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedFolderId = item['id'] as String;
                    });
                  },
                );
              }),
              const SizedBox(height: OwnKeepSpacing.sm),
              _buildFolderItem(
                colors,
                icon: OwnKeepMainIcons.new_folder,
                title: l10n.s52_create_folder,
                subtitle: l10n.s52_create_folder_body,
                iconColor: colors.textPrimary,
                isSelected: false,
                isDashed: true,
                onTap: () => context.push('/features/tag-manager'),
              ),
            ],
          ),

          if (_selectedFolderId.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: OwnKeepSpacing.md,
                  right: OwnKeepSpacing.md,
                  top: OwnKeepSpacing.md,
                  bottom:
                      MediaQuery.of(context).padding.bottom + OwnKeepSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: colors.navigationBackground,
                  border: Border(top: BorderSide(color: colors.borderSoft)),
                ),
                child: ElevatedButton(
                  onPressed: () => context.push('/features/multi-select'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.s52_move_here,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, OwnKeepMainColorsTheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFolderItem(
    OwnKeepMainColorsTheme colors, {
    required String icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required bool isSelected,
    bool isDashed = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceSelected : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
            width: isSelected ? 1.5 : 1,
            // If dashed, we should ideally use a DashedBorder package, but we'll fall back to solid border for now
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
                icon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    subtitle,
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
                colorFilter: ColorFilter.mode(
                  colors.primaryBlue,
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              )
            else
              SvgPicture.asset(
                OwnKeepMainIcons.chevron_right,
                colorFilter: ColorFilter.mode(
                  colors.textMuted,
                  BlendMode.srcIn,
                ),
                width: 20,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}

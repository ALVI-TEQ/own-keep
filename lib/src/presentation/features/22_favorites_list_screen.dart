import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class FavoritesListScreen extends StatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  State<FavoritesListScreen> createState() => _FavoritesListScreenState();
}

class _FavoritesListScreenState extends State<FavoritesListScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final filters = [
      l10n.common_all,
      l10n.common_documents,
      l10n.common_images,
      l10n.common_others,
    ];

    final favoriteItems = [
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s22_passport,
        'meta': l10n.s22_passport_meta,
        'date': l10n.s22_passport_date,
      },
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s22_insurance,
        'meta': l10n.s22_insurance_meta,
        'date': l10n.common_yesterday,
      },
      {
        'icon': OwnKeepMainIcons.image,
        'title': l10n.s22_family_photo,
        'meta': l10n.s22_family_photo_meta,
        'date': l10n.s22_family_photo_date,
      },
      {
        'icon': OwnKeepMainIcons.identity,
        'title': l10n.s22_aadhaar,
        'meta': l10n.s22_aadhaar_meta,
        'date': l10n.s22_aadhaar_date,
      },
      {
        'icon': OwnKeepMainIcons.document,
        'title': l10n.s22_licence,
        'meta': l10n.s22_licence_meta,
        'date': l10n.s22_licence_date,
      },
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s22_bank,
        'meta': l10n.s22_bank_meta,
        'date': l10n.s22_bank_date,
      },
      {
        'icon': OwnKeepMainIcons.spreadsheet,
        'title': l10n.s22_itr,
        'meta': l10n.s22_itr_meta,
        'date': l10n.s22_itr_date,
      },
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s22_property,
        'meta': l10n.s22_property_meta,
        'date': l10n.s22_property_date,
      },
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s22_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.more_vertical, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.sm),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: OwnKeepSpacing.sm),
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected ? colors.primaryBlue : colors.borderSoft,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : colors.textSecondary,
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              itemCount: favoriteItems.length,
              separatorBuilder: (context, index) => const Divider(color: Color(0xFF1B2940), height: OwnKeepSpacing.lg),
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.surfacePrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.borderSoft),
                        ),
                        child: SvgPicture.asset(
                          item['icon']!,
                          colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
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
                              item['title']!,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['meta']!,
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            OwnKeepMainIcons.favorite,
                            colorFilter: const ColorFilter.mode(Color(0xFFFFC23A), BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              color: colors.textMuted,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

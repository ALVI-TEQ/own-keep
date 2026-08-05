import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class RecentlyDeletedScreen extends StatelessWidget {
  const RecentlyDeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final deletedItems = [
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s23_old_insurance,
        'meta': l10n.s23_old_insurance_meta,
        'date': l10n.s23_old_insurance_date,
      },
      {
        'icon': OwnKeepMainIcons.image,
        'title': l10n.s23_screenshot,
        'meta': l10n.s23_screenshot_meta,
        'date': l10n.s23_screenshot_date,
      },
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s23_bank,
        'meta': l10n.s23_bank_meta,
        'date': l10n.s23_bank_date,
      },
      {
        'icon': OwnKeepMainIcons.image,
        'title': l10n.s23_image,
        'meta': l10n.s23_image_meta,
        'date': l10n.s23_image_date,
      },
      {
        'icon': OwnKeepMainIcons.file_pdf,
        'title': l10n.s23_tax,
        'meta': l10n.s23_tax_meta,
        'date': l10n.s23_tax_date,
      },
      {
        'icon': OwnKeepMainIcons.document,
        'title': l10n.s23_project,
        'meta': l10n.s23_project_meta,
        'date': l10n.s23_project_date,
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
          l10n.s23_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              l10n.s23_select,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: const EdgeInsets.all(OwnKeepSpacing.lg),
            padding: const EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceSelected.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSoft),
            ),
            child: Row(
              children: [
                SvgPicture.asset(OwnKeepMainIcons.info, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.s23_trash_notice,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.s23_trash_notice_body,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Header stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s23_item_count,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                Row(
                  children: [
                    Text(
                      l10n.s23_sort,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(OwnKeepMainIcons.sort, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: OwnKeepSpacing.md),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.sm),
              itemCount: deletedItems.length,
              separatorBuilder: (context, index) => const Divider(color: Color(0xFF1B2940), height: OwnKeepSpacing.lg),
              itemBuilder: (context, index) {
                final item = deletedItems[index];
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
                          colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
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
                      Text(
                        item['date']!,
                        style: TextStyle(
                          color: colors.dangerRed,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          border: Border(top: BorderSide(color: colors.borderSoft)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(OwnKeepMainIcons.trash, colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn)),
                  label: Text(
                    l10n.s23_empty_trash,
                    style: TextStyle(
                      color: colors.dangerRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: OwnKeepSpacing.md),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(OwnKeepMainIcons.restore, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                  label: Text(
                    l10n.s23_restore_all,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class PrintSaveAsScreen extends StatefulWidget {
  const PrintSaveAsScreen({super.key});

  @override
  State<PrintSaveAsScreen> createState() => _PrintSaveAsScreenState();
}

class _PrintSaveAsScreenState extends State<PrintSaveAsScreen> {
  String _selectedOutput = 'print';

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
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              l10n.s59_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s59_subtitle,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Info
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
                      OwnKeepMainIcons.file_pdf,
                      colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
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
                          l10n.s59_file,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              l10n.s59_file_meta,
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                '•',
                                style: TextStyle(color: colors.textMuted, fontSize: 13),
                              ),
                            ),
                            Text(
                              l10n.s59_location,
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
            
            Text(
              l10n.s59_output,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildOptionItem(
                    colors,
                    id: 'print',
                    icon: OwnKeepMainIcons.print,
                    title: l10n.s59_print,
                    subtitle: l10n.s59_print_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildOptionItem(
                    colors,
                    id: 'save_pdf',
                    icon: OwnKeepMainIcons.save_pdf,
                    title: l10n.s59_save_pdf,
                    subtitle: l10n.s59_save_pdf_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildOptionItem(
                    colors,
                    id: 'save_files',
                    icon: OwnKeepMainIcons.save_files,
                    title: l10n.s59_save_files,
                    subtitle: l10n.s59_save_files_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildOptionItem(
                    colors,
                    id: 'export_images',
                    icon: OwnKeepMainIcons.export_images,
                    title: l10n.s59_export_images,
                    subtitle: l10n.s59_export_images_body,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
            
            Text(
              l10n.s59_page_range,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s59_all_pages,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        l10n.s59_page_value,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: OwnKeepSpacing.xs),
                      SvgPicture.asset(
                        OwnKeepMainIcons.chevron_right,
                        colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
            
            Text(
              l10n.s59_privacy,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceDanger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.dangerRed.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.info, // Assuming info or warning icon exists
                    colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: OwnKeepSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.s59_privacy_body,
                      style: TextStyle(
                        color: colors.dangerRed,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
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
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            l10n.common_continue,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(OwnKeepMainColorsTheme colors, {required String id, required String icon, required String title, required String subtitle}) {
    final isSelected = _selectedOutput == id;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedOutput = id;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? colors.primaryBlue.withOpacity(0.1) : colors.backgroundTop,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(isSelected ? colors.primaryBlue : colors.textSecondary, BlendMode.srcIn),
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
                  const SizedBox(height: 2),
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
  }
}

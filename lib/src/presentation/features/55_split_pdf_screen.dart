import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class SplitPdfScreen extends StatefulWidget {
  const SplitPdfScreen({super.key});

  @override
  State<SplitPdfScreen> createState() => _SplitPdfScreenState();
}

class _SplitPdfScreenState extends State<SplitPdfScreen> {
  final List<bool> _selectedPages = [false, true, true, false];
  String _selectedOption = 'extract'; // 'extract', 'separate', 'remove'
  bool _isSplitting = false;

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
              l10n.s55_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s55_subtitle,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.backgroundTop,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.file_pdf,
                      colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: OwnKeepSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.s55_file,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          l10n.s55_file_meta,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
            
            Text(
              l10n.s55_select_pages,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            
            // Grid of Pages
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: OwnKeepSpacing.md,
                mainAxisSpacing: OwnKeepSpacing.md,
                childAspectRatio: 0.8,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final isSelected = _selectedPages[index];
                
                String pageLabel = '';
                if (index == 0) pageLabel = l10n.s55_page_1;
                else if (index == 1) pageLabel = l10n.s55_page_2;
                else if (index == 2) pageLabel = l10n.s55_page_3;
                else if (index == 3) pageLabel = l10n.s55_page_4;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPages[index] = !_selectedPages[index];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? colors.primaryBlue : colors.borderSoft,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Page representation (could use the illustration here if provided)
                        Padding(
                          padding: const EdgeInsets.all(OwnKeepSpacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  color: colors.backgroundTop,
                                  child: Center(
                                    child: Text(
                                      l10n.s55_page_label,
                                      style: TextStyle(
                                        color: colors.textMuted,
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                pageLabel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? colors.primaryBlue : colors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Checkbox
                        if (isSelected)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: SvgPicture.asset(
                              OwnKeepMainIcons.page_selected,
                              colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                              width: 24,
                              height: 24,
                            ),
                          )
                        else
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.borderSoft, width: 1.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: OwnKeepSpacing.xl),
            
            Text(
              l10n.s55_split_options,
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
                    'extract', 
                    l10n.s55_extract, 
                    l10n.s55_extract_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildOptionItem(
                    colors, 
                    'separate', 
                    l10n.s55_separate, 
                    l10n.s55_separate_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildOptionItem(
                    colors, 
                    'remove', 
                    l10n.s55_remove, 
                    l10n.s55_remove_body,
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
          onPressed: _isSplitting ? null : () async {
            setState(() {
              _isSplitting = true;
            });
            await Future.delayed(const Duration(seconds: 2));
            if (!mounted) return;
            setState(() {
              _isSplitting = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('PDF split successfully')),
            );
            Navigator.pop(context);
          },
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
          child: _isSplitting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                l10n.s55_action,
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

  Widget _buildOptionItem(OwnKeepMainColorsTheme colors, String value, String title, String subtitle) {
    final isSelected = _selectedOption == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              isSelected ? OwnKeepMainIcons.radio_selected : OwnKeepMainIcons.radio_unselected,
              colorFilter: ColorFilter.mode(isSelected ? colors.primaryBlue : colors.borderSoft, BlendMode.srcIn),
              width: 24,
              height: 24,
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
          ],
        ),
      ),
    );
  }
}

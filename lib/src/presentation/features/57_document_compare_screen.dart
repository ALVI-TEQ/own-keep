import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class DocumentCompareScreen extends StatelessWidget {
  const DocumentCompareScreen({super.key});

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
              l10n.s57_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s57_subtitle,
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
            // Preview Image
            Center(
              child: Container(
                height: 160,
                width: 240,
                margin: const EdgeInsets.only(bottom: OwnKeepSpacing.xl),
                child: SvgPicture.asset(
                  'assets/main/illustrations/document_compare_versions.svg',
                  fit: BoxFit.contain,
                  placeholderBuilder: (context) => Container(color: colors.surfacePrimary),
                ),
              ),
            ),

            Text(
              l10n.s57_changes,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            
            // Changes List
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildChangeItem(
                    colors,
                    icon: OwnKeepMainIcons.change_orange,
                    iconColor: colors.warningOrange,
                    title: l10n.s57_premium_change,
                    subtitle: l10n.s57_premium_change_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildChangeItem(
                    colors,
                    icon: OwnKeepMainIcons.change_blue,
                    iconColor: colors.primaryBlue,
                    title: l10n.s57_period_change,
                    subtitle: l10n.s57_period_change_body,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildChangeItem(
                    colors,
                    icon: OwnKeepMainIcons.tip_check,
                    iconColor: colors.successGreen,
                    title: l10n.s57_no_other,
                    subtitle: l10n.s57_no_other_body,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: OwnKeepSpacing.xl),
            
            // Detailed Comparison Table
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.sm),
                    decoration: BoxDecoration(
                      color: colors.backgroundTop,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                      border: Border(bottom: BorderSide(color: colors.borderSoft)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Container()), // Empty space for labels
                        Expanded(
                          flex: 3,
                          child: Text(
                            l10n.s57_version_a,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            l10n.s57_version_b,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Table Rows
                  _buildTableRow(
                    colors,
                    label: l10n.s57_policy_number_label,
                    valueA: l10n.s57_policy_number,
                    valueB: l10n.s57_policy_number,
                    isChanged: false,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildTableRow(
                    colors,
                    label: l10n.s57_policy_holder_label,
                    valueA: l10n.s57_policy_holder,
                    valueB: l10n.s57_policy_holder,
                    isChanged: false,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildTableRow(
                    colors,
                    label: l10n.s57_premium_label,
                    valueA: l10n.s57_premium_a,
                    valueB: l10n.s57_premium_b,
                    isChanged: true,
                    highlightColor: colors.warningOrange,
                  ),
                  Divider(color: colors.borderSoft, height: 1),
                  _buildTableRow(
                    colors,
                    label: l10n.s57_period_label,
                    valueA: l10n.s57_period_a,
                    valueB: l10n.s57_period_b,
                    isChanged: true,
                    highlightColor: colors.primaryBlue,
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
            l10n.s57_export,
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

  Widget _buildChangeItem(OwnKeepMainColorsTheme colors, {required String icon, required Color iconColor, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(OwnKeepSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 20,
              height: 20,
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
                const SizedBox(height: 4),
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
    );
  }

  Widget _buildTableRow(OwnKeepMainColorsTheme colors, {required String label, required String valueA, required String valueB, required bool isChanged, Color? highlightColor}) {
    return Padding(
      padding: const EdgeInsets.all(OwnKeepSpacing.md),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              valueA,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 13,
                fontFamily: 'Inter',
                decoration: isChanged ? TextDecoration.lineThrough : null,
                decorationColor: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: isChanged ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2) : EdgeInsets.zero,
              decoration: isChanged 
                ? BoxDecoration(
                    color: (highlightColor ?? colors.primaryBlue).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ) 
                : null,
              child: Text(
                valueB,
                style: TextStyle(
                  color: isChanged ? (highlightColor ?? colors.primaryBlue) : colors.textPrimary,
                  fontSize: 13,
                  fontWeight: isChanged ? FontWeight.w600 : FontWeight.normal,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class DataCheckScreen extends StatefulWidget {
  const DataCheckScreen({super.key});

  @override
  State<DataCheckScreen> createState() => _DataCheckScreenState();
}

class _DataCheckScreenState extends State<DataCheckScreen> {
  bool _isChecking = false;

  void _runCheck() async {
    setState(() => _isChecking = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isChecking = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn), width: 24, height: 24),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              l10n.s47_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s47_subtitle,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: _isChecking 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : SvgPicture.asset(OwnKeepMainIcons.refresh, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 24, height: 24),
            onPressed: _isChecking ? null : _runCheck,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/main/illustrations/data_check_success.svg', // Assumed illustration path
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: OwnKeepSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isChecking)
                        const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      else
                        SvgPicture.asset(OwnKeepMainIcons.check_badge, colorFilter: ColorFilter.mode(colors.successGreen, BlendMode.srcIn), width: 24, height: 24),
                      const SizedBox(width: 8),
                      Text(
                        _isChecking ? 'Checking Data...' : l10n.s47_status,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.s47_last_checked,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Metrics Grid
            Row(
              children: [
                Expanded(child: _buildMetric(colors, l10n.s47_items_value, l10n.s47_items_label)),
                Container(width: 1, height: 40, color: colors.borderSoft),
                Expanded(child: _buildMetric(colors, l10n.s47_corrupt_value, l10n.s47_corrupt_label, color: colors.dangerRed, valueColor: colors.textPrimary)), // 0 is okay, but if >0 it would be red. Assuming normal style for 0
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Divider(color: colors.borderSoft),
            const SizedBox(height: OwnKeepSpacing.md),
            Row(
              children: [
                Expanded(child: _buildMetric(colors, l10n.s47_missing_value, l10n.s47_missing_label, color: colors.dangerRed, valueColor: colors.textPrimary)), // Same logic
                Container(width: 1, height: 40, color: colors.borderSoft),
                Expanded(child: _buildMetric(colors, l10n.s47_integrity_value, l10n.s47_integrity_label, valueColor: colors.successGreen)),
              ],
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Checks Performed List
            Text(
              l10n.s47_checks,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildCheckItem(colors, OwnKeepMainIcons.file_integrity, l10n.s47_file_integrity, l10n.s47_file_integrity_body, const Color(0xFF27C5E8)),
                  _buildDivider(colors),
                  _buildCheckItem(colors, OwnKeepMainIcons.encrypted_manifest, l10n.s47_manifests, l10n.s47_manifests_body, colors.aiPurple),
                  _buildDivider(colors),
                  _buildCheckItem(colors, OwnKeepMainIcons.document_index, l10n.s47_document_index, l10n.s47_document_index_body, colors.primaryBlue),
                  _buildDivider(colors),
                  _buildCheckItem(colors, OwnKeepMainIcons.recovery_metadata, l10n.s47_recovery_metadata, l10n.s47_recovery_metadata_body, colors.warningOrange),
                  _buildDivider(colors),
                  _buildCheckItem(colors, OwnKeepMainIcons.storage_consistency, l10n.s47_storage_consistency, l10n.s47_storage_consistency_body, colors.successGreen),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Run Again Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isChecking ? null : _runCheck,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primaryBlue,
                  side: BorderSide(color: colors.primaryBlue),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.s47_run_again,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(OwnKeepMainColorsTheme colors, String value, String label, {Color? color, Color? valueColor}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? colors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color ?? colors.textSecondary,
            fontSize: 13,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(
    OwnKeepMainColorsTheme colors, 
    String icon, 
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.surfaceSelected,
              borderRadius: BorderRadius.circular(12),
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
                    fontWeight: FontWeight.w600,
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
          SvgPicture.asset(
            OwnKeepMainIcons.success_check, // Assume we have a success check icon for these passed checks
            colorFilter: ColorFilter.mode(colors.successGreen, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(
      color: colors.borderSoft,
      height: 1,
      indent: 64, // Align with text start
    );
  }
}

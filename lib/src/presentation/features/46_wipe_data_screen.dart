import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class WipeDataScreen extends ConsumerStatefulWidget {
  const WipeDataScreen({super.key});

  @override
  ConsumerState<WipeDataScreen> createState() => _WipeDataScreenState();
}

class _WipeDataScreenState extends ConsumerState<WipeDataScreen> {
  bool _backupChecked = false;
  bool _recoveryChecked = false;
  bool _deviceChecked = false;
  String _confirmText = '';

  bool get _canDelete =>
      _backupChecked &&
      _recoveryChecked &&
      _deviceChecked &&
      _confirmText == 'DELETE';

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
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.s46_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: OwnKeepSpacing.lg,
          vertical: OwnKeepSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Box
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.dangerRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.dangerRed.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.danger_exclamation,
                    colorFilter: ColorFilter.mode(
                      colors.dangerRed,
                      BlendMode.srcIn,
                    ),
                    width: 48,
                  ),
                  const SizedBox(height: OwnKeepSpacing.md),
                  Text(
                    l10n.s46_warning_title,
                    style: TextStyle(
                      color: colors.dangerRed,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.s46_warning_body,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Checkboxes
            Text(
              l10n.s46_before,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            _buildCheckbox(
              colors,
              l10n.s46_backup_check,
              _backupChecked,
              (val) => setState(() => _backupChecked = val),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCheckbox(
              colors,
              l10n.s46_recovery_check,
              _recoveryChecked,
              (val) => setState(() => _recoveryChecked = val),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildCheckbox(
              colors,
              l10n.s46_device_check,
              _deviceChecked,
              (val) => setState(() => _deviceChecked = val),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Confirmation Input
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _confirmText = val;
                  });
                },
                style: TextStyle(
                  color: colors.dangerRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: l10n.s46_confirm_hint,
                  hintStyle: TextStyle(
                    color: colors.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                  ),
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canDelete
                    ? () async {
                        await ref
                            .read(vaultSessionProvider.notifier)
                            .destroyVault();
                        if (context.mounted) {
                          context.go('/splash');
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.dangerRed,
                  disabledBackgroundColor: colors.dangerRed.withValues(
                    alpha: 0.3,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.s46_delete,
                  style: TextStyle(
                    color: _canDelete
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  l10n.common_cancel,
                  style: TextStyle(
                    color: colors.textPrimary,
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

  Widget _buildCheckbox(
    OwnKeepMainColorsTheme colors,
    String label,
    bool isChecked,
    ValueChanged<bool> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2, right: 12),
            decoration: BoxDecoration(
              color: isChecked ? colors.dangerRed : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked ? colors.dangerRed : colors.textMuted,
                width: 2,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 15,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

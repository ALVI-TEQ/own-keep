import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../providers/document_provider.dart';

class OcrScanTextScreen extends ConsumerWidget {
  const OcrScanTextScreen({super.key, required this.documentId});

  final String? documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final document = documentId == null
        ? null
        : ref.watch(documentDetailProvider(documentId!)).value;
    final extractedText =
        document?.textPages
            .map((page) => page.text.trim())
            .where((text) => text.isNotEmpty)
            .join('\n\n') ??
        '';

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
              l10n.s56_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s56_subtitle,
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
                height: 200,
                width: 150,
                margin: const EdgeInsets.only(bottom: OwnKeepSpacing.xl),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: SvgPicture.asset(
                  'assets/main/illustrations/ocr_insurance_policy.svg',
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) =>
                      Container(color: colors.surfacePrimary),
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            Text(
              l10n.s56_extracted,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),

            // Extracted Text Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document?.summary.logicalFilename ??
                        l10n.s56_document_title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.md),
                  Text(
                    extractedText.isEmpty
                        ? 'No OCR text is available.'
                        : extractedText,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.md),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  OwnKeepMainIcons.tip_check,
                  colorFilter: ColorFilter.mode(
                    colors.successGreen,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    l10n.s56_local_notice,
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
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
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: extractedText.isEmpty
                    ? null
                    : () async {
                        await Clipboard.setData(
                          ClipboardData(text: extractedText),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Text copied to clipboard'),
                          ),
                        );
                      },
                icon: SvgPicture.asset(
                  OwnKeepMainIcons.copy_text,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  l10n.s56_copy,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: extractedText.isEmpty
                    ? null
                    : () => context.push('/features/add-notes'),
                icon: SvgPicture.asset(
                  OwnKeepMainIcons.save_note,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  l10n.s56_save_note,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentCyan, // or brand color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

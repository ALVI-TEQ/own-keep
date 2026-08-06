import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';
import '../../providers/document_provider.dart';

class FileDetailsScreen extends ConsumerWidget {
  final String? documentId;
  const FileDetailsScreen({super.key, this.documentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final documentAsyncValue = documentId != null 
        ? ref.watch(documentDetailProvider(documentId!))
        : null;

    final _document = documentAsyncValue?.value;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              _document?.summary.logicalFilename ?? l10n.s48_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              _document?.summary.mimeType ?? l10n.s48_subtitle,
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
            icon: SvgPicture.asset(OwnKeepMainIcons.more_vertical, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: documentAsyncValue?.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Preview Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                // Try to load illustration or use placeholder
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SvgPicture.asset(
                      'assets/main/illustrations/passport_file_preview.svg',
                      fit: BoxFit.cover,
                    ),
                    // Adding gradient overlay if needed or just trusting the SVG
                  ],
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // General Section
            Text(
              l10n.s48_general,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildDetailRow(colors, l10n.s48_file_name_label, _document?.summary.logicalFilename ?? l10n.s48_file_name),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_type_label, _document?.summary.mimeType ?? l10n.s48_type),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_size_label, _document != null ? '${_document.summary.byteLength} bytes' : l10n.s48_size),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_added_label, _document?.summary.importedAt.toString() ?? l10n.s48_added),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_modified_label, l10n.s48_modified),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_location_label, l10n.s48_location),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Security Section
            Text(
              l10n.s48_security,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Column(
                children: [
                  _buildDetailRow(colors, l10n.s48_encryption_label, l10n.s48_encryption),
                  _buildDivider(colors),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.s48_integrity_label,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 15,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(OwnKeepMainIcons.verified_shield, colorFilter: ColorFilter.mode(colors.successGreen, BlendMode.srcIn), width: 16),
                            const SizedBox(width: 6),
                            Text(
                              l10n.s48_integrity,
                              style: TextStyle(
                                color: colors.successGreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildDivider(colors),
                  _buildDetailRow(colors, l10n.s48_local_id_label, l10n.s48_local_id),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            // Open Document Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(OwnKeepMainIcons.file_pdf, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), width: 20),
                label: Text(
                  l10n.s48_open,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

  Widget _buildDetailRow(OwnKeepMainColorsTheme colors, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 15,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(
      color: colors.borderSoft,
      height: 1,
    );
  }
}

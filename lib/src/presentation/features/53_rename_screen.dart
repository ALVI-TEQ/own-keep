import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class RenameScreen extends ConsumerStatefulWidget {
  const RenameScreen({super.key, required this.documentId});

  final String? documentId;

  @override
  ConsumerState<RenameScreen> createState() => _RenameScreenState();
}

class _RenameScreenState extends ConsumerState<RenameScreen> {
  late TextEditingController _nameController;
  String _extension = '';
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final document = widget.documentId == null
        ? null
        : ref.watch(documentDetailProvider(widget.documentId!)).value;
    if (!_initialized && document != null) {
      final filename = document.summary.logicalFilename;
      final dot = filename.lastIndexOf('.');
      _extension = dot > 0 ? filename.substring(dot) : '';
      _nameController.text = dot > 0 ? filename.substring(0, dot) : filename;
      _initialized = true;
    }

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
              l10n.s53_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s53_subtitle,
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
                height: 180,
                width: 140,
                margin: const EdgeInsets.only(bottom: OwnKeepSpacing.xl),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                // The illustration could be in assets/main/illustrations
                child: SvgPicture.asset(
                  'assets/main/illustrations/pdf_name_preview.svg',
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) =>
                      Container(color: colors.surfacePrimary),
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            Text(
              l10n.s53_file_name,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xs),

            // Text Field
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      _extension,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  if (_nameController.text.isNotEmpty)
                    IconButton(
                      icon: SvgPicture.asset(
                        OwnKeepMainIcons.close,
                        colorFilter: ColorFilter.mode(
                          colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _nameController.clear();
                        });
                      },
                    ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            Text(
              l10n.s53_location,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xs),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Text(
                l10n.s53_location_value,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            Text(
              l10n.s53_tips,
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
              child: Column(
                children: [
                  _buildTipItem(colors, l10n.s53_tip_clear),
                  _buildTipItem(colors, l10n.s53_tip_year),
                  _buildTipItem(colors, l10n.s53_tip_special),
                  _buildTipItem(colors, l10n.s53_tip_extension, isLast: true),
                ],
              ),
            ),

            const SizedBox(height: 100), // spacing for bottom bar
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
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colors.borderSoft),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: ElevatedButton(
                onPressed:
                    document == null || _nameController.text.trim().isEmpty
                    ? null
                    : () async {
                        await ref
                            .read(ingestionControllerProvider)
                            ?.renameDocument(
                              document.summary.id,
                              '${_nameController.text.trim()}$_extension',
                            );
                        ref.invalidate(
                          documentDetailProvider(document.summary.id),
                        );
                        ref.invalidate(allDocumentsProvider);
                        if (context.mounted) Navigator.pop(context);
                      },
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
                  l10n.s53_save,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(
    OwnKeepMainColorsTheme colors,
    String text, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : OwnKeepSpacing.md),
      child: Row(
        children: [
          SvgPicture.asset(
            OwnKeepMainIcons.tip_check,
            colorFilter: ColorFilter.mode(colors.successGreen, BlendMode.srcIn),
            width: 20,
            height: 20,
          ),
          const SizedBox(width: OwnKeepSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

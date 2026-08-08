import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_ingestion/vault_ingestion.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class AddNotesScreen extends ConsumerStatefulWidget {
  const AddNotesScreen({super.key});

  @override
  ConsumerState<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends ConsumerState<AddNotesScreen> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  bool _reminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _noteController = TextEditingController()..addListener(_refreshCounter);
  }

  @override
  void dispose() {
    _noteController.removeListener(_refreshCounter);
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _refreshCounter() => setState(() {});

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
              l10n.s58_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s58_subtitle,
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
            Text(
              l10n.s58_title_label,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xs),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: TextField(
                controller: _titleController,
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

            const SizedBox(height: OwnKeepSpacing.xl),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.s58_note_label,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '${_noteController.text.length}/2000',
                  style: TextStyle(
                    color: colors.textMuted,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: OwnKeepSpacing.xs),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: TextField(
                controller: _noteController,
                maxLines: null,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            Text(
              l10n.s58_attach,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xs),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons
                        .tip_check, // The reference uses a generic check or file icon here? s58_attach suggests attach icon or file icon.
                    colorFilter: ColorFilter.mode(
                      colors.primaryBlue,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.s58_attach_value,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 15,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xl),

            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.s58_reminder,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.s58_reminder_body,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _reminderEnabled,
                    onChanged: (value) {
                      setState(() {
                        _reminderEnabled = value;
                      });
                    },
                    activeThumbColor: colors.primaryBlue,
                    inactiveTrackColor: colors.borderSoft,
                    inactiveThumbColor: colors.textMuted,
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
          onPressed: _noteController.text.trim().isEmpty ? null : _saveNote,
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
            l10n.s58_save,
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

  Future<void> _saveNote() async {
    final body = _noteController.text.trim();
    final bytes = utf8.encode(body);
    final rawTitle = _titleController.text.trim();
    final safeTitle =
        (rawTitle.isEmpty
                ? 'Note-${DateTime.now().millisecondsSinceEpoch}'
                : rawTitle)
            .replaceAll(RegExp(r'[^A-Za-z0-9 _-]'), '')
            .trim();
    await ref
        .read(ingestionControllerProvider)
        ?.importCandidate(
          IngestionCandidate(
            logicalFilename: '${safeTitle.isEmpty ? 'Note' : safeTitle}.txt',
            mimeType: 'text/plain',
            length: bytes.length,
            source: DocumentImportSource.filePicker,
            openRead: () => Stream<List<int>>.value(bytes),
          ),
        );
    ref.invalidate(allDocumentsProvider);
    if (mounted) Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_domain/vault_domain.dart';
import '../../providers/vault_provider.dart';
import '../../providers/document_provider.dart';
import '../../citizen_vault/library/document_export_confirmation.dart';
import '../../citizen_vault/library/full_document_screen.dart';
import '../../citizen_vault/library/pdf_document_tools.dart';

class DocumentPreviewScreen extends ConsumerStatefulWidget {
  final String? documentId;
  const DocumentPreviewScreen({super.key, this.documentId});

  @override
  ConsumerState<DocumentPreviewScreen> createState() =>
      _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends ConsumerState<DocumentPreviewScreen> {
  Uint8List? _previewBytes;
  bool _isLoading = true;
  int _pageCount = 1;

  Future<void> _toggleFavorite() async {
    final id = widget.documentId;
    if (id == null) return;
    final detail = await ref.read(documentDetailProvider(id).future);
    final controller = ref.read(ingestionControllerProvider);
    if (detail == null || controller == null) return;
    await controller.setFavourite(id, !detail.summary.isFavourite);
    ref.invalidate(documentDetailProvider(id));
    ref.invalidate(favoriteDocumentsProvider);
    ref.invalidate(allDocumentsProvider);
  }

  Future<void> _exportDocument() async {
    final id = widget.documentId;
    if (id == null) return;
    final detail = await ref.read(documentDetailProvider(id).future);
    final controller = ref.read(ingestionControllerProvider);
    if (detail == null || controller == null) return;
    if (!mounted || !await confirmDocumentExport(context)) return;
    final message = await controller.exportDocument(detail);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _openOriginal() async {
    final id = widget.documentId;
    if (id == null) return;
    final detail = await ref.read(documentDetailProvider(id).future);
    final controller = ref.read(ingestionControllerProvider);
    if (!mounted || detail == null || controller == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            FullDocumentScreen(controller: controller, detail: detail),
      ),
    );
  }

  Future<void> _moveToTrash() async {
    final id = widget.documentId;
    final controller = ref.read(ingestionControllerProvider);
    if (id == null || controller == null) return;
    await controller.moveDocumentsToTrash(<String>[id]);
    ref.invalidate(allDocumentsProvider);
    ref.invalidate(recentDocumentsProvider);
    ref.invalidate(trashDocumentsProvider);
    if (mounted) context.pop();
  }

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    if (widget.documentId == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    try {
      final controller = ref.read(ingestionControllerProvider);
      if (controller != null) {
        final bytes = await controller.documentPreview(widget.documentId!);
        final detail = await ref.read(
          documentDetailProvider(widget.documentId!).future,
        );
        var pageCount = 1;
        if (detail?.summary.mimeType.toLowerCase() == 'application/pdf') {
          pageCount = await const PdfDocumentTools().pageCount(
            controller: controller,
            document: detail!,
          );
        }
        if (mounted) {
          setState(() {
            _previewBytes = bytes;
            _pageCount = pageCount;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final detail = widget.documentId == null
        ? null
        : ref.watch(documentDetailProvider(widget.documentId!)).value;

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
          l10n.s26_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              detail?.summary.isFavourite == true
                  ? OwnKeepMainIcons.favorite
                  : OwnKeepMainIcons.favorite_outline,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.more_vertical,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: _showMoreActions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Preview Image / Illustration
            Container(
              color: colors.backgroundBottom,
              width: double.infinity,
              height: 340,
              child: Stack(
                children: [
                  Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : _previewBytes != null
                        ? Image.memory(
                            _previewBytes!,
                            fit: BoxFit.contain,
                            height: 340,
                          )
                        : SvgPicture.asset(
                            'assets/main/illustrations/passport_preview_placeholder.svg',
                            fit: BoxFit.contain,
                            height: 300,
                          ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Page 1 of $_pageCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.file_pdf,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Metadata Section
            if (widget.documentId != null)
              ref
                  .watch(documentDetailProvider(widget.documentId!))
                  .when(
                    loading: () => const Padding(
                      padding: EdgeInsets.all(OwnKeepSpacing.lg),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, st) => const Padding(
                      padding: EdgeInsets.all(OwnKeepSpacing.lg),
                      child: Text('Failed to load details'),
                    ),
                    data: (doc) {
                      if (doc == null) return const SizedBox.shrink();

                      return Padding(
                        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.summary.logicalFilename.isNotEmpty
                                  ? doc.summary.logicalFilename
                                  : 'Untitled',
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              doc.summary.documentType.displayName,
                              style: TextStyle(
                                color: colors.primaryBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: OwnKeepSpacing.xl),

                            // Info rows
                            _buildInfoRow(
                              colors,
                              'Added: ${doc.summary.importedAt.toString().split('.')[0]}',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              colors,
                              'Size: ${_formatBytes(doc.summary.byteSize)}',
                            ),
                            const SizedBox(height: OwnKeepSpacing.xl),

                            // Tags
                            if (doc.summary.tags.isNotEmpty) ...[
                              Text(
                                l10n.s26_tags,
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: doc.summary.tags
                                    .map(
                                      (tag) => _buildTag(
                                        colors,
                                        tag.name,
                                        const Color(0xFF27C5E8),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: OwnKeepSpacing.xl),
                              const Divider(color: Color(0xFF1B2940)),
                              const SizedBox(height: OwnKeepSpacing.xl),
                            ],

                            if (doc.fields.isNotEmpty) ...[
                              _buildExtractedFields(colors, doc),
                              const SizedBox(height: OwnKeepSpacing.lg),
                            ],
                            if (doc.textPages.any(
                              (page) => page.text.trim().isNotEmpty,
                            ))
                              _buildExtractedTextSummary(colors, doc),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          border: Border(top: BorderSide(color: colors.borderSoft)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomAction(
                colors,
                OwnKeepMainIcons.share,
                l10n.s26_share,
                () {
                  final id = widget.documentId;
                  if (id != null) context.push('/features/share-export?id=$id');
                },
              ),
              _buildBottomAction(
                colors,
                OwnKeepMainIcons.download,
                l10n.s26_download,
                _exportDocument,
              ),
              _buildBottomAction(
                colors,
                OwnKeepMainIcons.more_vertical,
                l10n.s26_more,
                _showMoreActions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(OwnKeepMainColorsTheme colors, String text) {
    return Text(
      text,
      style: TextStyle(
        color: colors.textSecondary,
        fontSize: 14,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildExtractedFields(
    OwnKeepMainColorsTheme colors,
    DocumentDetailView document,
  ) {
    final fields = document.fields
        .where((field) => field.effectiveValue.trim().isNotEmpty)
        .toList();
    if (fields.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: colors.primaryBlue, size: 20),
            const SizedBox(width: 8),
            Text(
              'Extracted information',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.surfacePrimary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.borderSoft),
          ),
          child: Column(
            children: [
              for (var index = 0; index < fields.length; index++) ...[
                if (index > 0)
                  Divider(height: 1, color: colors.borderSoft, indent: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          fields[index].type.displayName,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: SelectableText(
                          fields[index].effectiveValue,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExtractedTextSummary(
    OwnKeepMainColorsTheme colors,
    DocumentDetailView document,
  ) {
    final pages = document.textPages
        .where((page) => page.text.trim().isNotEmpty)
        .toList();
    final text = pages.map((page) => page.text.trim()).join('\n\n');
    final preview = _cleanTextPreview(text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Extracted text',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surfacePrimary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.borderSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: colors.primaryBlue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.text_snippet_outlined,
                      color: colors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${pages.length} ${pages.length == 1 ? 'page' : 'pages'} recognized',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${text.length} characters • searchable locally',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                preview,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: text));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Extracted text copied.'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.copy_outlined, size: 18),
                      label: const Text('Copy'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        final id = widget.documentId;
                        if (id != null) {
                          context.push('/features/ocr-scan-text?id=$id');
                        }
                      },
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Open text'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _cleanTextPreview(String text) {
    final cleaned = text
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .join(' • ');
    if (cleaned.length <= 280) return cleaned;
    return '${cleaned.substring(0, 280).trimRight()}…';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Widget _buildTag(
    OwnKeepMainColorsTheme colors,
    String label,
    Color tagColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tagColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tagColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tagColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildBottomAction(
    OwnKeepMainColorsTheme colors,
    String icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreActions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: const Text('View original file'),
              onTap: () {
                Navigator.pop(sheetContext);
                _openOriginal();
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet_outlined),
              title: const Text('View extracted text'),
              onTap: () {
                Navigator.pop(sheetContext);
                final id = widget.documentId;
                if (id != null) {
                  context.push('/features/ocr-scan-text?id=$id');
                }
              },
            ),
            if (ref
                    .read(documentDetailProvider(widget.documentId ?? ''))
                    .value
                    ?.summary
                    .mimeType
                    .toLowerCase() ==
                'application/pdf') ...[
              ListTile(
                leading: const Icon(Icons.merge_type),
                title: const Text('Merge PDFs'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.push('/features/merge-pdf');
                },
              ),
              ListTile(
                leading: const Icon(Icons.call_split),
                title: const Text('Split PDF'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.push('/features/split-pdf');
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.label_outline),
              title: const Text('Manage tags'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.push('/features/tag-manager');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Document processing history'),
              onTap: () {
                Navigator.pop(sheetContext);
                final id = widget.documentId;
                if (id != null) {
                  context.push('/features/version-history?id=$id');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Move to recently deleted'),
              onTap: () {
                Navigator.pop(sheetContext);
                _moveToTrash();
              },
            ),
          ],
        ),
      ),
    );
  }
}

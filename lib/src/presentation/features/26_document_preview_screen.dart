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
import 'dart:typed_data';

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
    final message = await controller.exportDocument(detail);
    if (mounted)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
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
        if (mounted)
          setState(() {
            _previewBytes = bytes;
            _isLoading = false;
          });
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
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        l10n.s26_page,
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
                        color: Colors.black.withOpacity(0.6),
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
                            _buildInfoRow(colors, 'Size: Unknown KB'),
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

                            // Notes
                            if (doc.textPages.isNotEmpty &&
                                doc.textPages.first.text.isNotEmpty)
                              Text(
                                doc.textPages.first.text,
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  height: 1.5,
                                ),
                              ),
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

  Widget _buildTag(
    OwnKeepMainColorsTheme colors,
    String label,
    Color tagColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tagColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tagColor.withOpacity(0.3)),
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
              leading: const Icon(Icons.label_outline),
              title: const Text('Manage tags'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.push('/features/tag-manager');
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

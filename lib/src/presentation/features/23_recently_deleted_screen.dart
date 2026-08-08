import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../dashboard/dashboard_document_presentation.dart';

class RecentlyDeletedScreen extends ConsumerStatefulWidget {
  const RecentlyDeletedScreen({super.key});

  @override
  ConsumerState<RecentlyDeletedScreen> createState() =>
      _RecentlyDeletedScreenState();
}

class _RecentlyDeletedScreenState extends ConsumerState<RecentlyDeletedScreen> {
  final Set<String> _selected = <String>{};

  Future<void> _restore(Iterable<String> ids) async {
    final values = ids.toList(growable: false);
    if (values.isEmpty) return;
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    await controller.restoreDocumentsFromTrash(values);
    _selected.clear();
    ref.invalidate(trashDocumentsProvider);
    ref.invalidate(allDocumentsProvider);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final trashDocsAsync = ref.watch(trashDocumentsProvider);

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
          l10n.s23_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              final documents =
                  ref.read(trashDocumentsProvider).value ?? const [];
              setState(() {
                if (_selected.length == documents.length) {
                  _selected.clear();
                } else {
                  _selected
                    ..clear()
                    ..addAll(documents.map((document) => document.id));
                }
              });
            },
            child: Text(
              l10n.s23_select,
              style: TextStyle(
                color: colors.primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: const EdgeInsets.all(OwnKeepSpacing.lg),
            padding: const EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceSelected.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSoft),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  OwnKeepMainIcons.info,
                  colorFilter: ColorFilter.mode(
                    colors.primaryBlue,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: OwnKeepSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.s23_trash_notice,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.s23_trash_notice_body,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Header stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trashDocsAsync.maybeWhen(
                    data: (items) => '${items.length} items',
                    orElse: () => l10n.s23_item_count,
                  ),
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                Row(
                  children: [
                    Text(
                      l10n.s23_sort,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      OwnKeepMainIcons.sort,
                      colorFilter: ColorFilter.mode(
                        colors.textSecondary,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: OwnKeepSpacing.md),

          // List
          Expanded(
            child: trashDocsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Failed to load trash',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
              data: (deletedItems) {
                if (deletedItems.isEmpty) {
                  return Center(
                    child: Text(
                      'No recently deleted items',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: OwnKeepSpacing.lg,
                    vertical: OwnKeepSpacing.sm,
                  ),
                  itemCount: deletedItems.length,
                  itemBuilder: (context, index) {
                    final item = deletedItems[index];
                    return _buildDeletedItem(
                      context,
                      colors,
                      item.id,
                      dashboardDocumentIcon(item),
                      item.logicalFilename.isNotEmpty
                          ? item.logicalFilename
                          : 'Untitled',
                      'Deleted recently',
                      item.importedAt.toString().split(' ')[0],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          border: Border(top: BorderSide(color: colors.borderSoft)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final documents =
                        ref.read(trashDocumentsProvider).value ?? const [];
                    _restore(
                      _selected.isEmpty
                          ? documents.map((d) => d.id)
                          : _selected,
                    );
                  },
                  icon: SvgPicture.asset(
                    OwnKeepMainIcons.restore,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  ),
                  label: Text(
                    _selected.isEmpty
                        ? l10n.s23_restore_all
                        : 'Restore selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeletedItem(
    BuildContext context,
    OwnKeepMainColorsTheme colors,
    String documentId,
    String iconPath,
    String title,
    String subtitle,
    String dateStr,
  ) {
    final selected = _selected.contains(documentId);
    return InkWell(
      onTap: () => setState(() {
        selected ? _selected.remove(documentId) : _selected.add(documentId);
      }),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
        padding: const EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.backgroundTop,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  colors.textSecondary,
                  BlendMode.srcIn,
                ),
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
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.dangerRed,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Text(
              dateStr,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? colors.primaryBlue : colors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

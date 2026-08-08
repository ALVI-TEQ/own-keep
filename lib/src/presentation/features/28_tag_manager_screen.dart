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
import 'package:vault_domain/vault_domain.dart';

class TagManagerScreen extends ConsumerStatefulWidget {
  const TagManagerScreen({super.key});

  @override
  ConsumerState<TagManagerScreen> createState() => _TagManagerScreenState();
}

class _TagManagerScreenState extends ConsumerState<TagManagerScreen> {
  String _query = '';

  Future<void> _createTag() async {
    final input = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create tag'),
        content: TextField(
          controller: input,
          autofocus: true,
          maxLength: 40,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Tag name',
            hintText: 'Example: Tax documents',
          ),
          onSubmitted: (value) => Navigator.of(dialogContext).pop(value.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(input.text.trim()),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    input.dispose();
    if (name == null || name.isEmpty || !mounted) return;
    try {
      await ref.read(ingestionControllerProvider)?.createTag(name);
      ref.invalidate(customTagsProvider);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Tag “$name” created.')));
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('That tag could not be created.')),
        );
      }
    }
  }

  Future<void> _renameTag(DocumentTagView tag) async {
    final input = TextEditingController(text: tag.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename tag'),
        content: TextField(controller: input, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, input.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    input.dispose();
    if (name == null || name.isEmpty || name == tag.name) return;
    await ref.read(ingestionControllerProvider)?.renameTag(tag.id, name);
    ref.invalidate(customTagsProvider);
    ref.invalidate(allDocumentsProvider);
  }

  Future<void> _deleteTag(DocumentTagView tag) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete tag?'),
        content: Text('Remove “${tag.name}” from all documents?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(ingestionControllerProvider)?.deleteTag(tag.id);
    ref.invalidate(customTagsProvider);
    ref.invalidate(allDocumentsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final customTagsAsync = ref.watch(customTagsProvider);
    final documents = ref.watch(allDocumentsProvider).value ?? const [];
    int countTypes(Set<String> types) => documents
        .where((document) => types.contains(document.documentType.storageValue))
        .length;

    final smartTags = [
      {
        'icon': OwnKeepMainIcons.identity,
        'title': l10n.s28_identity,
        'count':
            '${countTypes(const {'AADHAAR', 'PAN', 'PASSPORT', 'DRIVING_LICENCE', 'VOTER_ID'})}',
        'route': '/collections/identity',
      },
      {
        'icon': OwnKeepMainIcons.finance,
        'title': l10n.s28_finance,
        'count':
            '${countTypes(const {'BANK_STATEMENT', 'RECEIPT', 'INVOICE'})}',
        'route': '/collections/finance',
      },
      {
        'icon': OwnKeepMainIcons.insurance,
        'title': l10n.s28_insurance,
        'count': '${countTypes(const {'INSURANCE_POLICY'})}',
        'route': '/collections/insurance',
      },
      {
        'icon': OwnKeepMainIcons.health,
        'title': l10n.s28_health,
        'count': '${countTypes(const {'MEDICAL_REPORT', 'PRESCRIPTION'})}',
        'route': '/collections/health',
      },
      {
        'icon': OwnKeepMainIcons.property,
        'title': l10n.s28_property,
        'count':
            '${countTypes(const {'ELECTRICITY_BILL', 'WATER_BILL', 'GAS_BILL', 'PROPERTY_TAX'})}',
        'route': '/collections/property',
      },
      {
        'icon': OwnKeepMainIcons.vehicle,
        'title': l10n.s28_vehicle,
        'count': '${countTypes(const {'VEHICLE_DOCUMENT'})}',
        'route': '/collections/vehicle',
      },
      {
        'icon': OwnKeepMainIcons.work,
        'title': l10n.s28_work,
        'count': '${countTypes(const {'GENERAL_DOCUMENT', 'INVOICE'})}',
        'route': '/collections/work',
      },
      {
        'icon': OwnKeepMainIcons.important,
        'title': l10n.s28_important,
        'count':
            '${documents.where((document) => document.isFavourite).length}',
        'route': '/dashboard/favorites',
      },
    ];

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
          l10n.s28_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.add,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: _createTag,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: (value) =>
                  setState(() => _query = value.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: l10n.s28_search,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfacePrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: colors.borderSoft),
                ),
              ),
            ),
            /*Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    OwnKeepMainIcons.search,
                    colorFilter: ColorFilter.mode(
                      colors.textSecondary,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.s28_search,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Smart Tags Section
            _buildSectionHeader(
              l10n.s28_smart_tags,
              l10n.s28_smart_count,
              colors,
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            ...smartTags.map(
              (tag) => Padding(
                padding: const EdgeInsets.only(bottom: OwnKeepSpacing.sm),
                child: _buildTagRow(
                  colors,
                  tag['icon']!,
                  tag['title']!,
                  tag['count']!,
                  onTap: () => context.push(tag['route']!),
                ),
              ),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Custom Tags Section
            _buildSectionHeader(
              l10n.s28_custom_tags,
              l10n.s28_custom_count,
              colors,
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            customTagsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => const Text('Error loading tags'),
              data: (tags) {
                final filtered = tags
                    .where((tag) => tag.name.toLowerCase().contains(_query))
                    .toList();
                if (filtered.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(OwnKeepSpacing.md),
                    child: Text(
                      'No custom tags yet.',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  );
                }
                return Column(
                  children: filtered
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: OwnKeepSpacing.sm,
                          ),
                          child: _buildTagRow(
                            colors,
                            OwnKeepMainIcons.tag,
                            tag.name,
                            '${documents.where((doc) => doc.tags.any((value) => value.id == tag.id)).length}',
                            onTap: () => context.push('/dashboard/search'),
                            onMenu: () => _showTagMenu(tag),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String count,
    OwnKeepMainColorsTheme colors,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colors.surfaceSelected,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagRow(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String count, {
    VoidCallback? onTap,
    VoidCallback? onMenu,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                colors.primaryBlue,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onMenu,
              icon: SvgPicture.asset(
                OwnKeepMainIcons.more_vertical,
                colorFilter: ColorFilter.mode(
                  colors.textSecondary,
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagMenu(DocumentTagView tag) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                _renameTag(tag);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _deleteTag(tag);
              },
            ),
          ],
        ),
      ),
    );
  }
}

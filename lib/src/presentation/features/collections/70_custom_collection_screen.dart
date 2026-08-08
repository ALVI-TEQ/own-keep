import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/ownkeep_main_colors.dart';
import '../../../theme/ownkeep_main_icons.dart';
import '../../../providers/document_provider.dart';
import '../../dashboard/dashboard_document_presentation.dart';

class CustomCollectionScreen extends ConsumerStatefulWidget {
  const CustomCollectionScreen({super.key});

  @override
  ConsumerState<CustomCollectionScreen> createState() =>
      _CustomCollectionScreenState();
}

class CustomCollectionDetailScreen extends ConsumerWidget {
  const CustomCollectionDetailScreen({super.key, required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final collections = ref.watch(customCollectionsProvider);
    final documents = ref.watch(allDocumentsProvider);
    return collections.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('$error'))),
      data: (items) {
        final matches = items.where((item) => item.id == collectionId);
        if (matches.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Collection not found.')),
          );
        }
        final collection = matches.single;
        final accent = Color(collection.colorValue);
        return Scaffold(
          backgroundColor: colors.backgroundTop,
          appBar: AppBar(
            backgroundColor: colors.backgroundTop,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(collection.name),
            actions: [
              IconButton(
                onPressed: () => context.push(
                  '/features/multi-select?collection=${Uri.encodeQueryComponent(collection.name)}',
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: documents.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('$error')),
            data: (allDocuments) {
              final tagged = allDocuments
                  .where(
                    (document) => document.tags.any(
                      (tag) =>
                          tag.name.toLowerCase() ==
                          collection.name.toLowerCase(),
                    ),
                  )
                  .toList();
              if (tagged.isEmpty) {
                return Center(
                  child: Text(
                    'No documents in this collection.',
                    style: TextStyle(color: colors.textSecondary),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tagged.length,
                itemBuilder: (context, index) {
                  final document = tagged[index];
                  return Card(
                    color: colors.surfacePrimary,
                    child: ListTile(
                      onTap: () => context.push(
                        '/features/document-preview?id=${Uri.encodeQueryComponent(document.id)}',
                      ),
                      leading: SvgPicture.asset(
                        dashboardDocumentIcon(document),
                        width: 24,
                        colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
                      ),
                      title: Text(document.logicalFilename),
                      subtitle: Text(document.mimeType),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _CustomCollectionScreenState
    extends ConsumerState<CustomCollectionScreen> {
  String _collectionName = '';
  String _selectedIcon = OwnKeepMainIcons.custom_heart;
  Color _selectedColor = const Color(0xFF4668FF); // customBlue

  bool _autoTagEnabled = true;
  bool _aiSuggestEnabled = true;
  bool _pinHomeEnabled = false;

  final List<String> _availableIcons = [
    OwnKeepMainIcons.custom_heart,
    OwnKeepMainIcons.custom_home,
    OwnKeepMainIcons.custom_circle,
    OwnKeepMainIcons.custom_diamond,
    OwnKeepMainIcons.custom_square,
    OwnKeepMainIcons.custom_sparkle,
  ];

  final List<Color> _availableColors = [
    const Color(0xFF4668FF), // customBlue
    const Color(0xFF8548FF), // customPurple
    const Color(0xFF28CC91), // customGreen
    const Color(0xFFFFA53A), // customOrange
    const Color(0xFFFF5B67), // customRed
    const Color(0xFFFA4B9A), // customPink
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
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
          l10n.s70_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.confirm,
              colorFilter: ColorFilter.mode(
                colors.primaryBlue,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: _collectionName.trim().isEmpty
                ? null
                : _createCollection,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.s70_subtitle,
              style: TextStyle(color: colors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Live Preview Card
            Text(
              l10n.s70_preview,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      _selectedIcon,
                      colorFilter: ColorFilter.mode(
                        _selectedColor,
                        BlendMode.srcIn,
                      ),
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _collectionName.isEmpty
                              ? l10n.s70_preview_name
                              : _collectionName,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s70_preview_meta,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Collection Name Input
            Text(
              l10n.s70_collection_name,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: l10n.s70_collection_value,
                hintStyle: TextStyle(color: colors.textMuted),
                filled: true,
                fillColor: colors.surfacePrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _collectionName = val),
            ),
            const SizedBox(height: 32),

            // Choose Icon
            Text(
              l10n.s70_choose_icon,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableIcons.map((iconPath) {
                final isSelected = _selectedIcon == iconPath;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = iconPath),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _selectedColor.withValues(alpha: 0.2)
                          : colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? _selectedColor : colors.borderSoft,
                      ),
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        isSelected ? _selectedColor : colors.textSecondary,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Theme Color
            Text(
              l10n.s70_theme_color,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableColors.map((c) {
                final isSelected = _selectedColor == c;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = c),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: colors.textPrimary, width: 3)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Smart Rules
            Text(
              l10n.s70_smart_rules,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildRuleToggle(
              l10n.s70_auto_tag,
              l10n.s70_auto_tag_body,
              _autoTagEnabled,
              (v) => setState(() => _autoTagEnabled = v),
              colors,
            ),
            _buildRuleToggle(
              l10n.s70_suggest,
              l10n.s70_suggest_body,
              _aiSuggestEnabled,
              (v) => setState(() => _aiSuggestEnabled = v),
              colors,
            ),
            _buildRuleToggle(
              l10n.s70_home,
              l10n.s70_home_body,
              _pinHomeEnabled,
              (v) => setState(() => _pinHomeEnabled = v),
              colors,
            ),
            const SizedBox(height: 32),

            // Create Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _collectionName.trim().isEmpty
                    ? null
                    : _createCollection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.s70_create,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    OwnKeepMainColorsTheme colors,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: colors.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colors.primaryBlue,
            inactiveTrackColor: colors.surfacePrimary,
          ),
        ],
      ),
    );
  }

  Future<void> _createCollection() async {
    final library = await ref.read(documentLibraryProvider.future);
    if (library == null) return;
    try {
      await library.createCustomCollection(
        name: _collectionName,
        iconKey: _selectedIcon,
        colorValue: _selectedColor.toARGB32(),
        autoTagEnabled: _autoTagEnabled,
        aiSuggestEnabled: _aiSuggestEnabled,
        pinHomeEnabled: _pinHomeEnabled,
      );
      ref.invalidate(customCollectionsProvider);
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not create collection: $error')),
        );
      }
    }
  }
}

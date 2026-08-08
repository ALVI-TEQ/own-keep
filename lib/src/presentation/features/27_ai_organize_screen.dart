import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiOrganizeScreen extends ConsumerStatefulWidget {
  const AiOrganizeScreen({super.key});

  @override
  ConsumerState<AiOrganizeScreen> createState() => _AiOrganizeScreenState();
}

class _AiOrganizeScreenState extends ConsumerState<AiOrganizeScreen> {
  bool _autoOrganize = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((preferences) {
      if (mounted) {
        setState(
          () => _autoOrganize = preferences.getBool('ai_auto_organize') ?? true,
        );
      }
    });
  }

  Future<void> _setAutoOrganize(bool value) async {
    setState(() => _autoOrganize = value);
    await (await SharedPreferences.getInstance()).setBool(
      'ai_auto_organize',
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final documents = ref.watch(allDocumentsProvider).value ?? const [];
    final uncategorized = documents
        .where((doc) => doc.documentType.storageValue == 'UNKNOWN')
        .length;
    final missingTags = documents.where((doc) => doc.tags.isEmpty).length;
    final filenames = <String, int>{};
    for (final document in documents) {
      filenames.update(
        document.logicalFilename.toLowerCase(),
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    final duplicates = filenames.values
        .where((count) => count > 1)
        .fold<int>(0, (sum, count) => sum + count);

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
          l10n.s27_title,
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
              OwnKeepMainIcons.history,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/ai-history'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Scan Complete Card
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.aiPurple, colors.primaryBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.check_circle,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.md),
                  Text(
                    l10n.s27_scan_complete,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.s27_scan_complete_body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),
                  ElevatedButton(
                    onPressed: () => context.push('/dashboard/all-files'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colors.aiPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      l10n.s27_review,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Suggestions Title
            Text(
              l10n.s27_suggestions,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Suggestions List
            _buildSuggestionCard(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.folder,
              iconColor: const Color(0xFF27C5E8), // accentCyan
              title: l10n.s27_uncategorized,
              subtitle: l10n.s27_uncategorized_body,
              countLabel: '$uncategorized',
              onTap: () => context.push('/dashboard/all-files'),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildSuggestionCard(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.duplicate,
              iconColor: colors.warningOrange,
              title: l10n.s27_duplicates,
              subtitle: l10n.s27_duplicates_body,
              countLabel: '$duplicates',
              onTap: () => context.push('/features/duplicate-finder'),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildSuggestionCard(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.tag,
              iconColor: const Color(0xFFE54B86), // tagPink
              title: l10n.s27_missing_tags,
              subtitle: l10n.s27_missing_tags_body,
              countLabel: '$missingTags',
              onTap: () => context.push('/features/tag-manager'),
            ),
            const SizedBox(height: OwnKeepSpacing.sm),
            _buildSuggestionCard(
              context: context,
              colors: colors,
              icon: OwnKeepMainIcons.similar_documents,
              iconColor: colors.successGreen,
              title: l10n.s27_similar,
              subtitle: l10n.s27_similar_body,
              countLabel: '${documents.length}',
              onTap: () => context.push('/features/similar-documents'),
            ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Auto Organization Toggle
            Container(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.s27_auto,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s27_auto_body,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(value: _autoOrganize, onChanged: _setAutoOrganize),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String countLabel,
    required VoidCallback onTap,
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceSelected,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfaceSelected,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          countLabel,
                          style: TextStyle(
                            color: colors.primaryBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              OwnKeepMainIcons.arrow_right,
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class MoveOrCopyScreen extends ConsumerStatefulWidget {
  const MoveOrCopyScreen({super.key, required this.documentId});

  final String? documentId;

  @override
  ConsumerState<MoveOrCopyScreen> createState() => _MoveOrCopyScreenState();
}

class _MoveOrCopyScreenState extends ConsumerState<MoveOrCopyScreen> {
  bool _keepOriginal = false;
  String _selectedCategory = 'Personal';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;
    final document = widget.documentId == null
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
        title: Column(
          children: [
            Text(
              l10n.s50_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s50_subtitle,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: OwnKeepSpacing.lg,
                vertical: OwnKeepSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selected Item
                  Text(
                    l10n.s50_selected,
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors.surfaceSelected,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset(
                            OwnKeepMainIcons.file_pdf,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF27C5E8),
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
                                document?.summary.logicalFilename ??
                                    l10n.s50_file_name,
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.s50_file_size,
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: OwnKeepSpacing.xl),

                  // Destination
                  Text(
                    l10n.s50_destination,
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
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.personal_category,
                          l10n.s50_personal,
                          l10n.s50_personal_count,
                          const Color(0xFF27C5E8),
                        ),
                        _buildDivider(colors),
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.finance_category,
                          l10n.s50_finance,
                          l10n.s50_finance_count,
                          colors.successGreen,
                        ),
                        _buildDivider(colors),
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.health_category,
                          l10n.s50_health,
                          l10n.s50_health_count,
                          colors.warningOrange,
                        ),
                        _buildDivider(colors),
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.property_category,
                          l10n.s50_property,
                          l10n.s50_property_count,
                          colors.aiPurple,
                        ),
                        _buildDivider(colors),
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.vehicle,
                          l10n.s50_vehicle,
                          l10n.s50_vehicle_count,
                          colors.primaryBlue,
                        ),
                        _buildDivider(colors),
                        _buildCategoryItem(
                          colors,
                          OwnKeepMainIcons.education,
                          l10n.s50_education,
                          l10n.s50_education_count,
                          colors.aiPurple,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: OwnKeepSpacing.md),

                  // New Folder
                  InkWell(
                    onTap: () => context.push('/features/tag-manager'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.borderSoft),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              OwnKeepMainIcons.new_folder,
                              colorFilter: ColorFilter.mode(
                                colors.primaryBlue,
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
                                  l10n.s50_new_folder,
                                  style: TextStyle(
                                    color: colors.primaryBlue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.s50_new_folder_body,
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            OwnKeepMainIcons.chevron_right,
                            colorFilter: ColorFilter.mode(
                              colors.textMuted,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(OwnKeepSpacing.lg),
            decoration: BoxDecoration(
              color: colors.backgroundTop,
              border: Border(top: BorderSide(color: colors.borderSoft)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        l10n.s50_keep_original,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _keepOriginal = !_keepOriginal;
                        });
                      },
                      child: SvgPicture.asset(
                        _keepOriginal
                            ? OwnKeepOnboardingIcons.toggle_on
                            : OwnKeepOnboardingIcons.toggle_off,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          _keepOriginal ? colors.primaryBlue : colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 44,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: OwnKeepSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: document == null
                        ? null
                        : () async {
                            final existing = document.summary.tags
                                .map((tag) => tag.name)
                                .toList();
                            final tags = _keepOriginal
                                ? <String>{
                                    ...existing,
                                    _selectedCategory,
                                  }.toList()
                                : <String>[_selectedCategory];
                            await ref
                                .read(ingestionControllerProvider)
                                ?.replaceTags(document.summary.id, tags);
                            ref.invalidate(
                              documentDetailProvider(document.summary.id),
                            );
                            ref.invalidate(allDocumentsProvider);
                            if (context.mounted) context.pop();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _keepOriginal ? l10n.common_copy : l10n.common_move,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: OwnKeepSpacing.sm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    OwnKeepMainColorsTheme colors,
    String icon,
    String title,
    String count,
    Color iconColor,
  ) {
    final isSelected = _selectedCategory == title;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
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
                  Text(
                    count,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: colors.primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(OwnKeepMainColorsTheme colors) {
    return Divider(color: colors.borderSoft, height: 1, indent: 64);
  }
}

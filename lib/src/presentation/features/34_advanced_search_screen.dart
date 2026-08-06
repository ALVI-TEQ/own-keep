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

class AdvancedSearchScreen extends ConsumerStatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  ConsumerState<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends ConsumerState<AdvancedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedFilter = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final filters = [
      l10n.s34_filter_all,
      l10n.s34_filter_documents,
      l10n.s34_filter_images,
      l10n.s34_filter_others,
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colors.borderSoft),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(OwnKeepMainIcons.search, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 15,
                                fontFamily: 'Inter',
                              ),
                              decoration: InputDecoration(
                                hintText: l10n.s34_query,
                                hintStyle: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () => _searchController.clear(),
                              child: SvgPicture.asset(OwnKeepMainIcons.close, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.borderSoft),
                    ),
                    child: SvgPicture.asset(OwnKeepMainIcons.filter, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
                  ),
                ],
              ),
            ),
            
            // Filter Chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: 4),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: OwnKeepSpacing.sm),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? colors.surfaceSelected : colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? colors.primaryBlue : colors.borderSoft,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            color: isSelected ? colors.primaryBlue : colors.textSecondary,
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Results List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(OwnKeepSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_searchQuery.isEmpty)
                      Center(
                        child: Text(
                          'Type to search...',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      )
                    else
                      ref.watch(searchDocumentsProvider(_searchQuery)).when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, st) => const Center(child: Text('Error searching documents')),
                        data: (results) {
                          if (results.isEmpty) {
                            return Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(color: colors.textSecondary),
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${results.length} results',
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: OwnKeepSpacing.sm),
                              ...results.map((doc) => _buildResultItem(
                                colors: colors,
                                icon: OwnKeepMainIcons.file_pdf,
                                iconColor: colors.primaryBlue,
                                title: doc.logicalFilename.isNotEmpty ? doc.logicalFilename : 'Untitled',
                                meta: doc.importedAt.toString().split(' ')[0],
                              )),
                            ],
                          );
                        },
                      ),

                    const SizedBox(height: OwnKeepSpacing.xl),

                    const SizedBox(height: OwnKeepSpacing.xxl),

                    // AI Search Prompt
                    Container(
                      padding: const EdgeInsets.all(OwnKeepSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.aiPurple.withOpacity(0.1),
                            colors.primaryBlue.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.aiPurple.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            l10n.s34_not_found,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s34_try_ai,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 13,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: OwnKeepSpacing.md),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: SvgPicture.asset(OwnKeepOnboardingIcons.ai_powered, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                              label: Text(
                                l10n.s34_ai_button,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.aiPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: OwnKeepSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem({
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String meta,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSoft),
              ),
              child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
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
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meta,
                    style: TextStyle(
                      color: colors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

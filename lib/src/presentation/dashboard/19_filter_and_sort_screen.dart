import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';

class FilterAndSortScreen extends ConsumerStatefulWidget {
  const FilterAndSortScreen({super.key});

  @override
  ConsumerState<FilterAndSortScreen> createState() =>
      _FilterAndSortScreenState();
}

class _FilterAndSortScreenState extends ConsumerState<FilterAndSortScreen> {
  late DashboardDocumentFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = ref.read(dashboardDocumentFilterProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.surfacePrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.borderSoft),
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.backArrow,
                          colorFilter: ColorFilter.mode(
                            colors.textPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.s19_title,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s19_subtitle,
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

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    // File Type
                    Text(
                      l10n.s19_file_type,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      children: [
                        _buildKindChip(
                          l10n.filter_all_files,
                          DashboardFileKind.all,
                        ),
                        _buildKindChip(
                          l10n.filter_documents,
                          DashboardFileKind.documents,
                        ),
                        _buildKindChip(
                          l10n.filter_images,
                          DashboardFileKind.images,
                        ),
                        _buildKindChip(
                          l10n.filter_videos,
                          DashboardFileKind.videos,
                        ),
                        _buildKindChip(
                          l10n.filter_others,
                          DashboardFileKind.other,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Date Added
                    Text(
                      l10n.s19_date_added,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      children: [
                        _buildDateChip(
                          l10n.filter_any_time,
                          DashboardDateRange.anyTime,
                        ),
                        _buildDateChip(
                          l10n.filter_today,
                          DashboardDateRange.today,
                        ),
                        _buildDateChip(
                          l10n.filter_this_week,
                          DashboardDateRange.thisWeek,
                        ),
                        _buildDateChip(
                          l10n.filter_this_month,
                          DashboardDateRange.thisMonth,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Sort By
                    Text(
                      l10n.s19_sort_by,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        _buildSortOption(
                          l10n.sort_newest,
                          DashboardDocumentSort.newest,
                        ),
                        _buildSortOption(
                          l10n.sort_oldest,
                          DashboardDocumentSort.oldest,
                        ),
                        _buildSortOption(
                          l10n.sort_name_az,
                          DashboardDocumentSort.nameAscending,
                        ),
                        _buildSortOption(
                          l10n.sort_name_za,
                          DashboardDocumentSort.nameDescending,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Actions
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: colors.backgroundBottom,
                  border: Border(top: BorderSide(color: colors.borderSoft)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(
                          () => _filter = const DashboardDocumentFilter(),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: colors.surfacePrimary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: colors.borderSoft),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            l10n.s19_reset,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(dashboardDocumentFilterProvider.notifier)
                              .update(_filter);
                          context.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: OwnKeepMainGradients.primaryAction,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            l10n.s19_apply,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKindChip(String label, DashboardFileKind kind) =>
      _buildFilterChip(label, _filter.kind == kind, () {
        setState(() => _filter = _filter.copyWith(kind: kind));
      });

  Widget _buildDateChip(String label, DashboardDateRange range) =>
      _buildFilterChip(label, _filter.dateRange == range, () {
        setState(() => _filter = _filter.copyWith(dateRange: range));
      });

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, DashboardDocumentSort sort) {
    final colors = context.mainColors;
    final isSelected = _filter.sort == sort;
    return GestureDetector(
      onTap: () => setState(() => _filter = _filter.copyWith(sort: sort)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: colors.textPrimary, fontSize: 16),
            ),
            SvgPicture.asset(
              isSelected
                  ? OwnKeepMainIcons.radioSelected
                  : OwnKeepMainIcons.radioUnselected,
              colorFilter: ColorFilter.mode(
                isSelected ? colors.primaryBlue : colors.neutralIcon,
                BlendMode.srcIn,
              ),
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}

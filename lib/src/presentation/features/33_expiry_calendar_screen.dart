import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_provider.dart';
import '../dashboard/dashboard_document_presentation.dart';
import 'package:vault_domain/vault_domain.dart';

class ExpiryCalendarScreen extends ConsumerStatefulWidget {
  const ExpiryCalendarScreen({super.key});

  @override
  ConsumerState<ExpiryCalendarScreen> createState() =>
      _ExpiryCalendarScreenState();
}

class _ExpiryCalendarScreenState extends ConsumerState<ExpiryCalendarScreen> {
  late DateTime _visibleMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
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
          l10n.s33_title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Header
            Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _monthLabel(_visibleMonth),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          OwnKeepMainIcons.chevron_left,
                          colorFilter: ColorFilter.mode(
                            colors.textPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () => setState(
                          () => _visibleMonth = DateTime(
                            _visibleMonth.year,
                            _visibleMonth.month - 1,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          OwnKeepMainIcons.chevron_right,
                          colorFilter: ColorFilter.mode(
                            colors.textPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () => setState(
                          () => _visibleMonth = DateTime(
                            _visibleMonth.year,
                            _visibleMonth.month + 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Weekday Headers
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: OwnKeepSpacing.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildWeekdayLabel(colors, l10n.weekday_sun),
                  _buildWeekdayLabel(colors, l10n.weekday_mon),
                  _buildWeekdayLabel(colors, l10n.weekday_tue),
                  _buildWeekdayLabel(colors, l10n.weekday_wed),
                  _buildWeekdayLabel(colors, l10n.weekday_thu),
                  _buildWeekdayLabel(colors, l10n.weekday_fri),
                  _buildWeekdayLabel(colors, l10n.weekday_sat),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            ref
                .watch(allDocumentsProvider)
                .maybeWhen(
                  data: (documents) => _buildCalendarGrid(colors, documents),
                  orElse: () => const SizedBox(height: 48),
                ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Upcoming Expiries Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: OwnKeepSpacing.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s33_this_month,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    l10n.common_view_all,
                    style: TextStyle(
                      color: colors.primaryBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),

            // Expiry List
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: OwnKeepSpacing.lg,
              ),
              child: ref
                  .watch(allDocumentsProvider)
                  .when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, st) =>
                        const Center(child: Text('Error loading documents')),
                    data: (docs) {
                      final expiring =
                          docs.where((doc) {
                            final expiry = doc.expiryAt;
                            return expiry != null &&
                                expiry.year == _visibleMonth.year &&
                                expiry.month == _visibleMonth.month;
                          }).toList()..sort(
                            (a, b) => a.expiryAt!.compareTo(b.expiryAt!),
                          );
                      if (expiring.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(OwnKeepSpacing.md),
                          child: Text(
                            'No expiring documents found.',
                            style: TextStyle(color: colors.textSecondary),
                          ),
                        );
                      }
                      return Column(
                        children: expiring
                            .map(
                              (doc) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: OwnKeepSpacing.sm,
                                ),
                                child: _buildExpiryCard(
                                  context: context,
                                  colors: colors,
                                  icon: dashboardDocumentIcon(doc),
                                  iconColor: colors.primaryBlue,
                                  title: doc.logicalFilename.isNotEmpty
                                      ? doc.logicalFilename
                                      : 'Document',
                                  subtitle:
                                      'Expires ${_formatDate(doc.expiryAt!)}',
                                  date: _relativeExpiry(doc.expiryAt!),
                                  isCritical:
                                      doc.expiryAt!
                                          .difference(DateTime.now())
                                          .inDays <=
                                      7,
                                  onTap: () => context.push(
                                    '/features/document-preview?id=${Uri.encodeQueryComponent(doc.id)}',
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
            ),
            const SizedBox(height: 100), // padding for floating action button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/features/health-reminders'),
        backgroundColor: colors.primaryBlue,
        child: SvgPicture.asset(
          OwnKeepMainIcons.add,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Widget _buildWeekdayLabel(OwnKeepMainColorsTheme colors, String label) {
    return SizedBox(
      width: 40,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildDayCell(
    OwnKeepMainColorsTheme colors,
    String day,
    bool hasEvent,
    bool isSelected,
  ) {
    return Container(
      width: 40,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : colors.textPrimary,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
          if (hasEvent) ...[
            const SizedBox(height: 4),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : colors.dangerRed,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpiryCard({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String date,
    required bool isCritical,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCritical
                ? colors.dangerRed.withOpacity(0.5)
                : colors.borderSoft,
          ),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.calendar,
                        colorFilter: ColorFilter.mode(
                          isCritical ? colors.dangerRed : colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                          color: isCritical
                              ? colors.dangerRed
                              : colors.textMuted,
                          fontSize: 12,
                          fontWeight: isCritical
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              OwnKeepMainIcons.more_vertical,
              colorFilter: ColorFilter.mode(
                colors.textSecondary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  String _monthLabel(DateTime date) =>
      '${const <String>['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][date.month - 1]} ${date.year}';

  Widget _buildCalendarGrid(
    OwnKeepMainColorsTheme colors,
    List<DocumentListItemView> documents,
  ) {
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month);
    final dayCount = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    final leadingCells = firstDay.weekday % 7;
    final eventDays = documents
        .map((document) => document.expiryAt)
        .whereType<DateTime>()
        .where(
          (date) =>
              date.year == _visibleMonth.year &&
              date.month == _visibleMonth.month,
        )
        .map((date) => date.day)
        .toSet();
    final today = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: .84,
        ),
        itemCount: leadingCells + dayCount,
        itemBuilder: (context, index) {
          if (index < leadingCells) return const SizedBox.shrink();
          final day = index - leadingCells + 1;
          return Center(
            child: _buildDayCell(
              colors,
              '$day',
              eventDays.contains(day),
              today.year == _visibleMonth.year &&
                  today.month == _visibleMonth.month &&
                  today.day == day,
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _relativeExpiry(DateTime date) {
    final now = DateTime.now();
    final days = DateTime(
      date.year,
      date.month,
      date.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (days < 0) return 'Expired ${-days} days ago';
    if (days == 0) return 'Expires today';
    return '$days days left';
  }
}

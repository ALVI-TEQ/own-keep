import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../providers/document_provider.dart';
import '20_navigation_menu.dart';
import 'dashboard_document_presentation.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  ConsumerState<HomeDashboardScreen> createState() =>
      _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleScan(BuildContext context) async {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    try {
      await controller.captureImage();
      ref.invalidate(recentDocumentsProvider);
      ref.invalidate(allDocumentsProvider);
      if (context.mounted && controller.notice != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(controller.notice!)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Camera error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    // Ensure the vault is unlocked before displaying the dashboard
    final vault = ref.watch(unlockedVaultProvider);
    final controller = ref.watch(ingestionControllerProvider);
    final allDocuments = ref.watch(allDocumentsProvider).value ?? const [];
    final storage = ref.watch(vaultStorageSummaryProvider).value;
    final personName = ref.watch(primaryPersonProvider).value?.displayName;

    if (vault == null || controller == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/splash');
      });
      return Scaffold(backgroundColor: colors.backgroundTop);
    }
    int countTypes(Set<String> types) => allDocuments
        .where((document) => types.contains(document.documentType.storageValue))
        .length;
    final identityCount = countTypes(const {
      'AADHAAR',
      'PAN',
      'PASSPORT',
      'DRIVING_LICENCE',
      'VOTER_ID',
    });
    final financeCount = countTypes(const {
      'BANK_STATEMENT',
      'RECEIPT',
      'INVOICE',
    });
    final healthCount = countTypes(const {'MEDICAL_REPORT', 'PRESCRIPTION'});
    final propertyCount = countTypes(const {
      'ELECTRICITY_BILL',
      'WATER_BILL',
      'GAS_BILL',
      'PROPERTY_TAX',
    });
    final activeReminders =
        controller.reminders
            .where(
              (reminder) => reminder.isEnabled && reminder.completedAt == null,
            )
            .toList()
          ..sort((a, b) => a.dueAt.compareTo(b.dueAt));

    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavigationMenuDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting(l10n, personName),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s11_subtitle,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.profile,
                      colorFilter: ColorFilter.mode(
                        colors.neutralIcon,
                        BlendMode.srcIn,
                      ),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Search
              GestureDetector(
                onTap: () => context.push('/dashboard/search'),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.searchBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.borderSoft),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.search,
                        colorFilter: ColorFilter.mode(
                          colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.s11_search_hint,
                        style: TextStyle(color: colors.textMuted, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionTile(
                    l10n.s11_action_scan,
                    OwnKeepMainIcons.scan,
                    colors.accentCyan,
                    () => _handleScan(context),
                  ),
                  _buildActionTile(
                    l10n.s11_action_add_new,
                    OwnKeepMainIcons.add,
                    colors.successGreen,
                    () => context.push('/features/add-item-menu'),
                  ),
                  _buildActionTile(
                    l10n.s11_action_ai_assistant,
                    OwnKeepMainIcons.aiAssistant,
                    colors.aiPurple,
                    () => context.push('/features/ai-organize'),
                  ),
                  _buildActionTile(
                    l10n.s11_action_quick_note,
                    OwnKeepMainIcons.note,
                    colors.warningOrange,
                    () => context.push('/features/add-notes'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Recent Items Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.s11_recent_items,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/dashboard/recent'),
                    child: Text(
                      l10n.common_view_all,
                      style: TextStyle(color: colors.primaryBlue, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Recent Items List
              SizedBox(
                height: 110,
                child: ref
                    .watch(recentDocumentsProvider)
                    .when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Text(
                          l10n.s11_documents_load_error,
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      ),
                      data: (docs) {
                        if (docs.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.s11_no_recent_files,
                              style: TextStyle(color: colors.textSecondary),
                            ),
                          );
                        }
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: docs.take(3).map((doc) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: _buildRecentCard(
                                doc.logicalFilename.isNotEmpty
                                    ? doc.logicalFilename
                                    : l10n.common_untitled,
                                doc.documentType.displayName.isEmpty
                                    ? l10n.common_unknown
                                    : doc.documentType.displayName,
                                dashboardDocumentIcon(doc),
                                colors.primaryBlue,
                                () => context.push(
                                  '/features/document-preview?id=${doc.id}',
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
              ),
              const SizedBox(height: 32),

              // Smart Collections Header
              Text(
                l10n.s11_smart_collections,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Smart Collections Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  _buildCollectionCard(
                    l10n.collection_personal,
                    l10n.common_item_count(identityCount),
                    OwnKeepMainIcons.profile,
                    colors.primaryBlue,
                    () => context.push('/collections/identity'),
                  ),
                  _buildCollectionCard(
                    l10n.collection_finance,
                    l10n.common_item_count(financeCount),
                    OwnKeepMainIcons.finance,
                    colors.successGreen,
                    () => context.push('/collections/finance'),
                  ),
                  _buildCollectionCard(
                    l10n.collection_health,
                    l10n.common_item_count(healthCount),
                    OwnKeepMainIcons.health,
                    colors.dangerRed,
                    () => context.push('/collections/health'),
                  ),
                  _buildCollectionCard(
                    l10n.collection_property,
                    l10n.common_item_count(propertyCount),
                    OwnKeepMainIcons.property,
                    colors.warningOrange,
                    () => context.push('/collections/property'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Today's Reminder
              Text(
                l10n.s11_today_reminder,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.push('/features/health-reminders'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surfacePrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.borderSoft),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.primaryBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.reminder,
                          colorFilter: ColorFilter.mode(
                            colors.primaryBlue,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          activeReminders.isEmpty
                              ? l10n.s11_no_upcoming_reminders
                              : activeReminders.first.title,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        OwnKeepMainIcons.chevronRight,
                        colorFilter: ColorFilter.mode(
                          colors.textMuted,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Storage Overview
              Text(
                l10n.s11_storage_overview,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.push('/features/storage-overview'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surfacePrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.borderSoft),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            storage == null
                                ? 'Calculating encrypted storage…'
                                : '${_formatBytes(storage.totalBytes)} • ${storage.fileCount} files',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${allDocuments.length} documents',
                            style: TextStyle(
                              color: colors.primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: storage == null
                              ? 0
                              : (storage.totalBytes / (1024 * 1024 * 1024))
                                    .clamp(0, 1),
                          backgroundColor: colors.surfaceSelected,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colors.primaryBlue,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String _greeting(AppLocalizations l10n, String? personName) {
    final name = personName?.trim();
    if (name == null || name.isEmpty) return l10n.greeting_welcome;
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greeting_morning(name);
    if (hour < 17) return l10n.greeting_afternoon(name);
    return l10n.greeting_evening(name);
  }

  Widget _buildActionTile(
    String label,
    String iconPath,
    Color color,
    VoidCallback onTap,
  ) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colors.surfacePrimary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.borderSoft),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: colors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Widget _buildRecentCard(
    String title,
    String subtitle,
    String iconPath,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 20,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: colors.textMuted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCard(
    String title,
    String count,
    String iconPath,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    count,
                    style: TextStyle(color: colors.textMuted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

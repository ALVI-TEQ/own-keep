import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../providers/vault_provider.dart';
import '../components/ownkeep_components.dart';
import '../components/ownkeep_dashboard_components.dart';
import '../../theme/app_theme.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ownkeep/src/citizen_vault/ingestion/ingestion_ui_controller.dart';
import '../../providers/document_provider.dart';
import '20_navigation_menu.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  ConsumerState<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleScan(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document scanned successfully!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Camera error: $e')));
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

    if (vault == null || controller == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/splash');
      });
      return Scaffold(backgroundColor: colors.backgroundTop);
    }
    
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
                          l10n.s11_greeting,
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
                      colorFilter: ColorFilter.mode(colors.neutralIcon, BlendMode.srcIn),
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
                        colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
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
                  _buildActionTile(l10n.s11_action_scan, OwnKeepMainIcons.scan, colors.accentCyan, () => _handleScan(context)),
                  _buildActionTile(l10n.s11_action_add_new, OwnKeepMainIcons.add, colors.successGreen, () => context.push('/features/add-item-menu')),
                  _buildActionTile(l10n.s11_action_ai_assistant, OwnKeepMainIcons.aiAssistant, colors.aiPurple, () => context.push('/features/ai-organize')),
                  _buildActionTile(l10n.s11_action_quick_note, OwnKeepMainIcons.note, colors.warningOrange, () => context.push('/features/add-notes')),
                ],
              ),
              const SizedBox(height: 32),
              
              // Recent Items Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.s11_recent_items, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => context.push('/dashboard/recent'),
                    child: Text(l10n.common_view_all, style: TextStyle(color: colors.primaryBlue, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Recent Items List
              SizedBox(
                height: 110,
                child: ref.watch(recentDocumentsProvider).when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error loading documents', style: TextStyle(color: colors.textSecondary))),
                  data: (docs) {
                    if (docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No recent files',
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
                            doc.logicalFilename.isNotEmpty ? doc.logicalFilename : 'Untitled',
                            doc.documentType.toString().split('.').last, // Temporary type mapping
                            OwnKeepMainIcons.file_pdf, // We'll map this properly later
                            colors.primaryBlue,
                            () {},
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              
              // Smart Collections Header
              Text(l10n.s11_smart_collections, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
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
                  _buildCollectionCard(l10n.collection_personal, l10n.s11_personal_count, OwnKeepMainIcons.profile, colors.primaryBlue, () => context.push('/collections/identity')),
                  _buildCollectionCard(l10n.collection_finance, l10n.s11_finance_count, OwnKeepMainIcons.finance, colors.successGreen, () => context.push('/collections/finance')),
                  _buildCollectionCard(l10n.collection_health, l10n.s11_health_count, OwnKeepMainIcons.health, colors.dangerRed, () => context.push('/collections/health')),
                  _buildCollectionCard(l10n.collection_property, l10n.s11_property_count, OwnKeepMainIcons.property, colors.warningOrange, () => context.push('/collections/property')),
                ],
              ),
              const SizedBox(height: 32),
              
              // Today's Reminder
              Text(l10n.s11_today_reminder, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Container(
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
                        colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                        width: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        l10n.s11_reminder_text,
                        style: TextStyle(color: colors.textPrimary, fontSize: 15),
                      ),
                    ),
                    SvgPicture.asset(
                      OwnKeepMainIcons.chevronRight,
                      colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Storage Overview
              Text(l10n.s11_storage_overview, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Container(
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
                        Text(l10n.s11_storage_value, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        Text(l10n.s11_storage_percent, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.24,
                        backgroundColor: colors.surfaceSelected,
                        valueColor: AlwaysStoppedAnimation<Color>(colors.primaryBlue),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(String label, String iconPath, Color color, VoidCallback onTap) {
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

  Widget _buildRecentCard(String title, String subtitle, String iconPath, Color iconColor, VoidCallback onTap) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCard(String title, String count, String iconPath, Color iconColor, VoidCallback onTap) {
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
                    style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
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

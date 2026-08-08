import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/gallery/component_gallery_screen.dart';
import '../presentation/onboarding/01_splash_screen.dart';
import '../presentation/onboarding/02_welcome_screen.dart';
import '../presentation/onboarding/03_features_screen.dart';
import '../presentation/onboarding/04_create_vault_screen.dart';
import '../presentation/onboarding/05_set_pin_screen.dart';
import '../presentation/onboarding/06_confirm_pin_screen.dart';
import '../presentation/onboarding/07_recovery_phrase_screen.dart';
import '../presentation/onboarding/08_verify_phrase_screen.dart';
import '../presentation/onboarding/09_enable_biometrics_screen.dart';
import '../presentation/onboarding/10_setup_complete_screen.dart';

import '../presentation/dashboard/11_home_dashboard_screen.dart';
import '../presentation/dashboard/12_collections_screen.dart';
import '../presentation/dashboard/13_all_files_screen.dart';
import '../presentation/dashboard/14_recent_screen.dart';
import '../presentation/dashboard/15_favorites_screen.dart';
import '../presentation/dashboard/16_categories_screen.dart';
import '../presentation/dashboard/17_search_screen.dart';
import '../presentation/dashboard/18_global_search_screen.dart';
import '../presentation/dashboard/19_filter_and_sort_screen.dart';
import '../presentation/dashboard/20_navigation_menu.dart';

import '../theme/app_theme.dart';
import '../providers/vault_provider.dart';

import '../presentation/features/21_share_export_screen.dart';
import '../presentation/features/22_favorites_list_screen.dart';
import '../presentation/features/23_recently_deleted_screen.dart';
import '../presentation/features/24_storage_overview_screen.dart';
import '../presentation/features/25_add_item_menu_screen.dart';
import '../presentation/features/26_document_preview_screen.dart';
import '../presentation/features/27_ai_organize_screen.dart';
import '../presentation/features/28_tag_manager_screen.dart';
import '../presentation/features/29_vault_info_screen.dart';
import '../presentation/features/30_help_support_screen.dart';
import '../presentation/features/31_recovery_center_screen.dart';
import '../presentation/features/32_health_reminders_screen.dart';
import '../presentation/features/33_expiry_calendar_screen.dart';
import '../presentation/features/34_advanced_search_screen.dart';
import '../presentation/features/35_onboarding_guide_screen.dart';
import '../presentation/features/36_duplicate_finder_screen.dart';
import '../presentation/features/37_statistics_screen.dart';
import '../presentation/features/38_lock_screen.dart';
import '../presentation/features/39_quick_actions_screen.dart';
import '../presentation/features/40_settings_advanced_screen.dart';
import '../presentation/features/41_import_export_screen.dart';
import '../presentation/features/42_data_usage_screen.dart';
import '../presentation/features/43_about_ownkeep_screen.dart';
import '../presentation/features/44_tutorials_screen.dart';
import '../presentation/features/45_rate_ownkeep_screen.dart';
import '../presentation/features/46_wipe_data_screen.dart';
import '../presentation/features/47_data_check_screen.dart';
import '../presentation/features/48_file_details_screen.dart';
import '../presentation/features/49_version_history_screen.dart';
import '../presentation/features/50_move_or_copy_screen.dart';
import '../presentation/features/51_multi_select_screen.dart';
import '../presentation/features/52_move_to_screen.dart';
import '../presentation/features/53_rename_screen.dart';
import '../presentation/features/54_merge_pdf_screen.dart';
import '../presentation/features/55_split_pdf_screen.dart';
import '../presentation/features/56_ocr_scan_text_screen.dart';
import '../presentation/features/57_document_compare_screen.dart';
import '../presentation/features/58_add_notes_screen.dart';
import '../presentation/features/59_print_save_as_screen.dart';
import '../presentation/features/60_scan_securely_screen.dart';

import '../presentation/features/collections/smart_collection_category.dart';
import '../presentation/features/collections/smart_collection_screen.dart';
import '../presentation/features/collections/70_custom_collection_screen.dart';
import '../presentation/features/71_ai_chat_screen.dart';
import '../presentation/features/72_ai_insights_screen.dart';
import '../presentation/features/73_smart_suggestions_screen.dart';
import '../presentation/features/74_similar_documents_screen.dart';
import '../presentation/features/75_duplicate_resolution_screen.dart';
import '../presentation/features/76_ai_timeline_screen.dart';
import '../presentation/features/77_auto_tagging_screen.dart';
import '../presentation/features/78_ai_search_results_screen.dart';
import '../presentation/features/79_ai_settings_screen.dart';
import '../presentation/features/80_ai_history_screen.dart';
import '../presentation/features/81_family_vault_screen.dart';
import '../presentation/features/82_members_screen.dart';
import '../presentation/features/83_invite_members_screen.dart';
import '../presentation/features/84_permissions_screen.dart';
import '../presentation/features/85_trusted_contacts_screen.dart';
import '../presentation/features/86_emergency_access_screen.dart';
import '../presentation/features/87_shared_collections_screen.dart';
import '../presentation/features/88_shared_activity_screen.dart';
import '../presentation/features/89_invitations_screen.dart';
import '../presentation/features/90_access_history_screen.dart';
import '../presentation/features/90_backup_restore_screen.dart';
import '../presentation/features/91_profile_screen.dart';
import '../presentation/features/91_ownkeep_pro_screen.dart';
import '../presentation/features/92_themes_screen.dart';
import '../presentation/features/93_app_lock_screen.dart';
import '../presentation/features/94_hidden_vault_screen.dart';
import '../presentation/features/95_decoy_vault_screen.dart';
import '../presentation/features/96_recovery_verification_screen.dart';
import '../presentation/features/97_encryption_details_screen.dart';
import '../presentation/features/98_device_migration_screen.dart';
import '../presentation/features/99_restore_vault_screen.dart';
import '../presentation/features/100_security_audit_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  const protectedFeaturePaths = <String>{
    '/features/share-export',
    '/features/favorites-list',
    '/features/recently-deleted',
    '/features/storage-overview',
    '/features/add-item-menu',
    '/features/document-preview',
    '/features/ai-organize',
    '/features/tag-manager',
    '/features/vault-info',
    '/features/help-support',
    '/features/recovery-center',
    '/features/health-reminders',
    '/features/expiry-calendar',
    '/features/advanced-search',
    '/features/duplicate-finder',
    '/features/statistics',
    '/features/quick-actions',
    '/features/settings-advanced',
    '/features/import-export',
    '/features/data-usage',
    '/features/wipe-data',
    '/features/data-check',
    '/features/file-details',
    '/features/version-history',
    '/features/move-or-copy',
    '/features/multi-select',
    '/features/move-to',
    '/features/rename',
    '/features/merge-pdf',
    '/features/split-pdf',
    '/features/ocr-scan-text',
    '/features/document-compare',
    '/features/add-notes',
    '/features/print-save-as',
    '/features/scan-securely',
    '/features/ai-chat',
    '/features/ai-insights',
    '/features/smart-suggestions',
    '/features/similar-documents',
    '/features/duplicate-resolution',
    '/features/ai-timeline',
    '/features/auto-tagging',
    '/features/ai-search-results',
    '/features/ai-settings',
    '/features/ai-history',
    '/features/family-sharing',
    '/features/members',
    '/features/invite-members',
    '/features/permissions',
    '/features/trusted-contacts',
    '/features/emergency-access',
    '/features/shared-collections',
    '/features/shared-activity',
    '/features/invitations',
    '/features/access-history',
    '/features/backup-restore',
    '/features/pro',
    '/features/themes',
    '/features/app-lock',
    '/features/hidden-vault',
    '/features/decoy-vault',
    '/features/recovery-verification',
    '/features/encryption-details',
    '/features/device-migration',
    '/features/restore-vault',
    '/features/security-audit',
  };
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      if ((protectedFeaturePaths.contains(state.uri.path) ||
              state.uri.path.startsWith('/collections/')) &&
          ref.read(vaultSessionProvider).value == null) {
        return '/lock';
      }
      return null;
    },
    routes: [
      // Onboarding Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/features',
        builder: (context, state) => const FeaturesScreen(),
      ),
      GoRoute(
        path: '/create-vault',
        builder: (context, state) => const CreateVaultScreen(),
      ),
      GoRoute(
        path: '/set-pin',
        builder: (context, state) => const SetPinScreen(),
      ),
      GoRoute(
        path: '/confirm-pin',
        redirect: (context, state) => state.extra is String ? null : '/set-pin',
        builder: (context, state) {
          final originalPin = state.extra! as String;
          return ConfirmPinScreen(originalPin: originalPin);
        },
      ),
      GoRoute(
        path: '/recovery-phrase',
        redirect: (context, state) =>
            ref.read(onboardingPinProvider) == null ? '/set-pin' : null,
        builder: (context, state) => const RecoveryPhraseScreen(),
      ),
      GoRoute(
        path: '/verify-phrase',
        redirect: (context, state) =>
            ref.read(onboardingRecoveryCodeProvider) == null
            ? '/recovery-phrase'
            : null,
        builder: (context, state) => const VerifyPhraseScreen(),
      ),
      GoRoute(
        path: '/enable-biometrics',
        redirect: (context, state) =>
            ref.read(vaultSessionProvider).value == null
            ? '/verify-phrase'
            : null,
        builder: (context, state) => const EnableBiometricsScreen(),
      ),
      GoRoute(
        path: '/setup-complete',
        redirect: (context, state) =>
            ref.read(vaultSessionProvider).value == null ? '/splash' : null,
        builder: (context, state) => const SetupCompleteScreen(),
      ),
      GoRoute(
        path: '/components',
        builder: (context, state) => const ComponentGalleryScreen(),
      ),

      // Feature Routes (Screens 21-100)
      GoRoute(
        path: '/features/share-export',
        builder: (context, state) =>
            ShareExportScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/favorites-list',
        builder: (context, state) => const FavoritesListScreen(),
      ),
      GoRoute(
        path: '/features/recently-deleted',
        builder: (context, state) => const RecentlyDeletedScreen(),
      ),
      GoRoute(
        path: '/features/storage-overview',
        builder: (context, state) => const StorageOverviewScreen(),
      ),
      GoRoute(
        path: '/features/add-item-menu',
        builder: (context, state) => const AddItemMenuScreen(),
      ),
      GoRoute(
        path: '/features/document-preview',
        redirect: (context, state) => state.uri.queryParameters['id'] == null
            ? '/dashboard/all-files'
            : null,
        builder: (context, state) =>
            DocumentPreviewScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/ai-organize',
        builder: (context, state) => const AiOrganizeScreen(),
      ),
      GoRoute(
        path: '/features/tag-manager',
        builder: (context, state) => const TagManagerScreen(),
      ),
      GoRoute(
        path: '/features/vault-info',
        builder: (context, state) => const VaultInfoScreen(),
      ),
      GoRoute(
        path: '/features/help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/features/recovery-center',
        builder: (context, state) => const RecoveryCenterScreen(),
      ),
      GoRoute(
        path: '/features/health-reminders',
        builder: (context, state) => const HealthRemindersScreen(),
      ),
      GoRoute(
        path: '/features/expiry-calendar',
        builder: (context, state) => const ExpiryCalendarScreen(),
      ),
      GoRoute(
        path: '/features/advanced-search',
        builder: (context, state) => const AdvancedSearchScreen(),
      ),
      GoRoute(
        path: '/features/onboarding-guide',
        builder: (context, state) => const OnboardingGuideScreen(),
      ),
      GoRoute(
        path: '/features/duplicate-finder',
        builder: (context, state) => const DuplicateFinderScreen(),
      ),
      GoRoute(
        path: '/features/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(path: '/lock', builder: (context, state) => const LockScreen()),
      GoRoute(
        path: '/features/quick-actions',
        builder: (context, state) => const QuickActionsScreen(),
      ),
      GoRoute(
        path: '/features/settings-advanced',
        builder: (context, state) => const SettingsAdvancedScreen(),
      ),
      GoRoute(
        path: '/features/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/features/import-export',
        builder: (context, state) => const ImportExportScreen(),
      ),
      GoRoute(
        path: '/features/data-usage',
        builder: (context, state) => const DataUsageScreen(),
      ),
      GoRoute(
        path: '/features/about-ownkeep',
        builder: (context, state) => const AboutOwnKeepScreen(),
      ),
      GoRoute(
        path: '/features/tutorials',
        builder: (context, state) => const TutorialsScreen(),
      ),
      GoRoute(
        path: '/features/rate-ownkeep',
        builder: (context, state) => const RateOwnKeepScreen(),
      ),
      GoRoute(
        path: '/features/wipe-data',
        builder: (context, state) => const WipeDataScreen(),
      ),
      GoRoute(
        path: '/features/data-check',
        builder: (context, state) => const DataCheckScreen(),
      ),
      GoRoute(
        path: '/features/file-details',
        redirect: (context, state) => state.uri.queryParameters['id'] == null
            ? '/dashboard/all-files'
            : null,
        builder: (context, state) =>
            FileDetailsScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/version-history',
        builder: (context, state) => const VersionHistoryScreen(),
      ),
      GoRoute(
        path: '/features/move-or-copy',
        redirect: (context, state) => state.uri.queryParameters['id'] == null
            ? '/dashboard/all-files'
            : null,
        builder: (context, state) =>
            MoveOrCopyScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/multi-select',
        builder: (context, state) => MultiSelectScreen(
          collectionName: state.uri.queryParameters['collection'],
        ),
      ),
      GoRoute(
        path: '/features/move-to',
        builder: (context, state) => const MoveToScreen(),
      ),
      GoRoute(
        path: '/features/rename',
        redirect: (context, state) => state.uri.queryParameters['id'] == null
            ? '/dashboard/all-files'
            : null,
        builder: (context, state) =>
            RenameScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/merge-pdf',
        builder: (context, state) => const MergePdfScreen(),
      ),
      GoRoute(
        path: '/features/split-pdf',
        builder: (context, state) => const SplitPdfScreen(),
      ),
      GoRoute(
        path: '/features/ocr-scan-text',
        redirect: (context, state) => state.uri.queryParameters['id'] == null
            ? '/dashboard/all-files'
            : null,
        builder: (context, state) =>
            OcrScanTextScreen(documentId: state.uri.queryParameters['id']),
      ),
      GoRoute(
        path: '/features/document-compare',
        builder: (context, state) => const DocumentCompareScreen(),
      ),
      GoRoute(
        path: '/features/add-notes',
        builder: (context, state) => const AddNotesScreen(),
      ),
      GoRoute(
        path: '/features/print-save-as',
        builder: (context, state) => const PrintSaveAsScreen(),
      ),
      GoRoute(
        path: '/features/scan-securely',
        builder: (context, state) => const SecureScanScreen(),
      ),
      // GoRoute(path: '/features/health-collection', builder: (context, state) => const HealthCollectionScreen()),
      // GoRoute(path: '/features/finance-collection', builder: (context, state) => const FinanceCollectionScreen()),
      // GoRoute(path: '/features/property-collection', builder: (context, state) => const PropertyCollectionScreen()),
      // GoRoute(path: '/features/vehicle-collection', builder: (context, state) => const VehicleCollectionScreen()),
      // GoRoute(path: '/features/education-collection', builder: (context, state) => const EducationCollectionScreen()),
      // GoRoute(path: '/features/identity-collection', builder: (context, state) => const IdentityCollectionScreen()),
      // GoRoute(path: '/features/insurance-collection', builder: (context, state) => const InsuranceCollectionScreen()),
      // GoRoute(path: '/features/travel-collection', builder: (context, state) => const TravelCollectionScreen()),
      // GoRoute(path: '/features/work-collection', builder: (context, state) => const WorkCollectionScreen()),
      GoRoute(
        path: '/features/custom-collection',
        builder: (context, state) => const CustomCollectionScreen(),
      ),
      GoRoute(
        path: '/features/ai-chat',
        builder: (context, state) => const AiChatScreen(),
      ),
      GoRoute(
        path: '/features/ai-insights',
        builder: (context, state) => const AiInsightsScreen(),
      ),
      GoRoute(
        path: '/features/smart-suggestions',
        builder: (context, state) => const SmartSuggestionsScreen(),
      ),
      GoRoute(
        path: '/features/similar-documents',
        builder: (context, state) => const SimilarDocumentsScreen(),
      ),
      GoRoute(
        path: '/features/duplicate-resolution',
        builder: (context, state) => DuplicateResolutionScreen(
          documentIds: [
            if (state.uri.queryParameters['first'] case final id?) id,
            if (state.uri.queryParameters['second'] case final id?) id,
          ],
        ),
      ),
      GoRoute(
        path: '/features/ai-timeline',
        builder: (context, state) => const AiTimelineScreen(),
      ),
      GoRoute(
        path: '/features/auto-tagging',
        builder: (context, state) => const AutoTaggingScreen(),
      ),
      GoRoute(
        path: '/features/ai-search-results',
        builder: (context, state) =>
            AiSearchResultsScreen(query: state.uri.queryParameters['q'] ?? ''),
      ),
      GoRoute(
        path: '/features/ai-settings',
        builder: (context, state) => const AiSettingsScreen(),
      ),
      GoRoute(
        path: '/features/ai-history',
        builder: (context, state) => const AiHistoryScreen(),
      ),
      GoRoute(
        path: '/features/family-sharing',
        builder: (context, state) => const FamilyVaultScreen(),
      ),
      GoRoute(
        path: '/features/members',
        builder: (context, state) => const MembersScreen(),
      ),
      GoRoute(
        path: '/features/invite-members',
        builder: (context, state) => const InviteMembersScreen(),
      ),
      GoRoute(
        path: '/features/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
      GoRoute(
        path: '/features/trusted-contacts',
        builder: (context, state) => const TrustedContactsScreen(),
      ),
      GoRoute(
        path: '/features/emergency-access',
        builder: (context, state) => const EmergencyAccessScreen(),
      ),
      GoRoute(
        path: '/features/shared-collections',
        builder: (context, state) => const SharedCollectionsScreen(),
      ),
      GoRoute(
        path: '/features/shared-activity',
        builder: (context, state) => const SharedActivityScreen(),
      ),
      GoRoute(
        path: '/features/invitations',
        builder: (context, state) => const InvitationsScreen(),
      ),
      GoRoute(
        path: '/features/access-history',
        builder: (context, state) => const AccessHistoryScreen(),
      ),
      GoRoute(
        path: '/features/backup-restore',
        builder: (context, state) => const BackupRestoreScreen(),
      ),
      GoRoute(
        path: '/features/pro',
        builder: (context, state) => const OwnKeepProScreen(),
      ),
      GoRoute(
        path: '/features/themes',
        builder: (context, state) => const ThemesScreen(),
      ),
      GoRoute(
        path: '/features/app-lock',
        builder: (context, state) => const AppLockScreen(),
      ),
      GoRoute(
        path: '/features/hidden-vault',
        builder: (context, state) => const HiddenVaultScreen(),
      ),
      GoRoute(
        path: '/features/decoy-vault',
        builder: (context, state) => const DecoyVaultScreen(),
      ),
      GoRoute(
        path: '/features/recovery-verification',
        builder: (context, state) => const RecoveryVerificationScreen(),
      ),
      GoRoute(
        path: '/features/encryption-details',
        builder: (context, state) => const EncryptionDetailsScreen(),
      ),
      GoRoute(
        path: '/features/device-migration',
        builder: (context, state) => const DeviceMigrationScreen(),
      ),
      GoRoute(
        path: '/features/restore-vault',
        builder: (context, state) => const RestoreVaultScreen(),
      ),
      GoRoute(
        path: '/features/security-audit',
        builder: (context, state) => const SecurityAuditScreen(),
      ),
      // GoRoute(path: '/features/ownkeep-pro', builder: (context, state) => const OwnKeepProScreen()),

      // Collections Routes
      GoRoute(
        path: '/collections/custom/new',
        builder: (context, state) => const CustomCollectionScreen(),
      ),
      GoRoute(
        path: '/collections/custom/:id',
        builder: (context, state) => CustomCollectionDetailScreen(
          collectionId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/collections/:category',
        redirect: (context, state) =>
            SmartCollectionCategory.fromName(
                  state.pathParameters['category'] ?? '',
                ) ==
                null
            ? '/dashboard/collections'
            : null,
        builder: (context, state) {
          final categoryName = state.pathParameters['category'] ?? '';
          final category = SmartCollectionCategory.fromName(categoryName)!;
          return SmartCollectionScreen(category: category);
        },
      ),

      // Dashboard Shell Route
      ShellRoute(
        redirect: (context, state) =>
            ref.read(vaultSessionProvider).value == null ? '/lock' : null,
        builder: (context, state, child) {
          return DashboardScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard/home',
            builder: (context, state) => const HomeDashboardScreen(),
          ),
          GoRoute(
            path: '/dashboard/collections',
            builder: (context, state) => const CollectionsScreen(),
          ),
          GoRoute(
            path: '/dashboard/all-files',
            builder: (context, state) => const AllFilesScreen(),
          ),
          GoRoute(
            path: '/dashboard/recent',
            builder: (context, state) => const RecentScreen(),
          ),
          GoRoute(
            path: '/dashboard/favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: '/dashboard/categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: '/dashboard/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/dashboard/global-search',
            builder: (context, state) => const GlobalSearchScreen(),
          ),
          GoRoute(
            path: '/dashboard/filter-and-sort',
            builder: (context, state) => const FilterAndSortScreen(),
          ),
        ],
      ),
    ],
  );
});

class DashboardScaffold extends StatefulWidget {
  final Widget child;
  const DashboardScaffold({super.key, required this.child});

  @override
  State<DashboardScaffold> createState() => _DashboardScaffoldState();
}

class _DashboardScaffoldState extends State<DashboardScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _currentIndex = switch (GoRouterState.of(context).uri.path) {
      '/dashboard/collections' => 1,
      '/dashboard/recent' => 2,
      _ => 0,
    };
    return Scaffold(
      extendBody: true,
      drawer: const NavigationMenuDrawer(),
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 64,
        width: 64,
        margin: const EdgeInsets.only(top: 32),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: OwnKeepColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: OwnKeepColors.primaryPurple.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            context.push('/features/add-item-menu');
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      // Use Builder so Scaffold.of() gets a context that is *below* this Scaffold
      bottomNavigationBar: Builder(
        builder: (innerContext) => Container(
          height: 80,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          decoration: BoxDecoration(
            color: OwnKeepColors.surfaceDark.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: OwnKeepColors.surfaceHighlight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                0,
                Icons.home_outlined,
                Icons.home,
                'Home',
                () => innerContext.go('/dashboard/home'),
              ),
              _buildNavItem(
                1,
                Icons.folder_outlined,
                Icons.folder,
                'Collections',
                () => innerContext.go('/dashboard/collections'),
              ),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(
                2,
                Icons.history,
                Icons.history,
                'Activity',
                () => innerContext.go('/dashboard/recent'),
              ),
              _buildNavItem(
                3,
                Icons.person_outline,
                Icons.person,
                'Profile',
                () {
                  innerContext.push('/features/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
    String label,
    VoidCallback onTap,
  ) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? selectedIcon : unselectedIcon,
            color: isSelected
                ? OwnKeepColors.primaryBlue
                : OwnKeepColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? OwnKeepColors.primaryBlue
                  : OwnKeepColors.textSecondary,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

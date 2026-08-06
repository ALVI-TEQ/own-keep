import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../providers/vault_provider.dart';

class NavigationMenuDrawer extends ConsumerWidget {
  const NavigationMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    return Drawer(
      backgroundColor: colors.navigationBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.borderSoft),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.profile,
                        colorFilter: ColorFilter.mode(colors.neutralIcon, BlendMode.srcIn),
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
                          l10n.s20_profile_name,
                          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.s20_vault_name,
                          style: TextStyle(color: colors.primaryBlue, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    OwnKeepMainIcons.settings,
                    colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                    width: 24,
                  ),
                ],
              ),
            ),
            
            // Storage Quick Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      OwnKeepMainIcons.storage,
                      colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                      width: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.s20_vault_summary,
                        style: TextStyle(color: colors.textSecondary, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Text(l10n.s20_navigation, style: TextStyle(color: colors.textMuted, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildNavItem(context, l10n.nav_home, l10n.nav_home_body, OwnKeepMainIcons.home, true, () => context.pop()),
                  _buildNavItem(context, l10n.nav_collections, l10n.nav_collections_body, OwnKeepMainIcons.collections, false, () { context.pop(); context.push('/features/tag-manager'); }),
                  _buildNavItem(context, l10n.nav_ai, l10n.nav_ai_body, OwnKeepMainIcons.aiAssistant, false, () { context.pop(); context.push('/features/ai-organize'); }),
                  _buildNavItem(context, l10n.nav_reminders, l10n.nav_reminders_body, OwnKeepMainIcons.reminder, false, () { context.pop(); context.push('/features/health-reminders'); }),
                  _buildNavItem(context, l10n.nav_activity, l10n.nav_activity_body, OwnKeepMainIcons.activity, false, () { context.pop(); context.push('/features/access-history'); }),
                  _buildNavItem(context, l10n.nav_backup, l10n.nav_backup_body, OwnKeepMainIcons.backup, false, () { context.pop(); context.push('/features/backup-restore'); }),
                  const SizedBox(height: 16),
                  Divider(color: colors.borderSoft),
                  const SizedBox(height: 16),
                  _buildNavItem(context, l10n.nav_settings, l10n.nav_settings_body, OwnKeepMainIcons.settings, false, () { context.pop(); context.push('/features/settings-advanced'); }),
                  _buildNavItem(context, l10n.nav_help, l10n.nav_help_body, OwnKeepMainIcons.help, false, () { context.pop(); context.push('/features/help-support'); }),
                ],
              ),
            ),

            // Lock Vault Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: GestureDetector(
                onTap: () async {
                  await ref.read(vaultSessionProvider.notifier).lockVault();
                  if (context.mounted) {
                    context.go('/splash');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surfaceDanger,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.dangerRed.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.dangerRed.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.lock,
                          colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
                          width: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.nav_lock,
                              style: TextStyle(color: colors.dangerRed, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.nav_lock_body,
                              style: TextStyle(color: colors.dangerRed.withValues(alpha: 0.7), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String subtitle, String iconPath, bool isSelected, VoidCallback onTap) {
    final colors = context.mainColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(isSelected ? colors.primaryBlue : colors.neutralIcon, BlendMode.srcIn),
              width: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: isSelected ? colors.textPrimary : colors.textSecondary, fontSize: 15, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: colors.textMuted, fontSize: 12),
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

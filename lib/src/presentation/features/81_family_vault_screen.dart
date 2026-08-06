import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class FamilyVaultScreen extends StatelessWidget {
  const FamilyVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final sharedCollections = [
      {
        'title': l10n.s81_family_documents,
        'count': l10n.s81_family_documents_count,
        'scope': l10n.s81_family_documents_scope,
        'color': colors.primaryBlue,
        'icon': OwnKeepMainIcons.folder,
      },
      {
        'title': l10n.s81_health_records,
        'count': l10n.s81_health_records_count,
        'scope': l10n.s81_health_records_scope,
        'color': colors.healthPink,
        'icon': OwnKeepMainIcons.health,
      },
      {
        'title': l10n.s81_property_papers,
        'count': l10n.s81_property_papers_count,
        'scope': l10n.s81_property_papers_scope,
        'color': colors.warningOrange,
        'icon': OwnKeepMainIcons.property,
      },
      {
        'title': l10n.s81_education,
        'count': l10n.s81_education_count,
        'scope': l10n.s81_education_scope,
        'color': colors.successGreen,
        'icon': OwnKeepMainIcons.education,
      },
      {
        'title': l10n.s81_emergency_pack,
        'count': l10n.s81_emergency_pack_count,
        'scope': l10n.s81_emergency_pack_scope,
        'color': colors.dangerRed,
        'icon': OwnKeepMainIcons.emergency,
      },
    ];

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(l10n.s81_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s81_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.history, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
            onPressed: () => context.push('/features/access-history'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Offline Sharing Notice
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.aiPurple.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(OwnKeepMainIcons.offline, colorFilter: ColorFilter.mode(colors.aiPurple, BlendMode.srcIn), width: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s81_offline_sharing, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(l10n.s81_offline_sharing_body, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Family Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.s81_family, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(l10n.s81_family_summary, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                    ],
                  ),
                  TextButton(
                    onPressed: () => context.push('/features/members'),
                    child: Text(l10n.s81_manage_members, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Member Avatars Preview
              Row(
                children: [
                  _buildAvatar(context, 'A', const Color(0xFF4668FF)),
                  const SizedBox(width: -12),
                  _buildAvatar(context, 'H', const Color(0xFFFF4C9A)),
                  const SizedBox(width: -12),
                  _buildAvatar(context, 'C', const Color(0xFF28CC91)),
                  const SizedBox(width: -12),
                  _buildAvatar(context, 'R', const Color(0xFFFFA42F)),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => context.push('/features/invite-members'),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.primaryBlue, width: 1, style: BorderStyle.solid),
                      ),
                      child: Icon(Icons.add, color: colors.primaryBlue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Shared Collections
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.s81_shared_collections, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => context.push('/features/shared-collections'),
                    child: Text(l10n.common_view_all, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              ...sharedCollections.map((col) => _buildCollectionCard(context, col, colors)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String initial, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing member $initial')));
      },
      child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF030B19), width: 2),
      ),
      child: Center(
        child: Text(initial, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      ),
    );
  }

  Widget _buildCollectionCard(BuildContext context, Map<String, dynamic> col, OwnKeepMainColorsTheme colors) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing collection: ${col['title']}')));
      },
      child: Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              color: (col['color'] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(col['icon'] as String, colorFilter: ColorFilter.mode(col['color'] as Color, BlendMode.srcIn), width: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(col['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(col['count'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(col['scope'] as String, style: TextStyle(color: colors.textMuted, fontSize: 10)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
        ],
      ),
      ),
    );
  }
}

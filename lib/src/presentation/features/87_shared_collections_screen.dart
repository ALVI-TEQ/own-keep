import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SharedCollectionsScreen extends StatelessWidget {
  const SharedCollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final collections = [
      {
        'title': l10n.s87_family_documents,
        'meta': l10n.s87_family_documents_meta,
        'members': l10n.s87_family_documents_members,
        'icon': OwnKeepMainIcons.folder,
        'color': colors.primaryBlue,
      },
      {
        'title': l10n.s87_health,
        'meta': l10n.s87_health_meta,
        'members': l10n.s87_health_members,
        'icon': OwnKeepMainIcons.health,
        'color': colors.healthPink,
      },
      {
        'title': l10n.s87_property,
        'meta': l10n.s87_property_meta,
        'members': l10n.s87_property_members,
        'icon': OwnKeepMainIcons.property,
        'color': colors.warningOrange,
      },
      {
        'title': l10n.s87_education,
        'meta': l10n.s87_education_meta,
        'members': l10n.s87_education_members,
        'icon': OwnKeepMainIcons.education,
        'color': colors.successGreen,
      },
      {
        'title': l10n.s87_emergency,
        'meta': l10n.s87_emergency_meta,
        'members': l10n.s87_emergency_contacts,
        'icon': OwnKeepMainIcons.emergency,
        'color': colors.dangerRed,
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
            Text(l10n.s87_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s87_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
          ],
        ),
        centerTitle: true,
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
              // Method Info Banner
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
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(OwnKeepMainIcons.device_sync, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s87_method, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(l10n.s87_method_value, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Collections List
              ...collections.map((col) => _buildCollectionCard(context, col, colors)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Creating shared collection')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s87_create,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(BuildContext context, Map<String, dynamic> col, OwnKeepMainColorsTheme colors) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing collection ${col['title']}')));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    Text(col['meta'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              SvgPicture.asset(OwnKeepMainIcons.more_vert, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surfaceSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_outline, color: colors.textMuted, size: 16),
                const SizedBox(width: 8),
                Text(col['members'] as String, style: TextStyle(color: colors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class RecentScreen extends ConsumerWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.mainColors;

    final controller = ref.watch(ingestionControllerProvider);

    if (controller == null) {
      return Scaffold(backgroundColor: colors.backgroundTop);
    }

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
                          colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
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
                            l10n.s14_title,
                            style: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.s14_subtitle,
                            style: TextStyle(color: colors.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Filters
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildFilterChip(context, l10n.filter_all, true),
                    _buildFilterChip(context, l10n.filter_viewed, false),
                    _buildFilterChip(context, l10n.filter_added, false),
                    _buildFilterChip(context, l10n.filter_updated, false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Recent Items List
              Expanded(
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    final docs = controller.dashboardDocuments;
                    if (docs.isEmpty) {
                      return Center(child: Text('No recent items', style: TextStyle(color: colors.textSecondary)));
                    }

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      children: [
                        Text(l10n.filter_all, style: TextStyle(color: colors.textMuted, fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        ...docs.map((doc) => _buildRecentItem(
                          context,
                          doc.logicalFilename.isNotEmpty ? doc.logicalFilename : 'Untitled',
                          doc.documentType.toString().split('.').last, // Just for testing
                          OwnKeepMainIcons.file_pdf,
                          colors.primaryBlue,
                        )).toList(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    final colors = context.mainColors;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryBlue : colors.surfacePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? colors.primaryBlue : colors.borderSoft),
      ),
      child: Center(
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

  Widget _buildRecentItem(BuildContext context, String title, String meta, String iconPath, Color iconColor) {
    final colors = context.mainColors;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: TextStyle(color: colors.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            OwnKeepMainIcons.moreVertical,
            colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
            width: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class DuplicateResolutionScreen extends StatefulWidget {
  const DuplicateResolutionScreen({super.key});

  @override
  State<DuplicateResolutionScreen> createState() => _DuplicateResolutionScreenState();
}

class _DuplicateResolutionScreenState extends State<DuplicateResolutionScreen> {
  int _selectedIndex = 0; // 0 = current, 1 = duplicate

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

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
            Text(l10n.s75_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s75_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Header
              Text(l10n.s75_group, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.s75_group_title, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.borderSoft),
                    ),
                    child: Text(l10n.s75_group_size, style: TextStyle(color: colors.textMuted, fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Recommendations Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(OwnKeepMainIcons.ai_sparkle, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s75_recommended, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w600)),
                          Text(l10n.s75_recommendation, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // File 1 (Current)
              _buildFileCard(
                title: l10n.s75_current_name,
                meta: l10n.s75_current_meta,
                badge: l10n.s75_current,
                isSelected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
                colors: colors,
              ),
              const SizedBox(height: 16),

              // File 2 (Duplicate)
              _buildFileCard(
                title: l10n.s75_duplicate_name,
                meta: l10n.s75_duplicate_meta,
                badge: l10n.s75_duplicate,
                isSelected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
                colors: colors,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Duplicate resolved!')));
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.dangerRed,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    l10n.s75_keep_selected,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(l10n.s75_keep_both, style: TextStyle(color: colors.primaryBlue, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileCard({
    required String title,
    required String meta,
    required String badge,
    required bool isSelected,
    required VoidCallback onTap,
    required OwnKeepMainColorsTheme colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBlue.withValues(alpha: 0.1) : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(OwnKeepMainIcons.file_pdf, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.surfaceSecondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(badge, style: TextStyle(color: colors.textMuted, fontSize: 10)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(meta, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text('View document', style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.primaryBlue : colors.textSecondary,
                  width: 2,
                ),
                color: isSelected ? colors.primaryBlue : Colors.transparent,
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.lg, vertical: OwnKeepSpacing.md),
        children: [
          Container(
            padding: const EdgeInsets.all(OwnKeepSpacing.xl),
            decoration: BoxDecoration(
              color: colors.surfacePrimary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.borderSoft),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: colors.surfaceSecondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.borderSoft, width: 2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.profile,
                      colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn),
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(height: OwnKeepSpacing.md),
                Text(
                  'My Vault Profile',
                  style: TextStyle(
                    color: colors.textPrimary, 
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: OwnKeepSpacing.xxl),
                _buildOption(context, colors, 'Settings & Preferences', OwnKeepMainIcons.settings, '/features/settings-advanced'),
                Divider(color: colors.borderSoft, height: 1),
                _buildOption(context, colors, 'Security & App Lock', OwnKeepMainIcons.lock, '/lock'),
                Divider(color: colors.borderSoft, height: 1),
                _buildOption(context, colors, 'Help & Support', OwnKeepMainIcons.help, '/features/help-support'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, OwnKeepMainColorsTheme colors, String label, String iconPath, String route) {
    return InkWell(
      onTap: () => context.push(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath, 
              colorFilter: ColorFilter.mode(colors.neutralIcon, BlendMode.srcIn), 
              width: 24,
            ),
            const SizedBox(width: OwnKeepSpacing.md),
            Expanded(
              child: Text(
                label, 
                style: TextStyle(
                  color: colors.textPrimary, 
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: colors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

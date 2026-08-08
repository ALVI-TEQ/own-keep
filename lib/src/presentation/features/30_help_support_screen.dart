import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter/services.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  String _query = '';

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
          l10n.s30_title,
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
        padding: const EdgeInsets.all(OwnKeepSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              l10n.s30_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),

            // Search Bar
            TextField(
              onChanged: (value) =>
                  setState(() => _query = value.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'Search help...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfacePrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xxl),

            // Support Options
            if (_matches('${l10n.s30_faq} Recover Backup'))
              _buildSupportOption(
                context: context,
                colors: colors,
                icon: OwnKeepMainIcons.faq,
                iconColor: const Color(0xFF27C5E8), // accentCyan
                title: l10n.s30_faq,
                subtitle: l10n.s30_faq_body,
                onTap: () => context.push('/features/tutorials'),
              ),
            const SizedBox(height: OwnKeepSpacing.sm),
            if (_matches('${l10n.s30_user_guide} Share'))
              _buildSupportOption(
                context: context,
                colors: colors,
                icon: OwnKeepMainIcons.guide_book,
                iconColor: colors.warningOrange,
                title: l10n.s30_user_guide,
                subtitle: l10n.s30_user_guide_body,
                onTap: () => context.push('/features/onboarding-guide'),
              ),
            const SizedBox(height: OwnKeepSpacing.sm),
            if (_matches('${l10n.s30_contact} support@ownkeep.app'))
              _buildSupportOption(
                context: context,
                colors: colors,
                icon: OwnKeepMainIcons.contact_support,
                iconColor: colors.primaryBlue,
                title: l10n.s30_contact,
                subtitle: l10n.s30_contact_body,
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: 'support@ownkeep.app'),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Support email copied.')),
                    );
                  }
                },
              ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // Popular Topics
            Text(
              'Popular Topics',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.md),
            if (_matches('Recover'))
              _buildPopularTopic(
                context,
                colors,
                'Recover',
                '/features/recovery-center',
              ),
            if (_matches('Share'))
              _buildPopularTopic(
                context,
                colors,
                'Share',
                '/features/share-export',
              ),
            if (_matches('Backup'))
              _buildPopularTopic(
                context,
                colors,
                'Backup',
                '/features/backup-restore',
              ),

            const SizedBox(height: OwnKeepSpacing.xxl),

            // App Version
            Center(
              child: Text(
                l10n.s30_version,
                style: TextStyle(
                  color: colors.textMuted,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: OwnKeepSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required BuildContext context,
    required OwnKeepMainColorsTheme colors,
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: colors.surfacePrimary,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.borderSoft),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.surfaceSelected,
                  shape: BoxShape.circle,
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
                  ],
                ),
              ),
              SvgPicture.asset(
                OwnKeepMainIcons.chevron_right,
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
    );
  }

  Widget _buildPopularTopic(
    BuildContext context,
    OwnKeepMainColorsTheme colors,
    String title,
    String route,
  ) {
    return InkWell(
      onTap: () => context.push(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              OwnKeepMainIcons.search,
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SvgPicture.asset(
              OwnKeepMainIcons.chevron_right,
              colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  bool _matches(String value) =>
      _query.isEmpty || value.toLowerCase().contains(_query);
}

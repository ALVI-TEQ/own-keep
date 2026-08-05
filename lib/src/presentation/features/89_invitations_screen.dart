import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final pending = [
      {
        'name': 'Harika',
        'meta': l10n.s89_harika_meta,
        'expiry': l10n.s89_harika_expiry,
        'initial': 'H',
        'color': const Color(0xFFFF4C9A),
      },
      {
        'name': 'Ramesh',
        'meta': l10n.s89_ramesh_meta,
        'expiry': l10n.s89_ramesh_expiry,
        'initial': 'R',
        'color': const Color(0xFFFFA42F),
      },
    ];

    final completed = [
      {
        'name': 'Alekhya',
        'meta': l10n.s89_alekhya_joined,
        'initial': 'A',
        'color': const Color(0xFF8548FF),
      },
      {
        'name': 'Charvika',
        'meta': l10n.s89_charvika_joined,
        'initial': 'C',
        'color': const Color(0xFF28CC91),
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
            Text(l10n.s89_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s89_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Pending Section
              Text(l10n.s89_pending, style: TextStyle(color: colors.warningOrange, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...pending.map((inv) => _buildInvitationCard(inv, true, colors)),
              
              const SizedBox(height: 32),

              // Completed Section
              Text(l10n.s89_completed, style: TextStyle(color: colors.successGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...completed.map((inv) => _buildInvitationCard(inv, false, colors)),

              const SizedBox(height: 40),

              // Security Banner
              Container(
                padding: const EdgeInsets.all(20),
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
                        Icon(Icons.shield_outlined, color: colors.primaryBlue, size: 24),
                        const SizedBox(width: 8),
                        Text(l10n.s89_security, style: TextStyle(color: colors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSecurityRule(l10n.s89_single_use, l10n.s89_single_use_body, colors),
                    const SizedBox(height: 12),
                    _buildSecurityRule(l10n.s89_time_limited, l10n.s89_time_limited_body, colors),
                    const SizedBox(height: 12),
                    _buildSecurityRule(l10n.s89_device_verified, l10n.s89_device_verified_body, colors),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvitationCard(Map<String, dynamic> inv, bool isPending, OwnKeepMainColorsTheme colors) {
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: inv['color'] as Color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(inv['initial'] as String, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(inv['name'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(inv['meta'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                if (isPending) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.warningOrange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(inv['expiry'] as String, style: TextStyle(color: colors.warningOrange, fontSize: 12)),
                  ),
                ],
              ],
            ),
          ),
          if (isPending)
            IconButton(
              icon: Icon(Icons.close, color: colors.textMuted),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityRule(String title, String body, OwnKeepMainColorsTheme colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: colors.successGreen, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(body, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final members = [
      {
        'name': 'Arjun',
        'meta': l10n.s82_arjun_meta,
        'initial': 'A',
        'color': const Color(0xFF4668FF),
        'isOwner': true,
      },
      {
        'name': 'Harika',
        'meta': l10n.s82_harika_meta,
        'initial': 'H',
        'color': const Color(0xFFFF4C9A),
        'isOwner': false,
      },
      {
        'name': 'Alekhya',
        'meta': l10n.s82_alekhya_meta,
        'initial': 'A',
        'color': const Color(0xFF8548FF),
        'isOwner': false,
      },
      {
        'name': 'Charvika',
        'meta': l10n.s82_charvika_meta,
        'initial': 'C',
        'color': const Color(0xFF28CC91),
        'isOwner': false,
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
            Text(l10n.s82_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s82_member_count, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Access Summary Card
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
                    Text(l10n.s82_access_summary, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStat(l10n.s82_members_value, l10n.s82_members_label, colors.primaryBlue, colors),
                        _buildStat(l10n.s82_collections_value, l10n.s82_collections_label, colors.successGreen, colors),
                        _buildStat(l10n.s82_trusted_value, l10n.s82_trusted_label, colors.aiPurple, colors),
                        _buildStat(l10n.s82_pending_value, l10n.s82_pending_label, colors.warningOrange, colors),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Member List
              ...members.map((member) => _buildMemberCard(member, colors, context)),
              
              const SizedBox(height: 32),
              
              // Transfer Options
              Text(l10n.s82_transfer_options, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              _buildTransferOption(l10n.s82_nearby, l10n.s82_nearby_body, OwnKeepMainIcons.device_sync, colors.accentCyan, colors),
              _buildTransferOption(l10n.s82_qr, l10n.s82_qr_body, OwnKeepMainIcons.qr_code, colors.primaryBlue, colors),
              _buildTransferOption(l10n.s82_package, l10n.s82_package_body, OwnKeepMainIcons.folder_export, colors.aiPurple, colors),
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
              onPressed: () => context.push('/features/invite-members'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s81_add_member,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, Color valueColor, OwnKeepMainColorsTheme colors) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: valueColor, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: colors.textMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member, OwnKeepMainColorsTheme colors, BuildContext context) {
    final bool isOwner = member['isOwner'] as bool;
    return GestureDetector(
      onTap: isOwner ? null : () => context.push('/features/permissions'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isOwner ? colors.primaryBlue.withValues(alpha: 0.3) : colors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: member['color'] as Color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(member['initial'] as String, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member['name'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(member['meta'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                ],
              ),
            ),
            if (!isOwner)
              SvgPicture.asset(OwnKeepMainIcons.chevron_right, colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferOption(String title, String body, String iconPath, Color iconColor, OwnKeepMainColorsTheme colors) {
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), width: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

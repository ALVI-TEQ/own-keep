import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SecurityAuditScreen extends StatelessWidget {
  const SecurityAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final auditResults = [
      {'title': l10n.s100_encryption, 'body': l10n.s100_encryption_body, 'ok': true},
      {'title': l10n.s100_recovery, 'body': l10n.s100_recovery_body, 'ok': true},
      {'title': l10n.s100_biometric, 'body': l10n.s100_biometric_body, 'ok': true},
      {'title': l10n.s100_backup, 'body': l10n.s100_backup_body, 'ok': false, 'warning': true},
      {'title': l10n.s100_hidden, 'body': l10n.s100_hidden_body, 'ok': false},
      {'title': l10n.s100_decoy, 'body': l10n.s100_decoy_body, 'ok': false},
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
            Text(l10n.s100_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s100_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(OwnKeepMainIcons.device_sync, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mock Audit Started')));
            },
          )
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Score Arc Graphic (Mocked with Container for now)
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.successGreen, width: 8),
                  color: colors.surfacePrimary,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.s100_score, style: TextStyle(color: colors.textPrimary, fontSize: 48, fontWeight: FontWeight.bold)),
                      Text(l10n.s100_score_label, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.s100_rating, style: TextStyle(color: colors.successGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(l10n.s100_last_audit, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              const SizedBox(height: 40),

              // Results List
              Align(
                alignment: Alignment.centerLeft,
                child: Text(l10n.s100_results, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              
              ...auditResults.map((result) => _buildResultRow(result, colors)),
              
              const SizedBox(height: 32),

              // Recommendation Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.warningOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.warningOrange.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: colors.warningOrange, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s100_next, style: TextStyle(color: colors.warningOrange, fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(l10n.s100_next_body, style: TextStyle(color: colors.textPrimary, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resolving Issue...')));
                      },
                      child: Text('Backup', style: TextStyle(color: colors.primaryBlue, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(Map<String, dynamic> result, OwnKeepMainColorsTheme colors) {
    bool isOk = result['ok'] == true;
    bool isWarning = result['warning'] == true;

    Color iconColor;
    IconData iconData;
    if (isOk) {
      iconColor = colors.successGreen;
      iconData = Icons.check_circle;
    } else if (isWarning) {
      iconColor = colors.warningOrange;
      iconData = Icons.error_outline;
    } else {
      iconColor = colors.textMuted;
      iconData = Icons.remove_circle_outline;
    }

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
          Icon(iconData, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(result['body'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

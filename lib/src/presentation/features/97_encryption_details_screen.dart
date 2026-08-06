import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class EncryptionDetailsScreen extends StatelessWidget {
  const EncryptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final technicalSpecs = [
      {'title': l10n.s97_content, 'value': l10n.s97_content_value, 'icon': OwnKeepMainIcons.security},
      {'title': l10n.s97_kdf, 'value': l10n.s97_kdf_value, 'icon': OwnKeepMainIcons.key},
      {'title': l10n.s97_manifest, 'value': l10n.s97_manifest_value, 'icon': OwnKeepMainIcons.document},
      {'title': l10n.s97_integrity, 'value': l10n.s97_integrity_value, 'icon': OwnKeepMainIcons.check},
      {'title': l10n.s97_container, 'value': l10n.s97_container_value, 'icon': OwnKeepMainIcons.database},
      {'title': l10n.s97_envelope, 'value': l10n.s97_envelope_value, 'icon': OwnKeepMainIcons.email},
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
            Text(l10n.s97_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s97_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Status Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.successGreen.withValues(alpha: 0.1), colors.backgroundTop],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.successGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.successGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.verified_user_outlined, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s97_status, style: TextStyle(color: colors.successGreen, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(l10n.s97_status_body, style: TextStyle(color: colors.textPrimary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Technical Specs
              ...technicalSpecs.map((spec) => _buildSpecItem(context, spec, colors)),
              
              const SizedBox(height: 24),
              
              // Security Model Note
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.privacy_tip_outlined, color: colors.primaryBlue, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s97_security_model, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(l10n.s97_security_model_body, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
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

  Widget _buildSpecItem(BuildContext context, Map<String, dynamic> spec, OwnKeepMainColorsTheme colors) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied ${spec['title']} details')));
      },
      child: Container(
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
              color: colors.surfaceSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(spec['icon'] as String, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(spec['title'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
          ),
          Text(spec['value'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
        ],
      ),
      ),
    );
  }
}

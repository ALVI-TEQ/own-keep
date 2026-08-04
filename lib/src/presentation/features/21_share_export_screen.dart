import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class ShareExportScreen extends StatelessWidget {
  const ShareExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Share & Export',
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.verified_outlined, color: OwnKeepColors.success),
        ),
      ],
      body: ListView(
        children: [
          // Hero banner
          Container(
            margin: EdgeInsets.all(OwnKeepSpacing.base),
            padding: EdgeInsets.all(OwnKeepSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OwnKeepColors.ai.withValues(alpha: 0.2),
                  OwnKeepColors.primary.withValues(alpha: 0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'Share Securely',
                  style: TextStyle(
                    color: OwnKeepColors.darkTextPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.sm),
                Text(
                  'Your data stays encrypted.\nYou\'re in control.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: OwnKeepColors.darkTextSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 40, color: OwnKeepColors.ai.withValues(alpha: 0.7)),
                    SizedBox(width: 12),
                    Icon(Icons.security_rounded, size: 50, color: OwnKeepColors.primary.withValues(alpha: 0.8)),
                    SizedBox(width: 12),
                    Icon(Icons.mail_outline_rounded, size: 40, color: OwnKeepColors.success.withValues(alpha: 0.7)),
                  ],
                ),
              ],
            ),
          ),
          // Share options
          OwnKeepListTile(
            title: 'Share with OwnKeep User',
            subtitle: 'Share vault items with another\nOwnKeep user via encrypted link',
            icon: Icons.people_outline_rounded,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Generate Secure Link',
            subtitle: 'Create a time-limited encrypted\nlink to share',
            icon: Icons.link_rounded,
            iconColor: OwnKeepColors.ai,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Export Encrypted File',
            subtitle: 'Export as encrypted .ovault file\nto share via any medium',
            icon: Icons.lock_outline_rounded,
            iconColor: OwnKeepColors.success,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Export as PDF',
            subtitle: 'Export documents as PDF files',
            icon: Icons.picture_as_pdf_outlined,
            iconColor: OwnKeepColors.danger,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Export as ZIP',
            subtitle: 'Export original files in ZIP\n(Encrypted)',
            icon: Icons.folder_zip_outlined,
            iconColor: OwnKeepColors.orange,
            onTap: () {},
          ),
          const OwnKeepTipCard(
            text: 'Shared items can only be opened in OwnKeep and cannot be accessed by anyone else.',
          ),
        ],
      ),
    );
  }
}

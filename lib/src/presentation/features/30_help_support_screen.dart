import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../components/ownkeep_ui_kit.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Help & Support',
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.download_outlined, color: OwnKeepColors.darkTextPrimary)),
      ],
      body: ListView(
        children: [
          // Help Center section
          const OwnKeepSectionHeader(title: 'Help Center'),
          OwnKeepListTile(
            title: 'User Guide',
            subtitle: 'Learn how to use OwnKeep',
            icon: Icons.menu_book_outlined,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'FAQ',
            subtitle: 'Find answers to common questions',
            icon: Icons.help_outline_rounded,
            iconColor: OwnKeepColors.orange,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Video Tutorials',
            subtitle: 'Step by step video guides',
            icon: Icons.play_circle_outline,
            iconColor: OwnKeepColors.danger,
            onTap: () {},
          ),
          // Support section
          const OwnKeepSectionHeader(title: 'Support'),
          OwnKeepListTile(
            title: 'Contact Support',
            subtitle: 'We\'ll respond as soon as possible',
            icon: Icons.headset_mic_outlined,
            iconColor: OwnKeepColors.success,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Report an Issue',
            subtitle: 'Help us improve OwnKeep',
            icon: Icons.bug_report_outlined,
            iconColor: OwnKeepColors.warning,
            onTap: () {},
          ),
          // About section
          const OwnKeepSectionHeader(title: 'About'),
          OwnKeepListTile(
            title: 'About OwnKeep',
            subtitle: 'Version 1.0.0',
            icon: Icons.info_outline_rounded,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          const OwnKeepTipCard(
            text: 'Tip: All your data is stored only on your device. We never collect or transmit your information.',
          ),
        ],
      ),
    );
  }
}

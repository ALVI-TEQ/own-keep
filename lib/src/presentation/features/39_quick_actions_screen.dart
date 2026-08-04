import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../components/ownkeep_ui_kit.dart';

class QuickActionsScreen extends StatelessWidget {
  const QuickActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepScaffold(
      title: 'Quick Actions',
      showBottomNav: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Edit', style: TextStyle(color: OwnKeepColors.primary, fontFamily: 'Inter', fontWeight: FontWeight.w500)),
        ),
      ],
      body: ListView(
        children: [
          // Create New grid
          const OwnKeepSectionHeader(title: 'Create New'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: OwnKeepSpacing.md,
              crossAxisSpacing: OwnKeepSpacing.md,
              childAspectRatio: 0.88,
              children: const [
                OwnKeepGridAction(icon: Icons.document_scanner_outlined, label: 'Scan Document', iconColor: OwnKeepColors.primary),
                OwnKeepGridAction(icon: Icons.camera_alt_outlined, label: 'Take Photo', iconColor: OwnKeepColors.success),
                OwnKeepGridAction(icon: Icons.folder_open_outlined, label: 'Add Files', iconColor: OwnKeepColors.ai),
                OwnKeepGridAction(icon: Icons.mic_outlined, label: 'Voice Note', iconColor: OwnKeepColors.pink),
                OwnKeepGridAction(icon: Icons.sticky_note_2_outlined, label: 'Note', iconColor: OwnKeepColors.warning),
                OwnKeepGridAction(icon: Icons.create_new_folder_outlined, label: 'New Folder', iconColor: OwnKeepColors.orange),
              ],
            ),
          ),
          // Tools section
          const OwnKeepSectionHeader(title: 'Tools'),
          OwnKeepListTile(
            title: 'AI Organize',
            subtitle: 'Let AI organize your items',
            icon: Icons.auto_awesome_outlined,
            iconColor: OwnKeepColors.ai,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Duplicate Finder',
            subtitle: 'Find and remove duplicates',
            icon: Icons.file_copy_outlined,
            iconColor: OwnKeepColors.danger,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Export Vault',
            subtitle: 'Export your data securely',
            icon: Icons.ios_share_outlined,
            iconColor: OwnKeepColors.success,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Lock Vault',
            subtitle: 'Lock immediately',
            icon: Icons.lock_outline,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          // Shortcuts section
          const OwnKeepSectionHeader(title: 'Shortcuts'),
          OwnKeepListTile(
            title: 'Passport',
            subtitle: 'Documents > Personal',
            icon: Icons.badge_outlined,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          OwnKeepListTile(
            title: 'Insurance Policy',
            subtitle: 'Documents > Insurance',
            icon: Icons.shield_outlined,
            iconColor: OwnKeepColors.primary,
            onTap: () {},
          ),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

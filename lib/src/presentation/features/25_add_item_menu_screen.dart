import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../components/ownkeep_ui_kit.dart';

class AddItemMenuScreen extends StatelessWidget {
  const AddItemMenuScreen({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    try {
      final file = await picker.pickImage(source: source);
      if (file != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image selected: ${file.name}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _pickFiles(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File picking coming soon!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Add New Item', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.close, color: OwnKeepColors.darkTextPrimary),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
        children: [
          // Create New section
          const OwnKeepSectionHeader(title: 'Create New'),
          SizedBox(height: OwnKeepSpacing.sm),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: OwnKeepSpacing.base,
            crossAxisSpacing: OwnKeepSpacing.base,
            childAspectRatio: 0.9,
            children: [
              GestureDetector(
                onTap: () => _pickImage(context, ImageSource.camera),
                child: const OwnKeepGridAction(icon: Icons.document_scanner_outlined, label: 'Scan\nDocument', iconColor: OwnKeepColors.primary),
              ),
              GestureDetector(
                onTap: () => _pickImage(context, ImageSource.camera),
                child: const OwnKeepGridAction(icon: Icons.camera_alt_outlined, label: 'Take\nPhoto', iconColor: OwnKeepColors.success),
              ),
              GestureDetector(
                onTap: () => _pickFiles(context),
                child: const OwnKeepGridAction(icon: Icons.note_add_outlined, label: 'Add\nFiles', iconColor: OwnKeepColors.ai),
              ),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voice notes coming soon!'))),
                child: const OwnKeepGridAction(icon: Icons.mic_outlined, label: 'Voice\nNote', iconColor: OwnKeepColors.cyan),
              ),
              GestureDetector(
                onTap: () => context.push('/features/add-notes'),
                child: const OwnKeepGridAction(icon: Icons.sticky_note_2_outlined, label: 'Note', iconColor: OwnKeepColors.pink),
              ),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contacts coming soon!'))),
                child: const OwnKeepGridAction(icon: Icons.person_add_outlined, label: 'Contact', iconColor: OwnKeepColors.primary),
              ),
            ],
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          // Import From section
          const OwnKeepSectionHeader(title: 'Import From'),
          OwnKeepListTile(
            title: 'Import from Gallery',
            icon: Icons.photo_library_outlined,
            iconColor: OwnKeepColors.success,
            onTap: () => _pickImage(context, ImageSource.gallery),
          ),
          OwnKeepListTile(
            title: 'Import from Files',
            icon: Icons.folder_outlined,
            iconColor: OwnKeepColors.primary,
            onTap: () => _pickFiles(context),
          ),
          OwnKeepListTile(
            title: 'Import from Cloud',
            subtitle: '(Requires download first)',
            icon: Icons.cloud_download_outlined,
            iconColor: OwnKeepColors.ai,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cloud import coming soon!'))),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          // Create New Folder
          const OwnKeepSectionHeader(title: 'Create New Folder'),
          OwnKeepListTile(
            title: 'New Folder',
            icon: Icons.create_new_folder_outlined,
            iconColor: OwnKeepColors.orange,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Folder creation coming soon!'))),
          ),
          const OwnKeepTipCard(
            text: 'Tip: Keep your vault organized by adding items to collections.',
            icon: Icons.lightbulb_outline,
            iconColor: OwnKeepColors.warning,
          ),
        ],
      ),
    );
  }
}

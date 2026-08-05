import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  int _selectedMethodIndex = 0; // 0 = QR, 1 = Nearby, 2 = File

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

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
            Text(l10n.s83_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s83_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Member Name Field
              Text(l10n.s83_member_name, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: l10n.s83_member_name_value,
                style: TextStyle(color: colors.textPrimary, fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.surfacePrimary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.borderSoft),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.borderSoft),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Role Dropdown (Mocked as Container for UI)
              Text(l10n.s83_role, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adult', style: TextStyle(color: colors.textPrimary, fontSize: 16)),
                    Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Invitation Method Selection
              Text(l10n.s83_invitation_method, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
              const SizedBox(height: 16),
              
              _buildMethodCard(
                title: l10n.s83_qr,
                body: l10n.s83_qr_body,
                iconPath: OwnKeepMainIcons.qr_code,
                isSelected: _selectedMethodIndex == 0,
                onTap: () => setState(() => _selectedMethodIndex = 0),
                colors: colors,
              ),
              const SizedBox(height: 12),
              
              _buildMethodCard(
                title: l10n.s83_nearby,
                body: l10n.s83_nearby_body,
                iconPath: OwnKeepMainIcons.device_sync,
                isSelected: _selectedMethodIndex == 1,
                onTap: () => setState(() => _selectedMethodIndex = 1),
                colors: colors,
              ),
              const SizedBox(height: 12),

              _buildMethodCard(
                title: l10n.s83_file,
                body: l10n.s83_file_body,
                iconPath: OwnKeepMainIcons.folder_export,
                isSelected: _selectedMethodIndex == 2,
                onTap: () => setState(() => _selectedMethodIndex = 2),
                colors: colors,
              ),
              
              const SizedBox(height: 32),
              
              // Expiry Notice
              Row(
                children: [
                  Icon(Icons.info_outline, color: colors.textMuted, size: 16),
                  const SizedBox(width: 8),
                  Text('${l10n.s83_expires_label}: ', style: TextStyle(color: colors.textMuted, fontSize: 12)),
                  Text(l10n.s83_expires_value, style: TextStyle(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Offline invitation package created')));
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s83_create,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard({
    required String title,
    required String body,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
    required OwnKeepMainColorsTheme colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBlue.withValues(alpha: 0.1) : colors.surfacePrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.borderSoft,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 24),
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
            const SizedBox(width: 16),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.primaryBlue : colors.textSecondary,
                  width: 2,
                ),
                color: isSelected ? colors.primaryBlue : Colors.transparent,
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}

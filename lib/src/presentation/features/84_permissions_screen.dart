import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _canView = true;
  bool _canAdd = true;
  bool _canEdit = false;
  bool _canDelete = false;
  bool _canExport = false;

  bool _accessFamily = true;
  bool _accessHealth = true;
  bool _accessProperty = false;
  bool _accessEducation = true;

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
            Text(l10n.s84_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s84_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Member Header
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF4C9A), // Harika color
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('H', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harika', style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(l10n.s84_member_meta, style: TextStyle(color: colors.successGreen, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // General Access
              Text(l10n.s84_general_access, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildToggle(l10n.s84_view, l10n.s84_view_body, _canView, (v) => setState(() => _canView = v), colors),
              _buildToggle(l10n.s84_add, l10n.s84_add_body, _canAdd, (v) => setState(() => _canAdd = v), colors),
              _buildToggle(l10n.s84_edit, l10n.s84_edit_body, _canEdit, (v) => setState(() => _canEdit = v), colors),
              _buildToggle(l10n.s84_delete, l10n.s84_delete_body, _canDelete, (v) => setState(() => _canDelete = v), colors),
              _buildToggle(l10n.s84_export, l10n.s84_export_body, _canExport, (v) => setState(() => _canExport = v), colors),
              const SizedBox(height: 32),

              // Collection Access
              Text(l10n.s84_collection_access, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildCheckbox(l10n.s84_family_documents, _accessFamily, (v) => setState(() => _accessFamily = v!), OwnKeepMainIcons.folder, colors),
              _buildCheckbox(l10n.s84_health_records, _accessHealth, (v) => setState(() => _accessHealth = v!), OwnKeepMainIcons.health, colors),
              _buildCheckbox(l10n.s84_property_papers, _accessProperty, (v) => setState(() => _accessProperty = v!), OwnKeepMainIcons.property, colors),
              _buildCheckbox(l10n.s84_education, _accessEducation, (v) => setState(() => _accessEducation = v!), OwnKeepMainIcons.education, colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(String title, String body, bool value, ValueChanged<bool> onChanged, OwnKeepMainColorsTheme colors) {
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: colors.primaryBlue,
            inactiveTrackColor: colors.surfaceSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged, String iconPath, OwnKeepMainColorsTheme colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: value ? colors.primaryBlue.withValues(alpha: 0.1) : colors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: value ? colors.primaryBlue : colors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: colors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }
}

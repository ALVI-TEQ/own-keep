import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class SmartSuggestionsScreen extends StatefulWidget {
  const SmartSuggestionsScreen({super.key});

  @override
  State<SmartSuggestionsScreen> createState() => _SmartSuggestionsScreenState();
}

class _SmartSuggestionsScreenState extends State<SmartSuggestionsScreen> {
  final Set<int> _selectedIndexes = {0, 1, 2}; // Default selected

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final suggestions = [
      {
        'icon': OwnKeepMainIcons.folder_move,
        'color': colors.primaryBlue,
        'title': l10n.s73_move_title,
        'body': l10n.s73_move_body,
      },
      {
        'icon': OwnKeepMainIcons.tag,
        'color': colors.aiPurple,
        'title': l10n.s73_tag_title,
        'body': l10n.s73_tag_body,
      },
      {
        'icon': OwnKeepMainIcons.reminder,
        'color': colors.dangerRed,
        'title': l10n.s73_expiry_title,
        'body': l10n.s73_expiry_body,
      },
      {
        'icon': OwnKeepMainIcons.copy,
        'color': colors.warningOrange,
        'title': l10n.s73_duplicate_title,
        'body': l10n.s73_duplicate_body,
      },
      {
        'icon': OwnKeepMainIcons.edit,
        'color': colors.successGreen,
        'title': l10n.s73_rename_title,
        'body': l10n.s73_rename_body,
      },
      {
        'icon': OwnKeepMainIcons.archive,
        'color': colors.textSecondary,
        'title': l10n.s73_archive_title,
        'body': l10n.s73_archive_body,
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
            Text(l10n.s73_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s73_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final s = suggestions[index];
            final isSelected = _selectedIndexes.contains(index);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedIndexes.remove(index);
                  } else {
                    _selectedIndexes.add(index);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? (s['color'] as Color).withOpacity(0.1) : colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? (s['color'] as Color) : colors.borderSoft,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(s['icon'] as String, colorFilter: ColorFilter.mode(s['color'] as Color, BlendMode.srcIn), width: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(s['body'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? colors.primaryBlue : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? colors.primaryBlue : colors.borderSoft,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _selectedIndexes.isEmpty
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Applied ${_selectedIndexes.length} suggestions')),
                      );
                      setState(() {
                        _selectedIndexes.clear();
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                disabledBackgroundColor: colors.surfacePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s73_apply_selected,
                style: TextStyle(
                  color: _selectedIndexes.isEmpty ? colors.textMuted : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

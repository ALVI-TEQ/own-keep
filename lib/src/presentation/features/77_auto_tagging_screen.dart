import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class AutoTaggingScreen extends StatefulWidget {
  const AutoTaggingScreen({super.key});

  @override
  State<AutoTaggingScreen> createState() => _AutoTaggingScreenState();
}

class _AutoTaggingScreenState extends State<AutoTaggingScreen> {
  final Set<int> _selectedIndexes = {0, 1, 2, 3, 4}; // All selected by default

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final tags = [
      {'title': l10n.s77_passport, 'tags': ['#identity', '#travel', '#important']},
      {'title': l10n.s77_insurance, 'tags': ['#finance', '#health']},
      {'title': l10n.s77_salary, 'tags': ['#finance', '#work', '#2025']},
      {'title': l10n.s77_licence, 'tags': ['#identity', '#vehicle']},
      {'title': l10n.s77_deed, 'tags': ['#property', '#legal', '#important']},
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
            Text(l10n.s77_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s77_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(OwnKeepMainIcons.ai_sparkle, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s77_ready, style: TextStyle(color: colors.primaryBlue, fontSize: 14, fontWeight: FontWeight.w600)),
                          Text(l10n.s77_ready_body, style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final item = tags[index];
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
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? colors.primaryBlue : colors.borderSoft,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? colors.primaryBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isSelected ? colors.primaryBlue : colors.borderSoft,
                                width: 2,
                              ),
                            ),
                            child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(OwnKeepMainIcons.file_pdf, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 16),
                                    const SizedBox(width: 8),
                                    Text(item['title'] as String, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: (item['tags'] as List<String>).map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: colors.surfaceSecondary,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(tag, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tags applied')));
                      context.pop();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                disabledBackgroundColor: colors.surfacePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s77_apply_all,
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';

class RecoveryVerificationScreen extends StatefulWidget {
  const RecoveryVerificationScreen({super.key});

  @override
  State<RecoveryVerificationScreen> createState() => _RecoveryVerificationScreenState();
}

class _RecoveryVerificationScreenState extends State<RecoveryVerificationScreen> {
  final List<String?> _selectedWords = [null, null, null]; // For slots 3, 6, 10
  
  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    final phrase = [
      l10n.s96_word_1, l10n.s96_word_2, l10n.s96_word_3,
      l10n.s96_word_4, l10n.s96_word_5, l10n.s96_word_6,
      l10n.s96_word_7, l10n.s96_word_8, l10n.s96_word_9,
      l10n.s96_word_10, l10n.s96_word_11, l10n.s96_word_12,
    ];

    final options = [
      l10n.s96_option_garden, l10n.s96_option_mirror,
      l10n.s96_option_ocean, l10n.s96_option_lantern,
      l10n.s96_option_violet, l10n.s96_option_engine,
    ];

    bool isComplete = _selectedWords.every((w) => w != null);

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
            Text(l10n.s96_title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
            Text(l10n.s96_subtitle, style: TextStyle(color: colors.textMuted, fontSize: 12)),
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
              // Info Banner
              Container(
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
                        color: colors.primaryBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(OwnKeepMainIcons.security, colorFilter: ColorFilter.mode(colors.primaryBlue, BlendMode.srcIn), width: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.s96_check, style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(l10n.s96_check_body, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Text(l10n.s96_phrase, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Phrase Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  bool isMissing = (index == 2 || index == 5 || index == 9);
                  String word = phrase[index];
                  
                  if (isMissing) {
                    int slotIdx = index == 2 ? 0 : index == 5 ? 1 : 2;
                    String? selected = _selectedWords[slotIdx];
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedWords[slotIdx] = null);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected != null ? colors.primaryBlue.withValues(alpha: 0.1) : colors.surfacePrimary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected != null ? colors.primaryBlue : colors.borderSoft,
                            style: selected != null ? BorderStyle.solid : BorderStyle.none,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            selected != null ? '${index + 1}. $selected' : '${index + 1}. ___',
                            style: TextStyle(
                              color: selected != null ? colors.primaryBlue : colors.textMuted,
                              fontSize: 14,
                              fontWeight: selected != null ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: colors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}. $word',
                        style: TextStyle(color: colors.textSecondary, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              Text(l10n.s96_choose, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Options Wrap
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: options.map((opt) {
                  bool isUsed = _selectedWords.contains(opt);
                  return GestureDetector(
                    onTap: isUsed ? null : () {
                      int emptySlot = _selectedWords.indexOf(null);
                      if (emptySlot != -1) {
                        setState(() => _selectedWords[emptySlot] = opt);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUsed ? colors.surfaceSecondary : colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isUsed ? Colors.transparent : colors.borderSoft),
                      ),
                      child: Text(
                        opt,
                        style: TextStyle(
                          color: isUsed ? colors.textMuted : colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: isUsed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 40),
              // Verify Banner
              Row(
                children: [
                  Icon(Icons.info_outline, color: colors.textMuted, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.s96_why, style: TextStyle(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(l10n.s96_why_body, style: TextStyle(color: colors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
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
              onPressed: isComplete ? () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recovery Phrase Verified (Local)')));
                context.pop();
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                disabledBackgroundColor: colors.surfaceSecondary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.s96_verify,
                style: TextStyle(
                  color: isComplete ? Colors.white : colors.textMuted,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

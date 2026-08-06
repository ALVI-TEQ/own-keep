import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';

class MergePdfScreen extends StatefulWidget {
  const MergePdfScreen({super.key});

  @override
  State<MergePdfScreen> createState() => _MergePdfScreenState();
}

class _MergePdfScreenState extends State<MergePdfScreen> {
  bool _isMerging = false;
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'titleKey': 's54_passport',
      'metaKey': 's54_passport_meta',
    },
    {
      'id': '2',
      'titleKey': 's54_insurance',
      'metaKey': 's54_insurance_meta',
    },
    {
      'id': '3',
      'titleKey': 's54_bank',
      'metaKey': 's54_bank_meta',
    },
  ];

  String _getLocalizedString(AppLocalizations l10n, String key) {
    switch (key) {
      case 's54_passport': return l10n.s54_passport;
      case 's54_passport_meta': return l10n.s54_passport_meta;
      case 's54_insurance': return l10n.s54_insurance;
      case 's54_insurance_meta': return l10n.s54_insurance_meta;
      case 's54_bank': return l10n.s54_bank;
      case 's54_bank_meta': return l10n.s54_bank_meta;
      case 's54_position_1': return l10n.s54_position_1;
      case 's54_position_2': return l10n.s54_position_2;
      case 's54_position_3': return l10n.s54_position_3;
      default: return key;
    }
  }
  
  String _getPositionString(AppLocalizations l10n, int index) {
    if (index == 0) return l10n.s54_position_1;
    if (index == 1) return l10n.s54_position_2;
    if (index == 2) return l10n.s54_position_3;
    return 'Position ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(OwnKeepMainIcons.back_arrow, colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              l10n.s54_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s54_subtitle,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.s54_arrange,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        l10n.s54_arrange_hint,
                        style: TextStyle(
                          color: colors.textMuted,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                ],
              ),
            ),
          ),
          
          SliverReorderableList(
            itemCount: _items.length,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
            itemBuilder: (context, index) {
              final item = _items[index];
              return Container(
                key: ValueKey(item['id']),
                margin: const EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 4),
                padding: const EdgeInsets.all(OwnKeepSpacing.md),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.borderSoft),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.backgroundTop,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.file_pdf,
                        colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: OwnKeepSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getLocalizedString(l10n, item['titleKey'] as String),
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                _getPositionString(l10n, index),
                                style: TextStyle(
                                  color: colors.primaryBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  '•',
                                  style: TextStyle(color: colors.textMuted, fontSize: 12),
                                ),
                              ),
                              Text(
                                _getLocalizedString(l10n, item['metaKey'] as String),
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ReorderableDragStartListener(
                      index: index,
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.reorder,
                        colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(OwnKeepSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: OwnKeepSpacing.lg),
                  Text(
                    l10n.s54_output_file,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.sm),
                  Container(
                    padding: const EdgeInsets.all(OwnKeepSpacing.md),
                    decoration: BoxDecoration(
                      color: colors.surfacePrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.borderSoft),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colors.backgroundTop,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SvgPicture.asset(
                                OwnKeepMainIcons.file_pdf,
                                colorFilter: ColorFilter.mode(colors.dangerRed, BlendMode.srcIn),
                                width: 20,
                                height: 20,
                              ),
                            ),
                            const SizedBox(width: OwnKeepSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.s54_output_name,
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: SvgPicture.asset(
                                OwnKeepMainIcons.edit,
                                colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
                                width: 20,
                                height: 20,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: OwnKeepSpacing.md, bottom: OwnKeepSpacing.sm),
                          child: Divider(color: colors.borderSoft, height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.s54_estimated,
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              l10n.s54_estimated_value,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(
          left: OwnKeepSpacing.md,
          right: OwnKeepSpacing.md,
          top: OwnKeepSpacing.md,
          bottom: MediaQuery.of(context).padding.bottom + OwnKeepSpacing.md,
        ),
        decoration: BoxDecoration(
          color: colors.navigationBackground,
          border: Border(top: BorderSide(color: colors.borderSoft)),
        ),
        child: ElevatedButton(
          onPressed: _isMerging ? null : () async {
            setState(() {
              _isMerging = true;
            });
            await Future.delayed(const Duration(seconds: 2));
            if (!mounted) return;
            setState(() {
              _isMerging = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('PDFs merged successfully')),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isMerging 
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                l10n.s54_merge,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
        ),
      ),
    );
  }
}

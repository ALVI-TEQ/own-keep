import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class RecoveryVerificationScreen extends StatefulWidget {
  const RecoveryVerificationScreen({super.key});
  @override
  State<RecoveryVerificationScreen> createState() => _RecoveryVerificationScreenState();
}

class _RecoveryVerificationScreenState extends State<RecoveryVerificationScreen> {
  // 12-word phrase - positions 3, 6, 10 are blanks (to fill in)
  final _words = ['copper', 'river', '', 'forest', 'silent', '', 'planet', 'harbor', 'amber', '', 'window', 'stone'];
  final _blanks = {2: null, 5: null, 9: null}; // index -> filled word
  final _choices = ['garden', 'mirror', 'ocean', 'lantern', 'violet', 'engine'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Recovery Verification', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Confirm you saved the phrase', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded, color: OwnKeepColors.primary, size: 20)),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(OwnKeepSpacing.base),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Info banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.4)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Recovery check', style: TextStyle(color: OwnKeepColors.primary, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              SizedBox(height: 6),
              Text(
                'Select the missing words in the correct order. This check happens only on this device.',
                style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, height: 1.5, fontFamily: 'Inter'),
              ),
            ]),
          ),
          SizedBox(height: OwnKeepSpacing.lg),
          Text('Your phrase', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          // 4x3 word grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 2.5,
            ),
            itemCount: 12,
            itemBuilder: (context, i) {
              final isBlank = _blanks.containsKey(i);
              final word = _words[i];
              return Container(
                decoration: BoxDecoration(
                  color: isBlank ? OwnKeepColors.primary.withValues(alpha: 0.08) : OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isBlank ? OwnKeepColors.primary : OwnKeepColors.darkBorder.withValues(alpha: 0.3),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(children: [
                  Text('${i + 1}', style: TextStyle(color: isBlank ? OwnKeepColors.primary : OwnKeepColors.darkTextMuted, fontSize: 10, fontFamily: 'Inter')),
                  SizedBox(width: 4),
                  if (isBlank && _blanks[i] == null)
                    Container(height: 2, width: 28, color: OwnKeepColors.primary)
                  else
                    Expanded(child: Text(
                      isBlank ? (_blanks[i] ?? '') : word,
                      style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                      overflow: TextOverflow.ellipsis,
                    )),
                ]),
              );
            },
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          Text('Choose missing words', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 3.5,
            ),
            itemCount: _choices.length,
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkSurfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text(_choices[i], style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontFamily: 'Inter')),
              );
            },
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: OwnKeepColors.primary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.md)),
            ),
            child: Text('Verify Recovery Phrase', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: OwnKeepColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
              border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Why verify?', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              SizedBox(height: 4),
              Text('A verified phrase prevents permanent data loss', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
            ]),
          ),
        ]),
      ),
    );
  }
}

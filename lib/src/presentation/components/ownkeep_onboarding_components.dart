import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';

import 'package:go_router/go_router.dart';

class OwnKeepOnboardingScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;

  const OwnKeepOnboardingScaffold({
    super.key, 
    required this.child,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.bgPrimary,
      appBar: showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.appColors.textPrimary,
                ),
                onPressed:
                    onBack ??
                    () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: child,
        ),
      ),
    );
  }
}

class OwnKeepOnboardingHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  
  const OwnKeepOnboardingHeader({
    super.key, 
    required this.title, 
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 16),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

class OwnKeepFeatureCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const OwnKeepFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appColors.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.appColors.borderSubtle, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: context.appColors.bgSecondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: icon),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.appColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: context.appColors.textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OwnKeepGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OwnKeepGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryCTA(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppGradients.primaryGlow(context),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class OwnKeepSecondaryAction extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OwnKeepSecondaryAction({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: context.appColors.textSecondary,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      child: Text(text),
    );
  }
}

class OwnKeepSecurityWarning extends StatelessWidget {
  final String text;
  const OwnKeepSecurityWarning({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.appColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: context.appColors.red,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: context.appColors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OwnKeepRecoveryWordGrid extends StatelessWidget {
  final List<String> words;
  final Set<int> selectedIndices;
  final void Function(int index, String word)? onWordTap;

  const OwnKeepRecoveryWordGrid({
    super.key,
    required this.words,
    this.selectedIndices = const {},
    this.onWordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(words.length, (index) {
        final isSelected = selectedIndices.contains(index);
        return GestureDetector(
          onTap: () => onWordTap?.call(index, words[index]),
          child: Container(
            width: 130, // Fixed width for responsive wrap
            height: 48,  // Fixed height
            decoration: BoxDecoration(
              color: isSelected
                  ? context.appColors.brandPurple.withValues(alpha: 0.2)
                  : context.appColors.surfaceSoft,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? context.appColors.brandPurple
                    : context.appColors.borderSubtle,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.appColors.brandPurple
                        : context.appColors.bgSecondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : context.appColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      words[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : context.appColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

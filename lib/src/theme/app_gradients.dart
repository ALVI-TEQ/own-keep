import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static LinearGradient primaryCTA(BuildContext context) {
    final colors = context.appColors;
    return LinearGradient(
      colors: [
        colors.brandPurpleDark,
        colors.brandPurple,
        colors.brandPurpleLight,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  static List<BoxShadow> primaryGlow(BuildContext context) {
    final colors = context.appColors;
    return [
      BoxShadow(
        color: colors.brandPurpleDark.withValues(alpha: 0.28),
        blurRadius: 24,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ];
  }
}

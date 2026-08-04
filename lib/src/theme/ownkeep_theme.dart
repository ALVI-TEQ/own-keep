import 'package:flutter/material.dart';

import 'ownkeep_colors.dart';
import 'ownkeep_radius.dart';
import 'ownkeep_typography.dart';

abstract final class OwnKeepTheme {
  static ThemeData get dark => _build(Brightness.dark);
  static ThemeData get light => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: OwnKeepColors.primary,
      onPrimary: Colors.white,
      secondary: OwnKeepColors.ai,
      onSecondary: Colors.white,
      error: OwnKeepColors.danger,
      onError: Colors.white,
      surface: isDark
          ? OwnKeepColors.darkSurface
          : OwnKeepColors.lightSurface,
      onSurface: isDark
          ? OwnKeepColors.darkTextPrimary
          : OwnKeepColors.lightTextPrimary,
    );

    final textColor = isDark
        ? OwnKeepColors.darkTextPrimary
        : OwnKeepColors.lightTextPrimary;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark
          ? OwnKeepColors.darkBackground
          : OwnKeepColors.lightBackground,
      fontFamily: OwnKeepTypography.fontFamily,
      textTheme: TextTheme(
        displayLarge: OwnKeepTypography.displayLarge.copyWith(color: textColor),
        displayMedium:
            OwnKeepTypography.displayMedium.copyWith(color: textColor),
        titleLarge: OwnKeepTypography.titleLarge.copyWith(color: textColor),
        titleMedium: OwnKeepTypography.titleMedium.copyWith(color: textColor),
        bodyLarge: OwnKeepTypography.bodyLarge.copyWith(color: textColor),
        bodyMedium: OwnKeepTypography.bodyMedium.copyWith(color: textColor),
        labelSmall: OwnKeepTypography.caption.copyWith(
          color: isDark
              ? OwnKeepColors.darkTextSecondary
              : OwnKeepColors.lightTextSecondary,
        ),
      ),
      dividerColor: isDark
          ? OwnKeepColors.darkDivider
          : OwnKeepColors.lightDivider,
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark
            ? OwnKeepColors.darkSurfaceElevated
            : OwnKeepColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
          side: BorderSide(
            color: isDark
                ? OwnKeepColors.darkBorder
                : OwnKeepColors.lightBorder,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? OwnKeepColors.darkSurface
            : OwnKeepColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          borderSide: BorderSide(
            color: isDark
                ? OwnKeepColors.darkBorder
                : OwnKeepColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          borderSide: BorderSide(
            color: isDark
                ? OwnKeepColors.darkBorder
                : OwnKeepColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          borderSide: const BorderSide(
            color: OwnKeepColors.primary,
            width: 2,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: OwnKeepColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OwnKeepRadius.md),
          ),
        ),
      ),
    );
  }
}

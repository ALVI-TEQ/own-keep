import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'ownkeep_main_colors.dart';

class OwnKeepColors {
  // Deep Navy Theme
  static Color backgroundDark = const Color(0xFF060B19);
  static Color surfaceDark = const Color(0xFF0F172A);
  static Color surfaceHighlight = const Color(0xFF1E293B);

  // Gradients and Accents
  static Color primaryBlue = const Color(0xFF4F46E5);
  static Color primaryPurple = const Color(0xFF7C3AED);
  static Color accentGreen = const Color(0xFF10B981);
  static Color accentRed = const Color(0xFFEF4444);
  static Color accentOrange = const Color(0xFFF59E0B);
  static Color accentCyan = const Color(0xFF06B6D4);

  // Text
  static Color textPrimary = Colors.white;
  static Color textSecondary = const Color(0xFF94A3B8);
  static Color divider = const Color(0xFF1E293B);

  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static void applyTheme(String colorName) {
    switch (colorName) {
      case 'green':
        primaryBlue = const Color(0xFF10B981);
        primaryPurple = const Color(0xFF059669);
        break;
      case 'red':
        primaryBlue = const Color(0xFFEF4444);
        primaryPurple = const Color(0xFFDC2626);
        break;
      case 'orange':
        primaryBlue = const Color(0xFFF59E0B);
        primaryPurple = const Color(0xFFD97706);
        break;
      case 'cyan':
        primaryBlue = const Color(0xFF06B6D4);
        primaryPurple = const Color(0xFF0891B2);
        break;
      case 'blue':
      default:
        primaryBlue = const Color(0xFF4F46E5);
        primaryPurple = const Color(0xFF7C3AED);
        break;
    }
    primaryGradient = LinearGradient(
      colors: [primaryBlue, primaryPurple],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

class OwnKeepSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class OwnKeepRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double round = 999.0;
}

class AppTheme {
  static ThemeData get darkTheme => darkThemeFor('blue');
  static ThemeData get lightTheme => lightThemeFor('blue');

  static ({Color primary, Color secondary}) _palette(String name) =>
      switch (name) {
        'cyan' => (
          primary: const Color(0xFF0891B2),
          secondary: const Color(0xFF06B6D4),
        ),
        'green' => (
          primary: const Color(0xFF059669),
          secondary: const Color(0xFF10B981),
        ),
        'orange' => (
          primary: const Color(0xFFD97706),
          secondary: const Color(0xFFF59E0B),
        ),
        _ => (
          primary: const Color(0xFF4F46E5),
          secondary: const Color(0xFF7C3AED),
        ),
      };

  static ThemeData darkThemeFor(String themeName) {
    final base = ThemeData.dark();
    final palette = _palette(themeName);
    final colors = AppColors.defaultDark.copyWith(
      brandPurple: palette.primary,
      brandPurpleDark: palette.primary,
      brandPurpleLight: palette.secondary,
    );
    final mainColors = OwnKeepMainColorsTheme.defaultDark.copyWith(
      primaryBlue: palette.primary,
      aiPurple: palette.secondary,
    );

    return base.copyWith(
      scaffoldBackgroundColor: colors.bgPrimary,
      primaryColor: colors.brandPurple,
      colorScheme: ColorScheme.dark(
        primary: colors.brandPurple,
        secondary: colors.cyan,
        surface: colors.surface,
        error: colors.red,
      ),
      cardColor: colors.surface,
      canvasColor: colors.bgPrimary,
      dividerColor: colors.borderSubtle,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: colors.textPrimary),
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(color: colors.textSecondary, fontSize: 16),
        bodyMedium: TextStyle(color: colors.textSecondary, fontSize: 14),
        bodySmall: TextStyle(color: colors.textSecondary, fontSize: 12),
      ),
      iconTheme: IconThemeData(color: colors.textPrimary),
      extensions: [colors, mainColors],
    );
  }

  static ThemeData lightThemeFor(String themeName) {
    final base = ThemeData.light();
    final palette = _palette(themeName);
    final colors = AppColors.defaultLight.copyWith(
      brandPurple: palette.primary,
      brandPurpleDark: palette.primary,
      brandPurpleLight: palette.secondary,
    );
    final mainColors = OwnKeepMainColorsTheme.defaultLight.copyWith(
      primaryBlue: palette.primary,
      aiPurple: palette.secondary,
    );
    final scheme = ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: Brightness.light,
      surface: colors.surface,
    );
    return base.copyWith(
      scaffoldBackgroundColor: colors.bgPrimary,
      primaryColor: palette.primary,
      colorScheme: scheme,
      cardColor: colors.surface,
      canvasColor: colors.bgPrimary,
      dividerColor: colors.borderSubtle,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colors.textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        base.textTheme,
      ).apply(bodyColor: colors.textPrimary, displayColor: colors.textPrimary),
      iconTheme: IconThemeData(color: colors.textPrimary),
      extensions: [colors, mainColors],
    );
  }
}

import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color bgPrimary;
  final Color bgSecondary;
  final Color surface;
  final Color surfaceSoft;
  final Color borderSubtle;
  final Color borderStrong;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color brandPurple;
  final Color brandPurpleDark;
  final Color brandPurpleLight;
  final Color cyan;
  final Color green;
  final Color red;

  const AppColors({
    required this.bgPrimary,
    required this.bgSecondary,
    required this.surface,
    required this.surfaceSoft,
    required this.borderSubtle,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.brandPurple,
    required this.brandPurpleDark,
    required this.brandPurpleLight,
    required this.cyan,
    required this.green,
    required this.red,
  });

  @override
  AppColors copyWith({
    Color? bgPrimary,
    Color? bgSecondary,
    Color? surface,
    Color? surfaceSoft,
    Color? borderSubtle,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? brandPurple,
    Color? brandPurpleDark,
    Color? brandPurpleLight,
    Color? cyan,
    Color? green,
    Color? red,
  }) {
    return AppColors(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSecondary: bgSecondary ?? this.bgSecondary,
      surface: surface ?? this.surface,
      surfaceSoft: surfaceSoft ?? this.surfaceSoft,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      brandPurple: brandPurple ?? this.brandPurple,
      brandPurpleDark: brandPurpleDark ?? this.brandPurpleDark,
      brandPurpleLight: brandPurpleLight ?? this.brandPurpleLight,
      cyan: cyan ?? this.cyan,
      green: green ?? this.green,
      red: red ?? this.red,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSecondary: Color.lerp(bgSecondary, other.bgSecondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSoft: Color.lerp(surfaceSoft, other.surfaceSoft, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      brandPurple: Color.lerp(brandPurple, other.brandPurple, t)!,
      brandPurpleDark: Color.lerp(brandPurpleDark, other.brandPurpleDark, t)!,
      brandPurpleLight: Color.lerp(
        brandPurpleLight,
        other.brandPurpleLight,
        t,
      )!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      green: Color.lerp(green, other.green, t)!,
      red: Color.lerp(red, other.red, t)!,
    );
  }

  // Dark Theme defaults
  static const AppColors defaultDark = AppColors(
    bgPrimary: Color(0xFF060B19),
    bgSecondary: Color(0xFF0F172A),
    surface: Color(0xFF121C33),
    surfaceSoft: Color(0xFF0F1A32),
    borderSubtle: Color(0xFF1F2B45),
    borderStrong: Color(0xFFF1F1F1),
    textPrimary: Color(0xFFF8F8F9),
    textSecondary: Color(0xFF929EAF),
    textMuted: Color(0xFF6E7787),
    brandPurple: Color(0xFF713CEA),
    brandPurpleDark: Color(0xFF5B42E6),
    brandPurpleLight: Color(0xFF8B46F7),
    cyan: Color(0xFF18C7E6),
    green: Color(0xFF19C48B),
    red: Color(0xFFF24B4B),
  );

  static const AppColors defaultLight = AppColors(
    bgPrimary: Color(0xFFF8FAFC),
    bgSecondary: Color(0xFFF1F5F9),
    surface: Color(0xFFFFFFFF),
    surfaceSoft: Color(0xFFF1F5F9),
    borderSubtle: Color(0xFFE2E8F0),
    borderStrong: Color(0xFF94A3B8),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    brandPurple: Color(0xFF4F46E5),
    brandPurpleDark: Color(0xFF4338CA),
    brandPurpleLight: Color(0xFF6366F1),
    cyan: Color(0xFF0891B2),
    green: Color(0xFF059669),
    red: Color(0xFFDC2626),
  );
}

// Convenience extension for easier access
extension AppColorsExtension on BuildContext {
  AppColors get appColors =>
      Theme.of(this).extension<AppColors>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppColors.defaultDark
          : AppColors.defaultLight);
}

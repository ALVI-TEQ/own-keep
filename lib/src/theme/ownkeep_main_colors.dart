import 'package:flutter/material.dart';

class OwnKeepMainColorsTheme extends ThemeExtension<OwnKeepMainColorsTheme> {
  final Color backgroundTop;
  final Color backgroundBottom;
  final Color navigationBackground;
  final Color searchBackground;

  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceSelected;
  final Color surfacePurple;
  final Color surfaceDanger;

  final Color border;
  final Color borderSoft;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color primaryBlue;
  final Color aiPurple;
  final Color successGreen;
  final Color warningOrange;
  final Color dangerRed;
  final Color healthPink;
  final Color accentCyan;
  final Color favoriteYellow;
  final Color neutralIcon;

  const OwnKeepMainColorsTheme({
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.navigationBackground,
    required this.searchBackground,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceSelected,
    required this.surfacePurple,
    required this.surfaceDanger,
    required this.border,
    required this.borderSoft,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.primaryBlue,
    required this.aiPurple,
    required this.successGreen,
    required this.warningOrange,
    required this.dangerRed,
    required this.healthPink,
    required this.accentCyan,
    required this.favoriteYellow,
    required this.neutralIcon,
  });

  @override
  OwnKeepMainColorsTheme copyWith({
    Color? backgroundTop,
    Color? backgroundBottom,
    Color? navigationBackground,
    Color? searchBackground,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceSelected,
    Color? surfacePurple,
    Color? surfaceDanger,
    Color? border,
    Color? borderSoft,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? primaryBlue,
    Color? aiPurple,
    Color? successGreen,
    Color? warningOrange,
    Color? dangerRed,
    Color? healthPink,
    Color? accentCyan,
    Color? favoriteYellow,
    Color? neutralIcon,
  }) {
    return OwnKeepMainColorsTheme(
      backgroundTop: backgroundTop ?? this.backgroundTop,
      backgroundBottom: backgroundBottom ?? this.backgroundBottom,
      navigationBackground: navigationBackground ?? this.navigationBackground,
      searchBackground: searchBackground ?? this.searchBackground,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceSelected: surfaceSelected ?? this.surfaceSelected,
      surfacePurple: surfacePurple ?? this.surfacePurple,
      surfaceDanger: surfaceDanger ?? this.surfaceDanger,
      border: border ?? this.border,
      borderSoft: borderSoft ?? this.borderSoft,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      primaryBlue: primaryBlue ?? this.primaryBlue,
      aiPurple: aiPurple ?? this.aiPurple,
      successGreen: successGreen ?? this.successGreen,
      warningOrange: warningOrange ?? this.warningOrange,
      dangerRed: dangerRed ?? this.dangerRed,
      healthPink: healthPink ?? this.healthPink,
      accentCyan: accentCyan ?? this.accentCyan,
      favoriteYellow: favoriteYellow ?? this.favoriteYellow,
      neutralIcon: neutralIcon ?? this.neutralIcon,
    );
  }

  @override
  OwnKeepMainColorsTheme lerp(ThemeExtension<OwnKeepMainColorsTheme>? other, double t) {
    if (other is! OwnKeepMainColorsTheme) return this;
    return OwnKeepMainColorsTheme(
      backgroundTop: Color.lerp(backgroundTop, other.backgroundTop, t)!,
      backgroundBottom: Color.lerp(backgroundBottom, other.backgroundBottom, t)!,
      navigationBackground: Color.lerp(navigationBackground, other.navigationBackground, t)!,
      searchBackground: Color.lerp(searchBackground, other.searchBackground, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      surfaceSelected: Color.lerp(surfaceSelected, other.surfaceSelected, t)!,
      surfacePurple: Color.lerp(surfacePurple, other.surfacePurple, t)!,
      surfaceDanger: Color.lerp(surfaceDanger, other.surfaceDanger, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderSoft: Color.lerp(borderSoft, other.borderSoft, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      primaryBlue: Color.lerp(primaryBlue, other.primaryBlue, t)!,
      aiPurple: Color.lerp(aiPurple, other.aiPurple, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      warningOrange: Color.lerp(warningOrange, other.warningOrange, t)!,
      dangerRed: Color.lerp(dangerRed, other.dangerRed, t)!,
      healthPink: Color.lerp(healthPink, other.healthPink, t)!,
      accentCyan: Color.lerp(accentCyan, other.accentCyan, t)!,
      favoriteYellow: Color.lerp(favoriteYellow, other.favoriteYellow, t)!,
      neutralIcon: Color.lerp(neutralIcon, other.neutralIcon, t)!,
    );
  }

  static const defaultDark = OwnKeepMainColorsTheme(
    backgroundTop: Color(0xFF050F20),
    backgroundBottom: Color(0xFF020914),
    navigationBackground: Color(0xFF071120),
    searchBackground: Color(0xFF0D1C31),
    surfacePrimary: Color(0xFF101E34),
    surfaceSecondary: Color(0xFF14253F),
    surfaceSelected: Color(0xFF1D2D4E),
    surfacePurple: Color(0xFF1C183E),
    surfaceDanger: Color(0xFF23101B),
    border: Color(0xFF2B3E5E),
    borderSoft: Color(0xFF1E304E),
    textPrimary: Color(0xFFF5F8FF),
    textSecondary: Color(0xFF97A6C2),
    textMuted: Color(0xFF72819C),
    primaryBlue: Color(0xFF3E62FF),
    aiPurple: Color(0xFF7E48FF),
    successGreen: Color(0xFF27CD8B),
    warningOrange: Color(0xFFFFA63A),
    dangerRed: Color(0xFFFF5C68),
    healthPink: Color(0xFFFF529C),
    accentCyan: Color(0xFF35C6E2),
    favoriteYellow: Color(0xFFFFCA3A),
    neutralIcon: Color(0xFF8E99AF),
  );

  static const defaultLight = OwnKeepMainColorsTheme(
    backgroundTop: Color(0xFFF1F5F9),
    backgroundBottom: Color(0xFFFFFFFF),
    navigationBackground: Color(0xFFF8FAFC),
    searchBackground: Color(0xFFE2E8F0),
    surfacePrimary: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF1F5F9),
    surfaceSelected: Color(0xFFE2E8F0),
    surfacePurple: Color(0xFFF3E8FF),
    surfaceDanger: Color(0xFFFEE2E2),
    border: Color(0xFFCBD5E1),
    borderSoft: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    primaryBlue: Color(0xFF3E62FF),
    aiPurple: Color(0xFF7E48FF),
    successGreen: Color(0xFF10B981),
    warningOrange: Color(0xFFF59E0B),
    dangerRed: Color(0xFFEF4444),
    healthPink: Color(0xFFEC4899),
    accentCyan: Color(0xFF06B6D4),
    favoriteYellow: Color(0xFFF59E0B),
    neutralIcon: Color(0xFF94A3B8),
  );
}

extension OwnKeepMainColorsExtension on BuildContext {
  OwnKeepMainColorsTheme get mainColors => Theme.of(this).extension<OwnKeepMainColorsTheme>() ?? OwnKeepMainColorsTheme.defaultDark;
}

abstract final class OwnKeepMainGradients {
  static const screenBackground = LinearGradient(
    colors: [
      Color(0xFF050F20),
      Color(0xFF020914),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const primaryAction = LinearGradient(
    colors: [
      Color(0xFF7E48FF),
      Color(0xFF3E62FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

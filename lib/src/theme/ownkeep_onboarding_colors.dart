import 'package:flutter/material.dart';

class OwnKeepOnboardingColorsTheme
    extends ThemeExtension<OwnKeepOnboardingColorsTheme> {
  final Color backgroundPrimary;
  final Color backgroundDeep;
  final Color backgroundGlow;

  final Color surfacePrimary;
  final Color surfaceElevated;
  final Color surfaceKeypad;
  final Color surfaceChip;
  final Color surfaceDisabled;

  final Color borderSubtle;
  final Color borderInput;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textDisabled;

  final Color brandPurple;
  final Color brandPurpleBright;
  final Color brandBlue;

  final Color offlineCyan;
  final Color secureGreen;
  final Color foreverRed;
  final Color warningAmber;
  final Color successGreen;

  final Color pinActive;
  final Color pinEmpty;
  final Color toggleTrack;

  const OwnKeepOnboardingColorsTheme({
    required this.backgroundPrimary,
    required this.backgroundDeep,
    required this.backgroundGlow,
    required this.surfacePrimary,
    required this.surfaceElevated,
    required this.surfaceKeypad,
    required this.surfaceChip,
    required this.surfaceDisabled,
    required this.borderSubtle,
    required this.borderInput,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textDisabled,
    required this.brandPurple,
    required this.brandPurpleBright,
    required this.brandBlue,
    required this.offlineCyan,
    required this.secureGreen,
    required this.foreverRed,
    required this.warningAmber,
    required this.successGreen,
    required this.pinActive,
    required this.pinEmpty,
    required this.toggleTrack,
  });

  @override
  OwnKeepOnboardingColorsTheme copyWith({
    Color? backgroundPrimary,
    Color? backgroundDeep,
    Color? backgroundGlow,
    Color? surfacePrimary,
    Color? surfaceElevated,
    Color? surfaceKeypad,
    Color? surfaceChip,
    Color? surfaceDisabled,
    Color? borderSubtle,
    Color? borderInput,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textDisabled,
    Color? brandPurple,
    Color? brandPurpleBright,
    Color? brandBlue,
    Color? offlineCyan,
    Color? secureGreen,
    Color? foreverRed,
    Color? warningAmber,
    Color? successGreen,
    Color? pinActive,
    Color? pinEmpty,
    Color? toggleTrack,
  }) {
    return OwnKeepOnboardingColorsTheme(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundDeep: backgroundDeep ?? this.backgroundDeep,
      backgroundGlow: backgroundGlow ?? this.backgroundGlow,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceKeypad: surfaceKeypad ?? this.surfaceKeypad,
      surfaceChip: surfaceChip ?? this.surfaceChip,
      surfaceDisabled: surfaceDisabled ?? this.surfaceDisabled,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderInput: borderInput ?? this.borderInput,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textDisabled: textDisabled ?? this.textDisabled,
      brandPurple: brandPurple ?? this.brandPurple,
      brandPurpleBright: brandPurpleBright ?? this.brandPurpleBright,
      brandBlue: brandBlue ?? this.brandBlue,
      offlineCyan: offlineCyan ?? this.offlineCyan,
      secureGreen: secureGreen ?? this.secureGreen,
      foreverRed: foreverRed ?? this.foreverRed,
      warningAmber: warningAmber ?? this.warningAmber,
      successGreen: successGreen ?? this.successGreen,
      pinActive: pinActive ?? this.pinActive,
      pinEmpty: pinEmpty ?? this.pinEmpty,
      toggleTrack: toggleTrack ?? this.toggleTrack,
    );
  }

  @override
  OwnKeepOnboardingColorsTheme lerp(
    ThemeExtension<OwnKeepOnboardingColorsTheme>? other,
    double t,
  ) {
    if (other is! OwnKeepOnboardingColorsTheme) return this;
    return OwnKeepOnboardingColorsTheme(
      backgroundPrimary: Color.lerp(
        backgroundPrimary,
        other.backgroundPrimary,
        t,
      )!,
      backgroundDeep: Color.lerp(backgroundDeep, other.backgroundDeep, t)!,
      backgroundGlow: Color.lerp(backgroundGlow, other.backgroundGlow, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceKeypad: Color.lerp(surfaceKeypad, other.surfaceKeypad, t)!,
      surfaceChip: Color.lerp(surfaceChip, other.surfaceChip, t)!,
      surfaceDisabled: Color.lerp(surfaceDisabled, other.surfaceDisabled, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderInput: Color.lerp(borderInput, other.borderInput, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      brandPurple: Color.lerp(brandPurple, other.brandPurple, t)!,
      brandPurpleBright: Color.lerp(
        brandPurpleBright,
        other.brandPurpleBright,
        t,
      )!,
      brandBlue: Color.lerp(brandBlue, other.brandBlue, t)!,
      offlineCyan: Color.lerp(offlineCyan, other.offlineCyan, t)!,
      secureGreen: Color.lerp(secureGreen, other.secureGreen, t)!,
      foreverRed: Color.lerp(foreverRed, other.foreverRed, t)!,
      warningAmber: Color.lerp(warningAmber, other.warningAmber, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      pinActive: Color.lerp(pinActive, other.pinActive, t)!,
      pinEmpty: Color.lerp(pinEmpty, other.pinEmpty, t)!,
      toggleTrack: Color.lerp(toggleTrack, other.toggleTrack, t)!,
    );
  }

  static const defaultDark = OwnKeepOnboardingColorsTheme(
    backgroundPrimary: Color(0xFF010C1C),
    backgroundDeep: Color(0xFF020817),
    backgroundGlow: Color(0xFF071A3A),
    surfacePrimary: Color(0xFF0A192E),
    surfaceElevated: Color(0xFF0F1E36),
    surfaceKeypad: Color(0xFF0F1A32),
    surfaceChip: Color(0xFF0C192E),
    surfaceDisabled: Color(0xFF0A1629),
    borderSubtle: Color(0xFF1B2B45),
    borderInput: Color(0xFFEDEFF5),
    textPrimary: Color(0xFFF8F8F9),
    textSecondary: Color(0xFF98A4B8),
    textMuted: Color(0xFF6E7787),
    textDisabled: Color(0xFF536077),
    brandPurple: Color(0xFF713CEA),
    brandPurpleBright: Color(0xFF8749F5),
    brandBlue: Color(0xFF405EFF),
    offlineCyan: Color(0xFF18C7E6),
    secureGreen: Color(0xFF19C48B),
    foreverRed: Color(0xFFF24B4B),
    warningAmber: Color(0xFFFFB020),
    successGreen: Color(0xFF32C985),
    pinActive: Color(0xFF6550FF),
    pinEmpty: Color(0xFF31405A),
    toggleTrack: Color(0xFF223049),
  );

  static const defaultLight = OwnKeepOnboardingColorsTheme(
    backgroundPrimary: Color(0xFFF8F9FA),
    backgroundDeep: Color(0xFFFFFFFF),
    backgroundGlow: Color(0xFFE2E8F0),
    surfacePrimary: Color(0xFFF1F5F9),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceKeypad: Color(0xFFF8FAFC),
    surfaceChip: Color(0xFFE2E8F0),
    surfaceDisabled: Color(0xFFE2E8F0),
    borderSubtle: Color(0xFFCBD5E1),
    borderInput: Color(0xFF94A3B8),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    textDisabled: Color(0xFF94A3B8),
    brandPurple: Color(0xFF713CEA),
    brandPurpleBright: Color(0xFF8749F5),
    brandBlue: Color(0xFF405EFF),
    offlineCyan: Color(0xFF0E7490),
    secureGreen: Color(0xFF059669),
    foreverRed: Color(0xFFDC2626),
    warningAmber: Color(0xFFD97706),
    successGreen: Color(0xFF10B981),
    pinActive: Color(0xFF6550FF),
    pinEmpty: Color(0xFFCBD5E1),
    toggleTrack: Color(0xFFE2E8F0),
  );
}

extension OwnKeepOnboardingColorsExtension on BuildContext {
  OwnKeepOnboardingColorsTheme get onboardingColors =>
      Theme.of(this).extension<OwnKeepOnboardingColorsTheme>() ??
      OwnKeepOnboardingColorsTheme.defaultDark;
}

abstract final class OwnKeepOnboardingGradients {
  static const primaryButton = LinearGradient(
    colors: [Color(0xFF3C38E7), Color(0xFF4630E0), Color(0xFF4E2BD5)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

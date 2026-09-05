import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_color.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLarge,
    required this.displaySmall,
    required this.headingH1,
    required this.headingH2,
    required this.headingH3,
    required this.headingH4,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.bodyEmphasis,
    required this.bodyLink,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.caption,
  });

  final TextStyle displayLarge;
  final TextStyle displaySmall;
  final TextStyle headingH1;
  final TextStyle headingH2;
  final TextStyle headingH3;
  final TextStyle headingH4;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle bodyEmphasis;
  final TextStyle bodyLink;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle caption;

  static const String fontFamily = 'Inter';

  static const _baseLightColor = AppPrimitives.gray900;
  static const _baseDarkColor = AppPrimitives.gray50;

  // ---------------------------------------------------------------------------
  // 15 Design System Typography Tokens for Light Mode
  // ---------------------------------------------------------------------------

  static const light = AppTypography(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 60,
      height: 72 / 60,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseLightColor,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 48,
      height: 58 / 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseLightColor,
    ),
    headingH1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      height: 43 / 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseLightColor,
    ),
    headingH2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 30,
      height: 41 / 30,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    headingH3: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    headingH4: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      height: 30 / 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      height: 27 / 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 21 / 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    bodyEmphasis: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    bodyLink: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 22 / 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseLightColor,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 19 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseLightColor,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseLightColor,
    ),
    caption: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      height: 17 / 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseLightColor,
    ),
  );

  // ---------------------------------------------------------------------------
  // 15 Design System Typography Tokens for Dark Mode
  // ---------------------------------------------------------------------------

  static const dark = AppTypography(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 60,
      height: 72 / 60,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseDarkColor,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 48,
      height: 58 / 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseDarkColor,
    ),
    headingH1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      height: 43 / 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _baseDarkColor,
    ),
    headingH2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 30,
      height: 41 / 30,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    headingH3: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    headingH4: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      height: 30 / 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      height: 27 / 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 21 / 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    bodyEmphasis: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    bodyLink: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 22 / 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseDarkColor,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 19 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseDarkColor,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _baseDarkColor,
    ),
    caption: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      height: 17 / 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: _baseDarkColor,
    ),
  );

  @override
  AppTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displaySmall,
    TextStyle? headingH1,
    TextStyle? headingH2,
    TextStyle? headingH3,
    TextStyle? headingH4,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? bodyEmphasis,
    TextStyle? bodyLink,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? caption,
  }) {
    return AppTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displaySmall: displaySmall ?? this.displaySmall,
      headingH1: headingH1 ?? this.headingH1,
      headingH2: headingH2 ?? this.headingH2,
      headingH3: headingH3 ?? this.headingH3,
      headingH4: headingH4 ?? this.headingH4,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyEmphasis: bodyEmphasis ?? this.bodyEmphasis,
      bodyLink: bodyLink ?? this.bodyLink,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      caption: caption ?? this.caption,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headingH1: TextStyle.lerp(headingH1, other.headingH1, t)!,
      headingH2: TextStyle.lerp(headingH2, other.headingH2, t)!,
      headingH3: TextStyle.lerp(headingH3, other.headingH3, t)!,
      headingH4: TextStyle.lerp(headingH4, other.headingH4, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      bodyEmphasis: TextStyle.lerp(bodyEmphasis, other.bodyEmphasis, t)!,
      bodyLink: TextStyle.lerp(bodyLink, other.bodyLink, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displaySmall,
      displaySmall: headingH1,
      headlineLarge: headingH1,
      headlineMedium: headingH2,
      headlineSmall: headingH3,
      titleLarge: headingH4,
      titleMedium: labelLarge,
      titleSmall: labelMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/theme_constant.dart';
import 'package:mobileapp/core/theme/app_color_scheme.dart';

abstract class AppTypography {
  const AppTypography._();

  static TextStyle get defaultLightStyle => TextStyle(
    fontFamily: ThemeConstant.fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColorScheme.light.onSurface,
  );

  static TextStyle get defaultDarkStyle => TextStyle(
    fontFamily: ThemeConstant.fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColorScheme.dark.onSurface,
  );

  static TextTheme get light => TextTheme(
    displayLarge: defaultLightStyle.withSize(52),
    displayMedium: defaultLightStyle.withSize(40),
    displaySmall: defaultLightStyle.withSize(32),
    headlineLarge: defaultLightStyle.withSize(32),
    headlineMedium: defaultLightStyle.withSize(28),
    headlineSmall: defaultLightStyle.withSize(24),
    titleLarge: defaultLightStyle.withSize(20),
    titleMedium: defaultLightStyle.withSize(14),
    titleSmall: defaultLightStyle.withSize(12),
    bodyLarge: defaultLightStyle.withSize(14),
    bodyMedium: defaultLightStyle.withSize(12),
    bodySmall: defaultLightStyle.withSize(10),
    labelLarge: defaultLightStyle.withSize(14),
    labelMedium: defaultLightStyle.withSize(12),
    labelSmall: defaultLightStyle.withSize(10),
  );

  static TextTheme get dark => TextTheme(
    displayLarge: defaultDarkStyle.withSize(52),
    displayMedium: defaultDarkStyle.withSize(40),
    displaySmall: defaultDarkStyle.withSize(32),
    headlineLarge: defaultDarkStyle.withSize(32),
    headlineMedium: defaultDarkStyle.withSize(28),
    headlineSmall: defaultDarkStyle.withSize(24),
    titleLarge: defaultDarkStyle.withSize(20),
    titleMedium: defaultDarkStyle.withSize(14),
    titleSmall: defaultDarkStyle.withSize(12),
    bodyLarge: defaultDarkStyle.withSize(14),
    bodyMedium: defaultDarkStyle.withSize(12),
    bodySmall: defaultDarkStyle.withSize(10),
    labelLarge: defaultDarkStyle.withSize(14),
    labelMedium: defaultDarkStyle.withSize(12),
    labelSmall: defaultDarkStyle.withSize(10),
  );
}

extension TextStyleX on TextStyle {
  TextStyle get regular => withFontWeight(FontWeight.w400);
  TextStyle get medium => withFontWeight(FontWeight.w500);
  TextStyle get bold => withFontWeight(FontWeight.w700);

  TextStyle withSize(double size) => withFontSize(size);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);

  TextStyle withFontSize(double fontSize) => copyWith(fontSize: fontSize);
}

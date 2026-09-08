import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_typography.dart';

export 'package:mobileapp/core/theme/app_color.dart';
export 'package:mobileapp/core/theme/app_typography.dart';

/// Helper extension: `context.colors.background.brand`
extension AppColorsX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}

/// Helper extension: `context.typography.headingH1`
extension AppTypographyBuildContextX on BuildContext {
  AppTypography get typography =>
      Theme.of(this).extension<AppTypography>() ?? AppTypography.light;
}

extension TextStyleX on TextStyle {
  TextStyle get regular => withWeight(FontWeight.w400);
  TextStyle get medium => withWeight(FontWeight.w500);
  TextStyle get semiBold => withWeight(FontWeight.w600);
  TextStyle get bold => withWeight(FontWeight.w700);

  TextStyle withSize(double newSize) => copyWith(fontSize: newSize);
  TextStyle withColor(Color newColor) => copyWith(color: newColor);
  TextStyle withWeight(FontWeight newWeight) => copyWith(fontWeight: newWeight);
}

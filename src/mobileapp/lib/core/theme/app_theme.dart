import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_color_scheme.dart';
import 'package:mobileapp/core/theme/app_typography.dart';

abstract class AppTheme {
  static final light = ThemeData(
    fontFamily: AppTypography.fontFamily,
    colorScheme: AppColorScheme.light,
    textTheme: AppTypography.light.toTextTheme(),
    scaffoldBackgroundColor: AppColors.light.background.primary,
    extensions: const [
      AppColors.light,
      AppTypography.light,
    ],
  );

  static final dark = ThemeData(
    fontFamily: AppTypography.fontFamily,
    colorScheme: AppColorScheme.dark,
    textTheme: AppTypography.dark.toTextTheme(),
    scaffoldBackgroundColor: AppColors.dark.background.primary,
    extensions: const [
      AppColors.dark,
      AppTypography.dark,
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/theme_constant.dart';
import 'package:mobileapp/core/theme/app_color_scheme.dart';

abstract class AppTheme {
  static final light = ThemeData(
    fontFamily: ThemeConstant.fontFamily,
    colorScheme: AppColorScheme.light,
  );

  static final dark = ThemeData(
    fontFamily: ThemeConstant.fontFamily,
    colorScheme: AppColorScheme.dark,
  );
}

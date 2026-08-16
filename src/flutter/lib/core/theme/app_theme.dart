import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/theme_constant.dart';
import 'package:flutter_frontend/core/theme/app_color_scheme.dart';

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

import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_color.dart';

abstract class AppGradients {
  const AppGradients._();

  /// Gradient/Brand
  static const LinearGradient brand = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppPrimitives.blue500,
      AppPrimitives.violet500,
    ],
  );

  /// Gradient/Brand-Subtle
  static const LinearGradient brandSubtle = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppPrimitives.blue50,
      AppPrimitives.violet50,
    ],
  );

  /// Gradient/Overlay-Scrim
  static const LinearGradient overlayScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x00000000),
      Color(0x99000000),
    ],
  );
}

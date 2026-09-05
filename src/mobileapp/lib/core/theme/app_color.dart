import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// 1. PRIMITIVES — Color / Primitives
/// ---------------------------------------------------------------------------
class AppPrimitives {
  AppPrimitives._();

  // Blue
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue200 = Color(0xFFBFDBFE);
  static const blue300 = Color(0xFF93C5FD);
  static const blue400 = Color(0xFF60A5FA);
  static const blue500 = Color(0xFF3B82F6);
  static const blue600 = Color(0xFF2563EB);
  static const blue700 = Color(0xFF1D4ED8);
  static const blue800 = Color(0xFF1E40AF);
  static const blue900 = Color(0xFF1E3A8A);

  // Violet
  static const violet50 = Color(0xFFF5F3FF);
  static const violet100 = Color(0xFFEDE9FE);
  static const violet200 = Color(0xFFDDD6FE);
  static const violet300 = Color(0xFFC4B5FD);
  static const violet400 = Color(0xFFA78BFA);
  static const violet500 = Color(0xFF8B5CF6);
  static const violet600 = Color(0xFF7C3AED);
  static const violet700 = Color(0xFF6D28D9);
  static const violet800 = Color(0xFF5B21B6);
  static const violet900 = Color(0xFF4C1D95);

  // Gray
  static const gray50 = Color(0xFFF8FAFC);
  static const gray100 = Color(0xFFF1F5F9);
  static const gray200 = Color(0xFFE2E8F0);
  static const gray300 = Color(0xFFCBD5E1);
  static const gray400 = Color(0xFF94A3B8);
  static const gray500 = Color(0xFF64748B);
  static const gray600 = Color(0xFF475569);
  static const gray700 = Color(0xFF334155);
  static const gray800 = Color(0xFF1E293B);
  static const gray900 = Color(0xFF0F172A);

  // Green
  static const green50 = Color(0xFFF0FDF4);
  static const green100 = Color(0xFFDCFCE7);
  static const green200 = Color(0xFFBBF7D0);
  static const green300 = Color(0xFF86EFAC);
  static const green400 = Color(0xFF4ADE80);
  static const green500 = Color(0xFF22C55E);
  static const green600 = Color(0xFF16A34A);
  static const green700 = Color(0xFF15803D);
  static const green800 = Color(0xFF166534);
  static const green900 = Color(0xFF14532D);

  // Amber
  static const amber50 = Color(0xFFFFFBEB);
  static const amber100 = Color(0xFFFEF3C7);
  static const amber200 = Color(0xFFFDE68A);
  static const amber300 = Color(0xFFFCD34D);
  static const amber400 = Color(0xFFFBBF24);
  static const amber500 = Color(0xFFF59E0B);
  static const amber600 = Color(0xFFD97706);
  static const amber700 = Color(0xFFB45309);
  static const amber800 = Color(0xFF92400E);
  static const amber900 = Color(0xFF78350F);

  // Red
  static const red50 = Color(0xFFFEF2F2);
  static const red100 = Color(0xFFFEE2E2);
  static const red200 = Color(0xFFFECACA);
  static const red300 = Color(0xFFFCA5A5);
  static const red400 = Color(0xFFF87171);
  static const red500 = Color(0xFFEF4444);
  static const red600 = Color(0xFFDC2626);
  static const red700 = Color(0xFFB91C1C);
  static const red800 = Color(0xFF991B1B);
  static const red900 = Color(0xFF7F1D1D);

  // Cyan
  static const cyan50 = Color(0xFFECFEFF);
  static const cyan100 = Color(0xFFCFFAFE);
  static const cyan200 = Color(0xFFA5F3FC);
  static const cyan300 = Color(0xFF67E8F9);
  static const cyan400 = Color(0xFF22D3EE);
  static const cyan500 = Color(0xFF06B6D4);
  static const cyan600 = Color(0xFF0891B2);
  static const cyan700 = Color(0xFF0E7490);
  static const cyan800 = Color(0xFF155E75);
  static const cyan900 = Color(0xFF164E63);

  // Base & Alpha
  static const white1000 = Color(0xFFFFFFFF);
  static const black1000 = Color(0xFF000000);
  static const blackAlpha8 = Color(0x14000000); // 8% opacity
  static const blackAlpha16 = Color(0x29000000); // 16% opacity
  static const blackAlpha24 = Color(0x3D000000); // 24% opacity
  static const blackAlpha40 = Color(0x66000000); // 40% opacity
  static const blackAlpha60 = Color(0x99000000); // 60% opacity
  static const whiteAlpha8 = Color(0x14FFFFFF); // 8% opacity
  static const whiteAlpha16 = Color(0x29FFFFFF); // 16% opacity
  static const blueAlpha12 = Color(0x1F3B82F6); // 12% opacity
}

/// ---------------------------------------------------------------------------
/// 2. SEMANTIC TOKENS
/// ---------------------------------------------------------------------------

@immutable
class AppBackgroundColors {
  const AppBackgroundColors({
    required this.primary,
    required this.secondary,
    required this.secondaryHover,
    required this.tertiary,
    required this.disabled,
    required this.brand,
    required this.brandHover,
    required this.brandPressed,
    required this.brandSubtle,
    required this.success,
    required this.successHover,
    required this.successPressed,
    required this.successSubtle,
    required this.warning,
    required this.warningHover,
    required this.warningPressed,
    required this.warningSubtle,
    required this.error,
    required this.errorHover,
    required this.errorPressed,
    required this.errorSubtle,
    required this.info,
    required this.infoHover,
    required this.infoPressed,
    required this.infoSubtle,
    required this.selected,
    required this.inverse,
  });

  final Color primary, secondary, secondaryHover, tertiary, disabled;
  final Color brand, brandHover, brandPressed, brandSubtle;
  final Color success, successHover, successPressed, successSubtle;
  final Color warning, warningHover, warningPressed, warningSubtle;
  final Color error, errorHover, errorPressed, errorSubtle;
  final Color info, infoHover, infoPressed, infoSubtle;
  final Color selected, inverse;

  static const light = AppBackgroundColors(
    primary: AppPrimitives.white1000,
    secondary: AppPrimitives.gray50,
    secondaryHover: AppPrimitives.gray100,
    tertiary: AppPrimitives.gray100,
    disabled: AppPrimitives.gray100,
    brand: AppPrimitives.blue500,
    brandHover: AppPrimitives.blue600,
    brandPressed: AppPrimitives.blue700,
    brandSubtle: AppPrimitives.blue50,
    success: AppPrimitives.green500,
    successHover: AppPrimitives.green600,
    successPressed: AppPrimitives.green700,
    successSubtle: AppPrimitives.green50,
    warning: AppPrimitives.amber500,
    warningHover: AppPrimitives.amber600,
    warningPressed: AppPrimitives.amber700,
    warningSubtle: AppPrimitives.amber50,
    error: AppPrimitives.red500,
    errorHover: AppPrimitives.red600,
    errorPressed: AppPrimitives.red700,
    errorSubtle: AppPrimitives.red50,
    info: AppPrimitives.cyan500,
    infoHover: AppPrimitives.cyan600,
    infoPressed: AppPrimitives.cyan700,
    infoSubtle: AppPrimitives.cyan50,
    selected: AppPrimitives.blue100,
    inverse: AppPrimitives.gray900,
  );

  static const dark = AppBackgroundColors(
    primary: AppPrimitives.gray900,
    secondary: AppPrimitives.gray800,
    secondaryHover: AppPrimitives.gray700,
    tertiary: AppPrimitives.gray700,
    disabled: AppPrimitives.gray800,
    brand: AppPrimitives.blue500,
    brandHover: AppPrimitives.blue400,
    brandPressed: AppPrimitives.blue300,
    brandSubtle: AppPrimitives.blue900,
    success: AppPrimitives.green500,
    successHover: AppPrimitives.green400,
    successPressed: AppPrimitives.green300,
    successSubtle: AppPrimitives.green900,
    warning: AppPrimitives.amber500,
    warningHover: AppPrimitives.amber400,
    warningPressed: AppPrimitives.amber300,
    warningSubtle: AppPrimitives.amber900,
    error: AppPrimitives.red500,
    errorHover: AppPrimitives.red400,
    errorPressed: AppPrimitives.red300,
    errorSubtle: AppPrimitives.red900,
    info: AppPrimitives.cyan500,
    infoHover: AppPrimitives.cyan400,
    infoPressed: AppPrimitives.cyan300,
    infoSubtle: AppPrimitives.cyan900,
    selected: AppPrimitives.blue800,
    inverse: AppPrimitives.white1000,
  );

  AppBackgroundColors lerp(AppBackgroundColors o, double t) =>
      AppBackgroundColors(
        primary: Color.lerp(primary, o.primary, t)!,
        secondary: Color.lerp(secondary, o.secondary, t)!,
        secondaryHover: Color.lerp(secondaryHover, o.secondaryHover, t)!,
        tertiary: Color.lerp(tertiary, o.tertiary, t)!,
        disabled: Color.lerp(disabled, o.disabled, t)!,
        brand: Color.lerp(brand, o.brand, t)!,
        brandHover: Color.lerp(brandHover, o.brandHover, t)!,
        brandPressed: Color.lerp(brandPressed, o.brandPressed, t)!,
        brandSubtle: Color.lerp(brandSubtle, o.brandSubtle, t)!,
        success: Color.lerp(success, o.success, t)!,
        successHover: Color.lerp(successHover, o.successHover, t)!,
        successPressed: Color.lerp(successPressed, o.successPressed, t)!,
        successSubtle: Color.lerp(successSubtle, o.successSubtle, t)!,
        warning: Color.lerp(warning, o.warning, t)!,
        warningHover: Color.lerp(warningHover, o.warningHover, t)!,
        warningPressed: Color.lerp(warningPressed, o.warningPressed, t)!,
        warningSubtle: Color.lerp(warningSubtle, o.warningSubtle, t)!,
        error: Color.lerp(error, o.error, t)!,
        errorHover: Color.lerp(errorHover, o.errorHover, t)!,
        errorPressed: Color.lerp(errorPressed, o.errorPressed, t)!,
        errorSubtle: Color.lerp(errorSubtle, o.errorSubtle, t)!,
        info: Color.lerp(info, o.info, t)!,
        infoHover: Color.lerp(infoHover, o.infoHover, t)!,
        infoPressed: Color.lerp(infoPressed, o.infoPressed, t)!,
        infoSubtle: Color.lerp(infoSubtle, o.infoSubtle, t)!,
        selected: Color.lerp(selected, o.selected, t)!,
        inverse: Color.lerp(inverse, o.inverse, t)!,
      );
}

@immutable
class AppTextColors {
  const AppTextColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.disabled,
    required this.onBrand,
    required this.brand,
    required this.placeholder,
    required this.inverse,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color primary, secondary, tertiary, disabled;
  final Color onBrand, brand, placeholder, inverse;
  final Color success, warning, error, info;

  static const light = AppTextColors(
    primary: AppPrimitives.gray900,
    secondary: AppPrimitives.gray600,
    tertiary: AppPrimitives.gray400,
    disabled: AppPrimitives.gray300,
    onBrand: AppPrimitives.white1000,
    brand: AppPrimitives.blue600,
    placeholder: AppPrimitives.gray400,
    inverse: AppPrimitives.white1000,
    success: AppPrimitives.green700,
    warning: AppPrimitives.amber700,
    error: AppPrimitives.red700,
    info: AppPrimitives.cyan700,
  );

  static const dark = AppTextColors(
    primary: AppPrimitives.white1000,
    secondary: AppPrimitives.gray300,
    tertiary: AppPrimitives.gray500,
    disabled: AppPrimitives.gray600,
    onBrand: AppPrimitives.white1000,
    brand: AppPrimitives.blue400,
    placeholder: AppPrimitives.gray500,
    inverse: AppPrimitives.gray900,
    success: AppPrimitives.green400,
    warning: AppPrimitives.amber400,
    error: AppPrimitives.red400,
    info: AppPrimitives.cyan400,
  );

  AppTextColors lerp(AppTextColors o, double t) => AppTextColors(
    primary: Color.lerp(primary, o.primary, t)!,
    secondary: Color.lerp(secondary, o.secondary, t)!,
    tertiary: Color.lerp(tertiary, o.tertiary, t)!,
    disabled: Color.lerp(disabled, o.disabled, t)!,
    onBrand: Color.lerp(onBrand, o.onBrand, t)!,
    brand: Color.lerp(brand, o.brand, t)!,
    placeholder: Color.lerp(placeholder, o.placeholder, t)!,
    inverse: Color.lerp(inverse, o.inverse, t)!,
    success: Color.lerp(success, o.success, t)!,
    warning: Color.lerp(warning, o.warning, t)!,
    error: Color.lerp(error, o.error, t)!,
    info: Color.lerp(info, o.info, t)!,
  );
}

@immutable
class AppBorderColors {
  const AppBorderColors({
    required this.defaultColor,
    required this.subtle,
    required this.strong,
    required this.disabled,
    required this.brand,
    required this.focus,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color defaultColor, subtle, strong, disabled;
  final Color brand, focus, success, warning, error, info;

  static const light = AppBorderColors(
    defaultColor: AppPrimitives.gray200,
    subtle: AppPrimitives.gray100,
    strong: AppPrimitives.gray300,
    disabled: AppPrimitives.gray200,
    brand: AppPrimitives.blue500,
    focus: AppPrimitives.blue500,
    success: AppPrimitives.green500,
    warning: AppPrimitives.amber500,
    error: AppPrimitives.red500,
    info: AppPrimitives.cyan500,
  );

  static const dark = AppBorderColors(
    defaultColor: AppPrimitives.gray700,
    subtle: AppPrimitives.gray800,
    strong: AppPrimitives.gray600,
    disabled: AppPrimitives.gray700,
    brand: AppPrimitives.blue400,
    focus: AppPrimitives.blue400,
    success: AppPrimitives.green400,
    warning: AppPrimitives.amber400,
    error: AppPrimitives.red400,
    info: AppPrimitives.cyan400,
  );

  AppBorderColors lerp(AppBorderColors o, double t) => AppBorderColors(
    defaultColor: Color.lerp(defaultColor, o.defaultColor, t)!,
    subtle: Color.lerp(subtle, o.subtle, t)!,
    strong: Color.lerp(strong, o.strong, t)!,
    disabled: Color.lerp(disabled, o.disabled, t)!,
    brand: Color.lerp(brand, o.brand, t)!,
    focus: Color.lerp(focus, o.focus, t)!,
    success: Color.lerp(success, o.success, t)!,
    warning: Color.lerp(warning, o.warning, t)!,
    error: Color.lerp(error, o.error, t)!,
    info: Color.lerp(info, o.info, t)!,
  );
}

@immutable
class AppIconColors {
  const AppIconColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.disabled,
    required this.onBrand,
    required this.brand,
    required this.inverse,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color primary, secondary, tertiary, disabled;
  final Color onBrand, brand, inverse;
  final Color success, warning, error, info;

  static const light = AppIconColors(
    primary: AppPrimitives.gray700,
    secondary: AppPrimitives.gray400,
    tertiary: AppPrimitives.gray400,
    disabled: AppPrimitives.gray300,
    onBrand: AppPrimitives.white1000,
    brand: AppPrimitives.blue600,
    inverse: AppPrimitives.white1000,
    success: AppPrimitives.green600,
    warning: AppPrimitives.amber600,
    error: AppPrimitives.red600,
    info: AppPrimitives.cyan600,
  );

  static const dark = AppIconColors(
    primary: AppPrimitives.gray200,
    secondary: AppPrimitives.gray500,
    tertiary: AppPrimitives.gray500,
    disabled: AppPrimitives.gray600,
    onBrand: AppPrimitives.white1000,
    brand: AppPrimitives.blue400,
    inverse: AppPrimitives.gray900,
    success: AppPrimitives.green400,
    warning: AppPrimitives.amber400,
    error: AppPrimitives.red400,
    info: AppPrimitives.cyan400,
  );

  AppIconColors lerp(AppIconColors o, double t) => AppIconColors(
    primary: Color.lerp(primary, o.primary, t)!,
    secondary: Color.lerp(secondary, o.secondary, t)!,
    tertiary: Color.lerp(tertiary, o.tertiary, t)!,
    disabled: Color.lerp(disabled, o.disabled, t)!,
    onBrand: Color.lerp(onBrand, o.onBrand, t)!,
    brand: Color.lerp(brand, o.brand, t)!,
    inverse: Color.lerp(inverse, o.inverse, t)!,
    success: Color.lerp(success, o.success, t)!,
    warning: Color.lerp(warning, o.warning, t)!,
    error: Color.lerp(error, o.error, t)!,
    info: Color.lerp(info, o.info, t)!,
  );
}

@immutable
class AppOverlayColors {
  const AppOverlayColors({
    required this.scrim,
    required this.backdrop,
    required this.hover,
    required this.pressed,
    required this.selected,
  });

  final Color scrim, backdrop, hover, pressed, selected;

  static const light = AppOverlayColors(
    scrim: AppPrimitives.blackAlpha60,
    backdrop: AppPrimitives.blackAlpha40,
    hover: AppPrimitives.blackAlpha8,
    pressed: AppPrimitives.blackAlpha16,
    selected: AppPrimitives.blueAlpha12,
  );

  static const dark = AppOverlayColors(
    scrim: AppPrimitives.blackAlpha60,
    backdrop: AppPrimitives.blackAlpha60,
    hover: AppPrimitives.whiteAlpha8,
    pressed: AppPrimitives.whiteAlpha16,
    selected: AppPrimitives.blueAlpha12,
  );

  AppOverlayColors lerp(AppOverlayColors o, double t) => AppOverlayColors(
    scrim: Color.lerp(scrim, o.scrim, t)!,
    backdrop: Color.lerp(backdrop, o.backdrop, t)!,
    hover: Color.lerp(hover, o.hover, t)!,
    pressed: Color.lerp(pressed, o.pressed, t)!,
    selected: Color.lerp(selected, o.selected, t)!,
  );
}

/// ---------------------------------------------------------------------------
/// 3. THEME EXTENSION
/// ---------------------------------------------------------------------------
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.text,
    required this.border,
    required this.icon,
    required this.overlay,
  });

  final AppBackgroundColors background;
  final AppTextColors text;
  final AppBorderColors border;
  final AppIconColors icon;
  final AppOverlayColors overlay;

  static const light = AppColors(
    background: AppBackgroundColors.light,
    text: AppTextColors.light,
    border: AppBorderColors.light,
    icon: AppIconColors.light,
    overlay: AppOverlayColors.light,
  );

  static const dark = AppColors(
    background: AppBackgroundColors.dark,
    text: AppTextColors.dark,
    border: AppBorderColors.dark,
    icon: AppIconColors.dark,
    overlay: AppOverlayColors.dark,
  );

  @override
  AppColors copyWith({
    AppBackgroundColors? background,
    AppTextColors? text,
    AppBorderColors? border,
    AppIconColors? icon,
    AppOverlayColors? overlay,
  }) {
    return AppColors(
      background: background ?? this.background,
      text: text ?? this.text,
      border: border ?? this.border,
      icon: icon ?? this.icon,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: background.lerp(other.background, t),
      text: text.lerp(other.text, t),
      border: border.lerp(other.border, t),
      icon: icon.lerp(other.icon, t),
      overlay: overlay.lerp(other.overlay, t),
    );
  }
}

/// Helper extension: `context.colors.background.brand`
extension AppColorsX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}

import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// 1. PRIMITIVES — Color / Primitives
/// ---------------------------------------------------------------------------
class AppPrimitives {
  AppPrimitives._();

  // Blue
  static const blue50 = Color(0xFFE8F0FE);
  static const blue100 = Color(0xFFC9DDFC);
  static const blue200 = Color(0xFFA0C4FA);
  static const blue300 = Color(0xFF74A8F7);
  static const blue400 = Color(0xFF4A8CF0);
  static const blue500 = Color(0xFF2E6FE0);
  static const blue600 = Color(0xFF2257C4);
  static const blue700 = Color(0xFF1B44A0);
  static const blue900 = Color(0xFF122C68);

  // Grey
  static const grey50 = Color(0xFFF7F8FA);
  static const grey100 = Color(0xFFE7E9EE);
  static const grey200 = Color(0xFFD3D7DE);
  static const grey300 = Color(0xFFB7BDC8);
  static const grey500 = Color(0xFF6E7684);
  static const grey600 = Color(0xFF565D6A);
  static const grey700 = Color(0xFF3F4451);
  static const grey800 = Color(0xFF2A2E38);
  static const grey900 = Color(
    0xFFFFFFFF,
  ); // trong ảnh swatch này gần như trắng

  // Green
  static const green50 = Color(0xFFE7F8EE);
  static const green100 = Color(0xFFC5EFD4);
  static const green200 = Color(0xFF97E0AF);
  static const green300 = Color(0xFF65CC85);
  static const green400 = Color(0xFF3DB868);
  static const green500 = Color(0xFF29A354);
  static const green600 = Color(0xFF1F8843);
  static const green700 = Color(0xFF196E37);
  static const green800 = Color(0xFF14562C);

  // Amber
  static const amber50 = Color(0xFFFFF7E0);
  static const amber100 = Color(0xFFFFE9B3);
  static const amber200 = Color(0xFFFFD675);
  static const amber300 = Color(0xFFFFC13D);
  static const amber400 = Color(0xFFF7A81E);
  static const amber500 = Color(0xFFE38F0F);
  static const amber600 = Color(0xFFC1740A);
  static const amber700 = Color(0xFF9C5C08);
  static const amber800 = Color(0xFF7A4707);

  // Red
  static const red50 = Color(0xFFFDECEC);
  static const red100 = Color(0xFFF9CFCF);
  static const red200 = Color(0xFFF2A6A6);
  static const red300 = Color(0xFFEA7B7B);
  static const red400 = Color(0xFFE05555);
  static const red500 = Color(0xFFD33636);
  static const red600 = Color(0xFFB02828);
  static const red700 = Color(0xFF8E2020);
  static const red800 = Color(0xFF6E1919);

  // Cyan
  static const cyan50 = Color(0xFFE3F8FB);
  static const cyan100 = Color(0xFFB9EDF4);
  static const cyan200 = Color(0xFF87DFEC);
  static const cyan300 = Color(0xFF54CEE0);
  static const cyan400 = Color(0xFF2FB9CE);
  static const cyan500 = Color(0xFF1E9DB1);
  static const cyan600 = Color(0xFF187E90);
  static const cyan700 = Color(0xFF146372);
  static const cyan800 = Color(0xFF104E5A);
}

/// ---------------------------------------------------------------------------
/// 2. SEMANTIC TOKENS — chia theo nhóm để copyWith/lerp gọn, dễ maintain
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

  static const dark = AppBackgroundColors(
    primary: Color(0xFF0B1120), // nền tổng thể (gần trùng bg trang Figma)
    secondary: AppPrimitives.grey700,
    secondaryHover: AppPrimitives.grey600,
    tertiary: AppPrimitives.grey700,
    disabled: AppPrimitives.grey800,
    brand: AppPrimitives.blue600,
    brandHover: AppPrimitives.blue500,
    brandPressed: AppPrimitives.blue700,
    brandSubtle: AppPrimitives.blue900,
    success: AppPrimitives.green600,
    successHover: AppPrimitives.green500,
    successPressed: AppPrimitives.green700,
    successSubtle: AppPrimitives.green800,
    warning: AppPrimitives.amber500,
    warningHover: AppPrimitives.amber400,
    warningPressed: AppPrimitives.amber600,
    warningSubtle: AppPrimitives.amber800,
    error: AppPrimitives.red500,
    errorHover: AppPrimitives.red400,
    errorPressed: AppPrimitives.red600,
    errorSubtle: AppPrimitives.red800,
    info: AppPrimitives.cyan500,
    infoHover: AppPrimitives.cyan400,
    infoPressed: AppPrimitives.cyan600,
    infoSubtle: AppPrimitives.cyan800,
    selected: AppPrimitives.blue700,
    inverse: AppPrimitives.grey900,
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

  static const dark = AppTextColors(
    primary: AppPrimitives.grey900,
    secondary: AppPrimitives.grey300,
    tertiary: AppPrimitives.grey600,
    disabled: AppPrimitives.grey700,
    onBrand: AppPrimitives.grey900,
    brand: AppPrimitives.blue400,
    placeholder: AppPrimitives.grey600,
    inverse: AppPrimitives.grey800,
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
    required this.focus,
    required this.brand,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color defaultColor, subtle, strong, disabled, focus;
  final Color brand, success, warning, error, info;

  static const dark = AppBorderColors(
    defaultColor: AppPrimitives.grey700,
    subtle: AppPrimitives.grey800,
    strong: AppPrimitives.grey500,
    disabled: AppPrimitives.grey800,
    focus: AppPrimitives.blue400,
    brand: AppPrimitives.blue600,
    success: AppPrimitives.green600,
    warning: AppPrimitives.amber600,
    error: AppPrimitives.red600,
    info: AppPrimitives.cyan500,
  );

  AppBorderColors lerp(AppBorderColors o, double t) => AppBorderColors(
    defaultColor: Color.lerp(defaultColor, o.defaultColor, t)!,
    subtle: Color.lerp(subtle, o.subtle, t)!,
    strong: Color.lerp(strong, o.strong, t)!,
    disabled: Color.lerp(disabled, o.disabled, t)!,
    focus: Color.lerp(focus, o.focus, t)!,
    brand: Color.lerp(brand, o.brand, t)!,
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
    required this.brand,
    required this.onBrand,
    required this.inverse,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color primary, secondary, tertiary, disabled;
  final Color brand, onBrand, inverse;
  final Color success, warning, error, info;

  static const dark = AppIconColors(
    primary: AppPrimitives.grey300,
    secondary: AppPrimitives.grey500,
    tertiary: AppPrimitives.grey600,
    disabled: AppPrimitives.grey700,
    brand: AppPrimitives.blue500,
    onBrand: AppPrimitives.grey900,
    inverse: AppPrimitives.grey800,
    success: AppPrimitives.green500,
    warning: AppPrimitives.amber500,
    error: AppPrimitives.red500,
    info: AppPrimitives.cyan500,
  );

  AppIconColors lerp(AppIconColors o, double t) => AppIconColors(
    primary: Color.lerp(primary, o.primary, t)!,
    secondary: Color.lerp(secondary, o.secondary, t)!,
    tertiary: Color.lerp(tertiary, o.tertiary, t)!,
    disabled: Color.lerp(disabled, o.disabled, t)!,
    brand: Color.lerp(brand, o.brand, t)!,
    onBrand: Color.lerp(onBrand, o.onBrand, t)!,
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

  static final dark = AppOverlayColors(
    scrim: Colors.black.withOpacity(0.72),
    backdrop: Colors.black.withOpacity(0.50),
    hover: Colors.white.withOpacity(0.06),
    pressed: Colors.white.withOpacity(0.12),
    selected: AppPrimitives.blue600.withOpacity(0.16),
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
/// 3. THEME EXTENSION — gộp 5 nhóm trên, đăng ký vào ThemeData
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

  static final dark = AppColors(
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

/// Truy cập nhanh: `context.colors.background.brand`
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

/// ---------------------------------------------------------------------------
/// 4. ĐĂNG KÝ VÀO ThemeData
/// ---------------------------------------------------------------------------
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  extensions: [AppColors.dark],
  // ⚠️ KHÔNG dùng ColorScheme.dark(...) rồi chỉ set vài field — field nào
  // bỏ trống sẽ rơi về default cứng của Material 2 (tím/xanh ngọc), lệch
  // hẳn với brand blue/navy của bạn.
  //
  // Đúng cách cho Material 3: fromSeed() sinh đủ ~30 role hài hòa từ 1 màu
  // seed, sau đó copyWith() để ép cứng những role cần khớp chính xác với
  // Figma (primary, error, surface...).
  colorScheme:
      ColorScheme.fromSeed(
        seedColor: AppPrimitives.blue600,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppPrimitives.blue600,
        onPrimary: AppPrimitives.grey900,
        error: AppPrimitives.red500,
        onError: AppPrimitives.grey900,
        surface: const Color(0xFF0B1120),
        onSurface: AppPrimitives.grey900,
      ),
);

/// Ví dụ dùng:
///
/// Container(
///   color: context.colors.background.brandSubtle,
///   child: Text(
///     'Đã lưu',
///     style: TextStyle(color: context.colors.text.success),
///   ),
/// )

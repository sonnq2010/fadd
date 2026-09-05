import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/theme/app_typography.dart';

/// Design-system button: Primary / Secondary / Outline / Ghost / Destructive
/// x Large / Medium / Small, with optional leading + trailing icon.

enum AppButtonVariant { primary, secondary, outline, ghost, destructive }

enum AppButtonSize { large, medium, small }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.outline;

  const AppButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.ghost;

  const AppButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.destructive;

  final String label;
  final VoidCallback? onPressed; // null => button switches to disabled state
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final appColors = context.colors;
    final tokens = _sizeTokens[size]!;
    final colors = _colorsFor(appColors, variant);

    final disabledBackground = appColors.background.disabled;
    final disabledForeground = appColors.text.disabled;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        minimumSize: WidgetStatePropertyAll(Size(0, tokens.height)),
        padding: WidgetStatePropertyAll(tokens.padding),
        splashFactory: NoSplash.splashFactory,
        shape: WidgetStateProperty.resolveWith((states) {
          final isDisabled = states.contains(WidgetState.disabled);
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radius),
            side: colors.border != null
                ? BorderSide(
                    color: isDisabled ? disabledBackground : colors.border!,
                    width: 1.5,
                  )
                : BorderSide.none,
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledBackground;
          return colors.background;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledForeground;
          return colors.foreground;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return colors.foreground.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colors.foreground.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colors.foreground.withValues(alpha: 0.10);
          }
          return null;
        }),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: tokens.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: tokens.iconSize),
            const Gap(AppSpacing.xs),
          ],
          Text(label),
          if (trailingIcon != null) ...[
            const Gap(AppSpacing.xs),
            Icon(trailingIcon, size: tokens.iconSize),
          ],
        ],
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

// ---------------- Size tokens ----------------

class _SizeTokens {
  const _SizeTokens({
    required this.height,
    required this.padding,
    required this.radius,
    required this.fontSize,
    required this.iconSize,
  });

  final double height;
  final EdgeInsets padding;
  final double radius;
  final double fontSize;
  final double iconSize;
}

const Map<AppButtonSize, _SizeTokens> _sizeTokens = {
  AppButtonSize.large: _SizeTokens(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 24),
    radius: AppRadius.lg,
    fontSize: 16,
    iconSize: 18,
  ),
  AppButtonSize.medium: _SizeTokens(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 18),
    radius: 10,
    fontSize: 14,
    iconSize: 16,
  ),
  AppButtonSize.small: _SizeTokens(
    height: 32,
    padding: EdgeInsets.symmetric(horizontal: 14),
    radius: AppRadius.md,
    fontSize: 13,
    iconSize: 14,
  ),
};

// ---------------- Variant colors (sourced from AppColors) ----------------

class _VariantColors {
  const _VariantColors({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}

_VariantColors _colorsFor(AppColors colors, AppButtonVariant variant) {
  switch (variant) {
    case AppButtonVariant.primary:
      return _VariantColors(
        background: colors.background.brand,
        foreground: colors.text.onBrand,
      );
    case AppButtonVariant.secondary:
      return _VariantColors(
        background: colors.background.secondary,
        foreground: colors.text.primary,
      );
    case AppButtonVariant.outline:
      return _VariantColors(
        background: Colors.transparent,
        foreground: colors.text.brand,
        border: colors.border.defaultColor,
      );
    case AppButtonVariant.ghost:
      return _VariantColors(
        background: Colors.transparent,
        foreground: colors.text.brand,
      );
    case AppButtonVariant.destructive:
      return _VariantColors(
        background: colors.background.error,
        foreground: colors.text.onBrand,
      );
  }
}

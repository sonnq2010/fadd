import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

/// Design-system button:
/// Primary / Secondary / Outline / Ghost / Destructive / Destructive Outline
/// x Large (48px) / Medium (40px) / Small (36px).

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  destructiveOutline,
}

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

  const AppButton.destructiveOutline({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.destructiveOutline;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool fullWidth;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tokens = _sizeTokens[size]!;
    final variantColors = _colorsFor(colors, variant);

    final resolvedForeground = _isEnabled
        ? variantColors.foreground
        : colors.text.disabled;

    final resolvedBackground = _isEnabled
        ? variantColors.background
        : colors.background.disabled;

    final resolvedBorderSide = !_isEnabled
        ? (variantColors.border != null
              ? BorderSide(color: colors.border.disabled, width: 1.5)
              : BorderSide.none)
        : (variantColors.border != null
              ? BorderSide(color: variantColors.border!, width: 1.5)
              : BorderSide.none);

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, tokens.height)),
      padding: WidgetStatePropertyAll(tokens.padding),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius),
          side: resolvedBorderSide,
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return resolvedBackground;
        }
        if (states.contains(WidgetState.pressed)) {
          return variantColors.pressedBackground;
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return variantColors.hoverBackground;
        }
        return resolvedBackground;
      }),
      foregroundColor: WidgetStatePropertyAll(resolvedForeground),
      iconColor: WidgetStatePropertyAll(resolvedForeground),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return resolvedForeground.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return resolvedForeground.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return resolvedForeground.withValues(alpha: 0.10);
        }
        return null;
      }),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: tokens.fontSize,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );

    final button = ElevatedButton(
      onPressed: onPressed,
      style: style,
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

// ---------------- Button Size tokens ----------------

class _ButtonSizeTokens {
  const _ButtonSizeTokens({
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

const Map<AppButtonSize, _ButtonSizeTokens> _sizeTokens = {
  AppButtonSize.large: _ButtonSizeTokens(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    radius: AppRadius.md, // 8px from Figma
    fontSize: 16,
    iconSize: 16,
  ),
  AppButtonSize.medium: _ButtonSizeTokens(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    radius: AppRadius.md, // 8px from Figma
    fontSize: 14,
    iconSize: 16,
  ),
  AppButtonSize.small: _ButtonSizeTokens(
    height: 36, // Exact 36px from Figma
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    radius: AppRadius.md, // 8px from Figma
    fontSize: 12,
    iconSize: 14,
  ),
};

// ---------------- Button Variant colors ----------------

class _ButtonVariantColors {
  const _ButtonVariantColors({
    required this.background,
    required this.foreground,
    required this.hoverBackground,
    required this.pressedBackground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color hoverBackground;
  final Color pressedBackground;
  final Color? border;
}

_ButtonVariantColors _colorsFor(AppColors colors, AppButtonVariant variant) {
  switch (variant) {
    case AppButtonVariant.primary:
      return _ButtonVariantColors(
        background: colors.background.brand,
        foreground: colors.text.onBrand,
        hoverBackground: colors.background.brandHover,
        pressedBackground: colors.background.brandPressed,
      );
    case AppButtonVariant.secondary:
      return _ButtonVariantColors(
        background: colors.background.secondary,
        foreground: colors.text.primary,
        border: colors.border.defaultColor,
        hoverBackground: colors.background.secondaryHover,
        pressedBackground: colors.background.secondaryHover,
      );
    case AppButtonVariant.outline:
      return _ButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.brand,
        border: colors.border.brand,
        hoverBackground: colors.background.brandSubtle,
        pressedBackground: colors.background.brandSubtle,
      );
    case AppButtonVariant.ghost:
      return _ButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.primary,
        hoverBackground: colors.background.secondaryHover,
        pressedBackground: colors.background.secondaryHover,
      );
    case AppButtonVariant.destructive:
      return _ButtonVariantColors(
        background: colors.background.error,
        foreground: colors.text.onBrand,
        hoverBackground: colors.background.errorHover,
        pressedBackground: colors.background.errorPressed,
      );
    case AppButtonVariant.destructiveOutline:
      return _ButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.error,
        border: colors.border.error,
        hoverBackground: colors.background.errorSubtle,
        pressedBackground: colors.background.errorSubtle,
      );
  }
}

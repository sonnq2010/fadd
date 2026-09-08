import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/widgets/buttons/app_button.dart';

/// Design-system icon button:
/// Primary / Secondary / Outline / Ghost / Destructive / Destructive Outline
/// x Large (48px) / Medium (40px) / Small (36px).

class AppIconButton extends StatelessWidget {
  const AppIconButton.primary({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.primary;

  const AppIconButton.secondary({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.secondary;

  const AppIconButton.outline({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.outline;

  const AppIconButton.ghost({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.ghost;

  const AppIconButton.destructive({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.destructive;

  const AppIconButton.destructiveOutline({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.destructiveOutline;

  final IconData icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final String? semanticLabel;
  final String? tooltip;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tokens = _iconButtonSizeTokens[size]!;
    final variantColors = _iconButtonColorsFor(colors, variant);

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

    final buttonStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(tokens.dimension, tokens.dimension),
      ),
      maximumSize: WidgetStatePropertyAll(
        Size(tokens.dimension, tokens.dimension),
      ),
      fixedSize: WidgetStatePropertyAll(
        Size(tokens.dimension, tokens.dimension),
      ),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
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
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return variantColors.hoverBackground ?? resolvedBackground;
        }
        return resolvedBackground;
      }),
      foregroundColor: WidgetStatePropertyAll(resolvedForeground),
      iconColor: WidgetStatePropertyAll(resolvedForeground),
      elevation: const WidgetStatePropertyAll(0),
    );

    Widget result = SizedBox(
      width: tokens.dimension,
      height: tokens.dimension,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Icon(icon, size: tokens.iconSize),
      ),
    );

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip!,
        child: result,
      );
    }

    if (semanticLabel != null) {
      result = Semantics(
        label: semanticLabel,
        button: true,
        enabled: _isEnabled,
        child: result,
      );
    }

    return result;
  }
}

// ---------------- Icon Button Size tokens ----------------

class _IconButtonSizeTokens {
  const _IconButtonSizeTokens({
    required this.dimension,
    required this.iconSize,
    required this.radius,
  });

  final double dimension;
  final double iconSize;
  final double radius;
}

const Map<AppButtonSize, _IconButtonSizeTokens> _iconButtonSizeTokens = {
  AppButtonSize.large: _IconButtonSizeTokens(
    dimension: 48,
    iconSize: 24, // 24px icon from Figma
    radius: AppRadius.md,
  ),
  AppButtonSize.medium: _IconButtonSizeTokens(
    dimension: 40,
    iconSize: 20, // 20px icon from Figma
    radius: AppRadius.md,
  ),
  AppButtonSize.small: _IconButtonSizeTokens(
    dimension: 36,
    iconSize: 16, // 16px icon from Figma
    radius: AppRadius.md,
  ),
};

// ---------------- Icon Button Variant colors ----------------

class _IconButtonVariantColors {
  const _IconButtonVariantColors({
    required this.background,
    required this.foreground,
    this.border,
    this.hoverBackground,
  });

  final Color background;
  final Color foreground;
  final Color? border;
  final Color? hoverBackground;
}

_IconButtonVariantColors _iconButtonColorsFor(
  AppColors colors,
  AppButtonVariant variant,
) {
  switch (variant) {
    case AppButtonVariant.primary:
      return _IconButtonVariantColors(
        background: colors.background.brand,
        foreground: colors.text.onBrand,
        hoverBackground: colors.background.brandHover,
      );
    case AppButtonVariant.secondary:
      return _IconButtonVariantColors(
        background: colors.background.secondary,
        foreground: colors.text.primary,
        border: colors.border.defaultColor,
        hoverBackground: colors.background.secondaryHover,
      );
    case AppButtonVariant.outline:
      return _IconButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.brand,
        border: colors.border.brand,
        hoverBackground: colors.background.brandSubtle,
      );
    case AppButtonVariant.ghost:
      return _IconButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.primary,
        hoverBackground: colors.background.secondaryHover,
      );
    case AppButtonVariant.destructive:
      return _IconButtonVariantColors(
        background: colors.background.error,
        foreground: colors.text.onBrand,
        hoverBackground: colors.background.errorHover,
      );
    case AppButtonVariant.destructiveOutline:
      return _IconButtonVariantColors(
        background: Colors.transparent,
        foreground: colors.text.error,
        border: colors.border.error,
        hoverBackground: colors.background.errorSubtle,
      );
  }
}

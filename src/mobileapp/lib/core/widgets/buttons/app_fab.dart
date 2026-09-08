import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';

/// Floating Action Button (FAB):
/// Primary brand circular elevated action button.
/// Sizes: Large (72px), Medium (56px), Small (40px).

enum AppFabSize { large, medium, small }

class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppFabSize.medium,
    this.semanticLabel,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppFabSize size;
  final String? semanticLabel;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final appColors = context.colors;
    final tokens = _fabSizeTokens[size]!;
    final isDisabled = onPressed == null;

    final background = isDisabled
        ? appColors.background.disabled
        : appColors.background.brand;
    final foreground = isDisabled
        ? appColors.text.disabled
        : appColors.text.onBrand;
    final hoverBackground = appColors.background.brandHover;

    Widget button = Container(
      width: tokens.dimension,
      height: tokens.dimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isDisabled ? null : AppShadows.lg,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          minimumSize: WidgetStatePropertyAll(
            Size(tokens.dimension, tokens.dimension),
          ),
          fixedSize: WidgetStatePropertyAll(
            Size(tokens.dimension, tokens.dimension),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          splashFactory: NoSplash.splashFactory,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const WidgetStatePropertyAll(CircleBorder()),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return background;
            }
            if (states.contains(WidgetState.hovered)) {
              return hoverBackground;
            }
            return background;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return foreground;
          }),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return foreground.withValues(alpha: 0.12);
            }
            if (states.contains(WidgetState.hovered)) {
              return foreground.withValues(alpha: 0.08);
            }
            if (states.contains(WidgetState.focused)) {
              return foreground.withValues(alpha: 0.10);
            }
            return null;
          }),
        ),
        child: Icon(icon, size: tokens.iconSize),
      ),
    );

    if (semanticLabel != null) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        child: button,
      );
    }

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

class _FabSizeTokens {
  const _FabSizeTokens({
    required this.dimension,
    required this.iconSize,
  });

  final double dimension;
  final double iconSize;
}

const Map<AppFabSize, _FabSizeTokens> _fabSizeTokens = {
  AppFabSize.large: _FabSizeTokens(
    dimension: 72,
    iconSize: 28, // 28px from Figma
  ),
  AppFabSize.medium: _FabSizeTokens(
    dimension: 56,
    iconSize: 24, // 24px from Figma
  ),
  AppFabSize.small: _FabSizeTokens(
    dimension: 40,
    iconSize: 20, // 20px from Figma
  ),
};

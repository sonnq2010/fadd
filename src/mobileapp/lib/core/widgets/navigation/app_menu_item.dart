import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppMenuItem extends StatefulWidget {
  const AppMenuItem({
    super.key,
    required this.label,
    this.leadingIcon,
    this.shortcut,
    this.selected = false,
    this.disabled = false,
    this.destructive = false,
    this.onTap,
  });

  final String label;
  final Widget? leadingIcon;
  final String? shortcut;
  final bool selected;
  final bool disabled;
  final bool destructive;
  final VoidCallback? onTap;

  @override
  State<AppMenuItem> createState() => _AppMenuItemState();
}

class _AppMenuItemState extends State<AppMenuItem> {
  bool _isHovered = false;

  void _setHovered(bool value) {
    if (_isHovered != value) {
      setState(() => _isHovered = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color bgColor;
    if (widget.selected) {
      bgColor = colors.background.selected;
    } else if (_isHovered && !widget.disabled && !widget.destructive) {
      bgColor = colors.background.secondaryHover;
    } else {
      bgColor = Colors.transparent;
    }

    final Color textColor;
    if (widget.disabled) {
      textColor = colors.text.disabled;
    } else if (widget.destructive) {
      textColor = colors.text.error;
    } else if (widget.selected) {
      textColor = colors.text.brand;
    } else {
      textColor = colors.text.primary;
    }

    final Color shortcutColor = widget.disabled
        ? colors.text.disabled
        : colors.text.tertiary;

    Widget? leading = widget.leadingIcon;
    if (leading == null && widget.selected) {
      leading = Icon(LucideIcons.check, size: 16, color: textColor);
    }

    return MouseRegion(
      cursor: widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: widget.disabled ? null : (_) => _setHovered(true),
      onExit: widget.disabled ? null : (_) => _setHovered(false),
      child: InkWell(
        onTap: widget.disabled ? null : widget.onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        hoverColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                IconTheme(
                  data: IconThemeData(size: 16, color: textColor),
                  child: leading,
                ),
                const Gap(AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  widget.label,
                  style: typography.bodyMedium.withColor(textColor),
                ),
              ),
              if (widget.shortcut != null) ...[
                const Gap(AppSpacing.sm),
                Text(
                  widget.shortcut!,
                  style: typography.caption.withColor(shortcutColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
    required this.children,
    this.width = 220,
  });

  final List<Widget> children;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: width,
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.background.primary,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border.subtle),
        boxShadow: AppShadows.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class AppMenuDivider extends StatelessWidget {
  const AppMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      color: colors.border.subtle,
    );
  }
}

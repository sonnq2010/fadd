import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppSideNavItem extends StatefulWidget {
  const AppSideNavItem({
    super.key,
    required this.label,
    this.icon,
    this.isActive = false,
    this.enabled = true,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool isActive;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  State<AppSideNavItem> createState() => _AppSideNavItemState();
}

class _AppSideNavItemState extends State<AppSideNavItem> {
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

    final Color backgroundColor;
    final Color contentColor;

    if (!widget.enabled) {
      backgroundColor = Colors.transparent;
      contentColor = colors.text.disabled;
    } else if (widget.isActive) {
      backgroundColor = colors.background.selected;
      contentColor = colors.text.brand;
    } else if (_isHovered) {
      backgroundColor = colors.background.secondaryHover;
      contentColor = colors.text.primary;
    } else {
      backgroundColor = Colors.transparent;
      contentColor = colors.text.secondary;
    }

    return MouseRegion(
      cursor: widget.enabled && widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: widget.enabled ? (_) => _setHovered(true) : null,
      onExit: widget.enabled ? (_) => _setHovered(false) : null,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          onTap: widget.enabled ? widget.onTap : null,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          hoverColor: Colors.transparent,
          child: Container(
            width: 200.0,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 18.0,
                    color: contentColor,
                  ),
                  const Gap(AppSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    widget.label,
                    style: typography.bodySmall.withColor(contentColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

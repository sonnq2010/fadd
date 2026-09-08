import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppSideNavItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color backgroundColor;
    final Color contentColor;

    if (!enabled) {
      backgroundColor = Colors.transparent;
      contentColor = colors.text.disabled;
    } else if (isActive) {
      backgroundColor = colors.background.selected;
      contentColor = colors.text.brand;
    } else {
      backgroundColor = Colors.transparent;
      contentColor = colors.text.secondary;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Container(
          width: 200.0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18.0,
                  color: contentColor,
                ),
                const Gap(AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  label,
                  style: typography.bodyMedium.withColor(contentColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

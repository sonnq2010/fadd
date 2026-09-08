import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.enabled = true,
    this.onTap,
    this.onDeleted,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Color backgroundColor;
    Border? border;
    Color textColor;
    Color iconColor;

    if (!enabled) {
      backgroundColor = colors.background.disabled;
      border = Border.all(color: colors.border.disabled);
      textColor = colors.text.disabled;
      iconColor = colors.icon.disabled;
    } else if (selected) {
      backgroundColor = colors.background.brand;
      border = null;
      textColor = colors.text.onBrand;
      iconColor = colors.text.onBrand;
    } else {
      backgroundColor = colors.background.primary;
      border = Border.all(color: colors.border.defaultColor);
      textColor = colors.text.primary;
      iconColor = colors.icon.primary;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: border,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(
                  Icons.check,
                  size: 14,
                  color: iconColor,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                label,
                style: typography.labelSmall.withColor(textColor),
              ),
              if (onDeleted != null && enabled) ...[
                const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  onTap: onDeleted,
                  child: Icon(
                    Icons.close,
                    size: 12,
                    color: iconColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

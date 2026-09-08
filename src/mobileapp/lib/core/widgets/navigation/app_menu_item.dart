import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppMenuItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color bgColor;
    if (selected) {
      bgColor = colors.background.selected;
    } else {
      bgColor = Colors.transparent;
    }

    final Color textColor;
    if (disabled) {
      textColor = colors.text.disabled;
    } else if (destructive) {
      textColor = colors.text.error;
    } else if (selected) {
      textColor = colors.text.brand;
    } else {
      textColor = colors.text.primary;
    }

    final Color shortcutColor = disabled
        ? colors.text.disabled
        : colors.text.tertiary;

    Widget? leading = leadingIcon;
    if (leading == null && selected) {
      leading = Icon(LucideIcons.check, size: 16, color: textColor);
    }

    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
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
                label,
                style: typography.bodyMedium.withColor(textColor),
              ),
            ),
            if (shortcut != null) ...[
              const Gap(AppSpacing.sm),
              Text(
                shortcut!,
                style: typography.caption.withColor(shortcutColor),
              ),
            ],
          ],
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

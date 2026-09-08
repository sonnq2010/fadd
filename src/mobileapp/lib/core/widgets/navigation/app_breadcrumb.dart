import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppBreadcrumbItemState {
  defaultState,
  hover,
  current,
}

class AppBreadcrumbItemData {
  const AppBreadcrumbItemData({
    required this.label,
    this.onTap,
    this.isCurrent = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isCurrent;
}

class AppBreadcrumbItem extends StatelessWidget {
  const AppBreadcrumbItem({
    super.key,
    required this.label,
    this.state = AppBreadcrumbItemState.defaultState,
    this.showSeparator = true,
    this.onTap,
  });

  final String label;
  final AppBreadcrumbItemState state;
  final bool showSeparator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color textColor;
    switch (state) {
      case AppBreadcrumbItemState.defaultState:
        textColor = colors.text.secondary;
      case AppBreadcrumbItemState.hover:
        textColor = colors.text.brand;
      case AppBreadcrumbItemState.current:
        textColor = colors.text.primary;
    }

    final text = Text(
      label,
      style: typography.bodySmall.withColor(textColor),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (onTap != null && state != AppBreadcrumbItemState.current)
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: text,
          )
        else
          text,
        if (showSeparator) ...[
          const SizedBox(width: AppSpacing.xs),
          Icon(
            LucideIcons.chevronRight,
            size: 14.0,
            color: colors.icon.tertiary,
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}

class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({
    super.key,
    required this.items,
  });

  final List<AppBreadcrumbItemData> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            AppBreadcrumbItem(
              label: items[i].label,
              state: items[i].isCurrent || i == items.length - 1
                  ? AppBreadcrumbItemState.current
                  : AppBreadcrumbItemState.defaultState,
              showSeparator: i < items.length - 1,
              onTap: items[i].onTap,
            ),
          ],
        ],
      ),
    );
  }
}

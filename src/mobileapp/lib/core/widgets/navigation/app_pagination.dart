import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppPaginationItemState {
  defaultState,
  hover,
  active,
  disabled,
  ellipsis,
}

class AppPaginationItem extends StatelessWidget {
  const AppPaginationItem({
    super.key,
    required this.label,
    this.state = AppPaginationItemState.defaultState,
    this.onTap,
  });

  final String label;
  final AppPaginationItemState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color backgroundColor;
    final Color textColor;

    switch (state) {
      case AppPaginationItemState.defaultState:
        backgroundColor = Colors.transparent;
        textColor = colors.text.primary;
      case AppPaginationItemState.hover:
        backgroundColor = colors.background.secondaryHover;
        textColor = colors.text.primary;
      case AppPaginationItemState.active:
        backgroundColor = colors.background.brand;
        textColor = colors.text.onBrand;
      case AppPaginationItemState.disabled:
        backgroundColor = Colors.transparent;
        textColor = colors.text.disabled;
      case AppPaginationItemState.ellipsis:
        backgroundColor = Colors.transparent;
        textColor = colors.text.tertiary;
    }

    final isInteractive =
        state != AppPaginationItemState.disabled &&
        state != AppPaginationItemState.ellipsis &&
        onTap != null;

    final child = Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: typography.labelMedium.withColor(textColor),
      ),
    );

    if (isInteractive) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: child,
      );
    }

    return child;
  }
}

class AppPagination extends StatelessWidget {
  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPageChanged,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final items = <Widget>[];

    // Previous button
    items.add(
      IconButton(
        onPressed: currentPage > 1
            ? () => onPageChanged?.call(currentPage - 1)
            : null,
        icon: Icon(
          LucideIcons.chevronLeft,
          size: 20.0,
          color: currentPage > 1 ? colors.icon.primary : colors.icon.disabled,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        splashRadius: 20.0,
      ),
    );

    if (totalPages <= 5) {
      for (var i = 1; i <= totalPages; i++) {
        items.add(
          AppPaginationItem(
            label: '$i',
            state: i == currentPage
                ? AppPaginationItemState.active
                : AppPaginationItemState.defaultState,
            onTap: () => onPageChanged?.call(i),
          ),
        );
      }
    } else {
      // 1, 2, 3, ..., totalPages
      items.add(
        AppPaginationItem(
          label: '1',
          state: currentPage == 1
              ? AppPaginationItemState.active
              : AppPaginationItemState.defaultState,
          onTap: () => onPageChanged?.call(1),
        ),
      );

      items.add(
        AppPaginationItem(
          label: '2',
          state: currentPage == 2
              ? AppPaginationItemState.active
              : AppPaginationItemState.defaultState,
          onTap: () => onPageChanged?.call(2),
        ),
      );

      items.add(
        AppPaginationItem(
          label: '3',
          state: currentPage == 3
              ? AppPaginationItemState.active
              : AppPaginationItemState.defaultState,
          onTap: () => onPageChanged?.call(3),
        ),
      );

      items.add(
        const AppPaginationItem(
          label: '...',
          state: AppPaginationItemState.ellipsis,
        ),
      );

      items.add(
        AppPaginationItem(
          label: '$totalPages',
          state: currentPage == totalPages
              ? AppPaginationItemState.active
              : AppPaginationItemState.defaultState,
          onTap: () => onPageChanged?.call(totalPages),
        ),
      );
    }

    // Next button
    items.add(
      IconButton(
        onPressed: currentPage < totalPages
            ? () => onPageChanged?.call(currentPage + 1)
            : null,
        icon: Icon(
          LucideIcons.chevronRight,
          size: 20.0,
          color: currentPage < totalPages
              ? colors.icon.primary
              : colors.icon.disabled,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        splashRadius: 20.0,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xs),
          items[i],
        ],
      ],
    );
  }
}

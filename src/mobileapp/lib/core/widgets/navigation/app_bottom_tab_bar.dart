import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppBottomTabItemData {
  const AppBottomTabItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class AppBottomTabItem extends StatelessWidget {
  const AppBottomTabItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final contentColor = isActive ? colors.text.brand : colors.text.tertiary;

    return SizedBox(
      width: 67.5,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22.0,
              color: contentColor,
            ),
            const Gap(AppSpacing.xs),
            Text(
              label,
              style: typography.labelMedium.withColor(contentColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class AppBottomTabBar extends StatelessWidget {
  const AppBottomTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppBottomTabItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.background.primary,
        border: Border(
          top: BorderSide(
            color: colors.border.subtle,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        top: AppSpacing.sm,
        bottom: AppSpacing.s2xl,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Gap(AppSpacing.md),
            Expanded(
              child: AppBottomTabItem(
                icon: items[i].icon,
                label: items[i].label,
                isActive: currentIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

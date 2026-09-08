import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppTabItem extends StatelessWidget {
  const AppTabItem({
    super.key,
    required this.label,
    this.isActive = false,
    this.enabled = true,
    this.onTap,
  });

  final String label;
  final bool isActive;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color textColor;
    if (!enabled) {
      textColor = colors.text.disabled;
    } else if (isActive) {
      textColor = colors.text.brand;
    } else {
      textColor = colors.text.secondary;
    }

    final indicatorColor = isActive ? colors.border.brand : Colors.transparent;

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.sm,
          left: AppSpacing.md,
          right: AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: typography.labelMedium.withColor(textColor),
            ),
            const Gap(AppSpacing.sm),
            Container(
              height: 2,
              color: indicatorColor,
            ),
          ],
        ),
      ),
    );
  }
}

class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < tabs.length; i++)
            AppTabItem(
              label: tabs[i],
              isActive: selectedIndex == i,
              onTap: () => onTabSelected(i),
            ),
        ],
      ),
    );
  }
}

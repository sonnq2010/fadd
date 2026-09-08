import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/app_tab_item.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.brandTitle,
    this.brandLeading,
    this.tabs = const [],
    this.selectedTabIndex = 0,
    this.onTabSelected,
    this.actions = const [],
  });

  final String brandTitle;
  final Widget? brandLeading;
  final List<String> tabs;
  final int selectedTabIndex;
  final ValueChanged<int>? onTabSelected;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      decoration: BoxDecoration(
        color: colors.background.primary,
        border: Border(
          bottom: BorderSide(
            color: colors.border.subtle,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (brandLeading != null) ...[
                    brandLeading!,
                    const Gap(AppSpacing.sm),
                  ],
                  Text(
                    brandTitle,
                    style: typography.headingH4.bold
                        .withSize(18)
                        .withColor(colors.text.primary),
                  ),
                  if (tabs.isNotEmpty) ...[
                    const Gap(AppSpacing.xxl),
                    AppTabs(
                      tabs: tabs,
                      selectedIndex: selectedTabIndex,
                      onTabSelected: onTabSelected ?? (_) {},
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (actions.isNotEmpty) ...[
            const Gap(AppSpacing.lg),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < actions.length; i++) ...[
                  if (i > 0) const Gap(AppSpacing.lg),
                  actions[i],
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

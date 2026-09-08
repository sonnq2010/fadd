import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class TabItemSection extends StatefulWidget {
  const TabItemSection({super.key});

  @override
  State<TabItemSection> createState() => _TabItemSectionState();
}

class _TabItemSectionState extends State<TabItemSection> {
  int _selectedFiveIndex = 0;
  int _selectedFourIndex = 0;
  int _selectedThreeIndex = 0;
  int _selectedTwoIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: 'global_components.tab_item_title'.tr(),
      description: 'global_components.tab_item_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. States
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'States',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          Wrap(
            spacing: AppSpacing.md,
            children: const [
              AppTabItem(label: 'Default'),
              AppTabItem(label: 'Active', isActive: true),
              AppTabItem(label: 'Disabled', enabled: false),
            ],
          ),
          const Divider(),

          // 2. Tab quantities
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              '5 Tabs',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppTabs(
            tabs: const [
              'Tab label',
              'Tab label',
              'Tab label',
              'Tab label',
              'Tab label',
            ],
            selectedIndex: _selectedFiveIndex,
            onTabSelected: (idx) => setState(() => _selectedFiveIndex = idx),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              '4 Tabs',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppTabs(
            tabs: const ['Tab label', 'Tab label', 'Tab label', 'Tab label'],
            selectedIndex: _selectedFourIndex,
            onTabSelected: (idx) => setState(() => _selectedFourIndex = idx),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              '3 Tabs',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppTabs(
            tabs: const ['Tab label', 'Tab label', 'Tab label'],
            selectedIndex: _selectedThreeIndex,
            onTabSelected: (idx) => setState(() => _selectedThreeIndex = idx),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              '2 Tabs',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppTabs(
            tabs: const ['Tab label', 'Tab label'],
            selectedIndex: _selectedTwoIndex,
            onTabSelected: (idx) => setState(() => _selectedTwoIndex = idx),
          ),
        ],
      ),
    );
  }
}

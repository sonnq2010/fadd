import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class MenuItemSection extends StatefulWidget {
  const MenuItemSection({super.key});

  @override
  State<MenuItemSection> createState() => _MenuItemSectionState();
}

class _MenuItemSectionState extends State<MenuItemSection> {
  bool _showLineNumbers = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: 'global_components.menu_item_title'.tr(),
      description: 'global_components.menu_item_desc'.tr(),
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
          SizedBox(
            width: 220,
            child: Column(
              children: const [
                AppMenuItem(label: 'Menu item', shortcut: '⌘K'),
                AppMenuItem(label: 'Menu item', selected: true, shortcut: '⌘K'),
                AppMenuItem(label: 'Menu item', disabled: true, shortcut: '⌘K'),
              ],
            ),
          ),
          const Divider(),

          // 2. Menu Sample Composite
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'global_components.menu_sample_title'.tr(),
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppMenu(
            children: [
              const AppMenuItem(label: 'Cut'),
              const AppMenuItem(label: 'Copy'),
              const AppMenuItem(label: 'Paste'),
              AppMenuItem(
                label: 'Show line numbers',
                selected: _showLineNumbers,
                onTap: () {
                  setState(() {
                    _showLineNumbers = !_showLineNumbers;
                  });
                },
              ),
              const AppMenuDivider(),
              const AppMenuItem(
                label: 'Delete',
                destructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

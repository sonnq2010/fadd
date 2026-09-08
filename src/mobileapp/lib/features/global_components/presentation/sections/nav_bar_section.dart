import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class NavBarSection extends StatefulWidget {
  const NavBarSection({super.key});

  @override
  State<NavBarSection> createState() => _NavBarSectionState();
}

class _NavBarSectionState extends State<NavBarSection> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_nav_bar_title.tr(),
      description: LocaleKeys.global_components_nav_bar_desc.tr(),
      child: AppNavBar(
        brandTitle: 'Acme',
        tabs: const ['Tab label', 'Tab label', 'Tab label'],
        selectedTabIndex: _selectedTabIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        actions: [
          AppIconButton.ghost(
            icon: LucideIcons.bell,
            semanticLabel: 'Notifications',
            onPressed: () {},
          ),
          AppButton.primary(
            label: 'New project',
            leadingIcon: LucideIcons.plus,
            trailingIcon: LucideIcons.arrowUpRight,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

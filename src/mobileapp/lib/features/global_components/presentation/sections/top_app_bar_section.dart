import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class TopAppBarSection extends StatelessWidget {
  const TopAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.top_app_bar_title'.tr(),
      description: 'global_components.top_app_bar_desc'.tr(),
      child: Center(
        child: SizedBox(
          width: 375.0,
          child: AppTopBar(
            title: 'Screen title',
            leading: AppIconButton.ghost(
              icon: LucideIcons.arrowLeft,
              semanticLabel: 'Back',
              onPressed: () {},
            ),
            trailing: AppIconButton.ghost(
              icon: LucideIcons.menu,
              semanticLabel: 'Menu',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

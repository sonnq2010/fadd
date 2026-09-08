import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/data_display/app_accordion.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class AccordionSection extends StatelessWidget {
  const AccordionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.accordion_title'.tr(),
      description: 'global_components.accordion_desc'.tr(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppAccordionItem(
              title: 'global_components.accordion_item_title'.tr(),
              description: 'global_components.accordion_item_desc'.tr(),
              initiallyExpanded: false,
            ),
            const SizedBox(height: AppSpacing.md),
            AppAccordionItem(
              title: 'global_components.accordion_item_title'.tr(),
              description: 'global_components.accordion_item_desc'.tr(),
              initiallyExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}

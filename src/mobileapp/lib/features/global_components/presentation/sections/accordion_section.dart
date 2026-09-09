import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/data_display/app_accordion.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class AccordionSection extends StatelessWidget {
  const AccordionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_accordion_title.tr(),
      description: LocaleKeys.global_components_accordion_desc.tr(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppAccordionItem(
              title: LocaleKeys.global_components_accordion_item_title.tr(),
              description: LocaleKeys.global_components_accordion_item_desc
                  .tr(),
              initiallyExpanded: false,
            ),
            const SizedBox(height: AppSpacing.md),
            AppAccordionItem(
              title: LocaleKeys.global_components_accordion_item_title.tr(),
              description: LocaleKeys.global_components_accordion_item_desc
                  .tr(),
              initiallyExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}

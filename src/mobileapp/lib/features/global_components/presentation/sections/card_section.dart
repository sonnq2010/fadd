import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/data_display/data_display.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_card_title.tr(),
      description: LocaleKeys.global_components_card_desc.tr(),
      child: Center(
        child: AppCard(
          badge: const AppBadge(
            label: 'Active',
            variant: AppBadgeVariant.success,
          ),
          title: 'Card title',
          description:
              'A short supporting description that explains what this card represents and why it matters.',
          actions: [
            AppButton.primary(
              label: 'View details',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
            AppButton.ghost(
              label: 'Dismiss',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

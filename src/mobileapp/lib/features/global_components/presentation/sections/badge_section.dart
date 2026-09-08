import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/data_display/data_display.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class BadgeSection extends StatelessWidget {
  const BadgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_badge_title.tr(),
      description: LocaleKeys.global_components_badge_desc.tr(),
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.sm,
        children: const [
          AppBadge(label: 'Neutral', variant: AppBadgeVariant.neutral),
          AppBadge(label: 'Brand', variant: AppBadgeVariant.brand),
          AppBadge(label: 'Secondary', variant: AppBadgeVariant.secondary),
          AppBadge(label: 'Success', variant: AppBadgeVariant.success),
          AppBadge(label: 'Warning', variant: AppBadgeVariant.warning),
          AppBadge(label: 'Error', variant: AppBadgeVariant.error),
          AppBadge(label: 'Info', variant: AppBadgeVariant.info),
        ],
      ),
    );
  }
}

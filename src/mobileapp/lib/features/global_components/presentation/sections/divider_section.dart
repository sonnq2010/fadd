import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/layout/app_divider.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: 'global_components.divider_title'.tr(),
      description: 'global_components.divider_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'global_components.divider_with_label'.tr(),
            style: typography.labelSmall.withColor(colors.text.secondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(
            width: 240,
            child: AppDivider(label: 'OR'),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'global_components.divider_horizontal'.tr(),
            style: typography.labelSmall.withColor(colors.text.secondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(
            width: 240,
            child: AppDivider(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'global_components.divider_vertical'.tr(),
            style: typography.labelSmall.withColor(colors.text.secondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(
                'Item 1',
                style: typography.bodySmall.withColor(colors.text.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              const SizedBox(
                height: 32,
                child: AppDivider(orientation: AppDividerOrientation.vertical),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Item 2',
                style: typography.bodySmall.withColor(colors.text.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

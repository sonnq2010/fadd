import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/selection/selection.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class RadioSection extends StatelessWidget {
  const RadioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: LocaleKeys.global_components_radio_title.tr(),
      description: LocaleKeys.global_components_radio_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Unselected
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Unselected',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              AppRadio<int>(
                label: LocaleKeys.global_components_radio_label.tr(),
                value: 1,
                groupValue: 2,
                onChanged: (_) {},
              ),
              AppRadio<int>(
                label: LocaleKeys.global_components_radio_label.tr(),
                value: 1,
                groupValue: 2,
                enabled: false,
                onChanged: (_) {},
              ),
            ],
          ),
          const Divider(),

          // 2. Selected
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Selected',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              AppRadio<int>(
                label: LocaleKeys.global_components_radio_label.tr(),
                value: 1,
                groupValue: 1,
                onChanged: (_) {},
              ),
              AppRadio<int>(
                label: LocaleKeys.global_components_radio_label.tr(),
                value: 1,
                groupValue: 1,
                enabled: false,
                onChanged: (_) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

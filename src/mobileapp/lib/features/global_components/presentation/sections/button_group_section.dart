import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class ButtonGroupSection extends StatelessWidget {
  const ButtonGroupSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final layouts = [
      (AppButtonGroupAlignment.justify, 'Justify'),
      (AppButtonGroupAlignment.start, 'Start'),
      (AppButtonGroupAlignment.end, 'End'),
      (AppButtonGroupAlignment.center, 'Center'),
      (AppButtonGroupAlignment.stack, 'Stack'),
    ];

    return ComponentCard(
      title: 'global_components.button_group_title'.tr(),
      description: 'global_components.button_group_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (alignment, label) in layouts) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                label,
                style: typography.labelMedium.withColor(colors.text.secondary),
              ),
            ),
            Container(
              width: 360,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.background.secondary,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: colors.border.defaultColor),
              ),
              child: AppButtonGroup(
                alignment: alignment,
                children: [
                  AppButton.secondary(
                    label: 'global_components.cancel'.tr(),
                    onPressed: () {},
                  ),
                  AppButton.primary(
                    label: 'global_components.confirm'.tr(),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/selection/selection.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class CheckboxSection extends StatelessWidget {
  const CheckboxSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final values = [
      (AppCheckboxValue.unchecked, 'Unchecked'),
      (AppCheckboxValue.checked, 'Checked'),
      (AppCheckboxValue.indeterminate, 'Indeterminate'),
    ];

    return ComponentCard(
      title: LocaleKeys.global_components_checkbox_title.tr(),
      description: LocaleKeys.global_components_checkbox_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (value, valueLabel) in values) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Text(
                valueLabel,
                style: typography.labelLarge.withColor(colors.text.primary),
              ),
            ),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.md,
              children: [
                // 1. Default
                AppCheckbox(
                  label: LocaleKeys.global_components_checkbox_label.tr(),
                  value: value,
                  onChanged: (_) {},
                ),
                // 2. Disabled
                AppCheckbox(
                  label: LocaleKeys.global_components_checkbox_label.tr(),
                  value: value,
                  enabled: false,
                ),
              ],
            ),
            const Divider(),
          ],
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class SelectSection extends StatelessWidget {
  const SelectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final sizes = [
      (AppSelectSize.large, 'Large (48px)'),
      (AppSelectSize.medium, 'Medium (40px)'),
      (AppSelectSize.small, 'Small (36px)'),
    ];

    final sampleItems = [
      const AppSelectItem(value: 'opt1', label: 'Selected value'),
      const AppSelectItem(value: 'opt2', label: 'Option 2'),
      const AppSelectItem(
        value: 'opt3',
        label: 'Option 3 (disabled)',
        enabled: false,
      ),
    ];

    return ComponentCard(
      title: LocaleKeys.global_components_select_title.tr(),
      description: LocaleKeys.global_components_select_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (size, sizeLabel) in sizes) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Text(
                sizeLabel,
                style: typography.labelLarge.withColor(colors.text.primary),
              ),
            ),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                // 1. Default (placeholder)
                SizedBox(
                  width: 280,
                  child: AppSelect<String>(
                    label: LocaleKeys.global_components_select_label.tr(),
                    placeholder: LocaleKeys.global_components_select_placeholder
                        .tr(),
                    helperText: LocaleKeys.global_components_select_helper.tr(),
                    items: sampleItems,
                    size: size,
                  ),
                ),
                // 2. Filled (selected value)
                SizedBox(
                  width: 280,
                  child: AppSelect<String>(
                    label: LocaleKeys.global_components_select_label.tr(),
                    value: 'opt1',
                    helperText: LocaleKeys.global_components_select_helper.tr(),
                    items: sampleItems,
                    size: size,
                  ),
                ),
                // 3. Error
                SizedBox(
                  width: 280,
                  child: AppSelect<String>(
                    label: LocaleKeys.global_components_select_label.tr(),
                    value: 'opt1',
                    errorText: LocaleKeys.global_components_select_error.tr(),
                    items: sampleItems,
                    size: size,
                  ),
                ),
                // 4. Disabled
                SizedBox(
                  width: 280,
                  child: AppSelect<String>(
                    label: LocaleKeys.global_components_select_label.tr(),
                    placeholder: LocaleKeys.global_components_select_placeholder
                        .tr(),
                    helperText: LocaleKeys.global_components_select_helper.tr(),
                    items: sampleItems,
                    enabled: false,
                    size: size,
                  ),
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

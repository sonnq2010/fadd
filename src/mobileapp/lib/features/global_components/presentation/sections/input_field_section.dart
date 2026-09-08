import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class InputFieldSection extends StatelessWidget {
  const InputFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final sizes = [
      (AppInputSize.large, 'Large (48px)'),
      (AppInputSize.medium, 'Medium (40px)'),
      (AppInputSize.small, 'Small (36px)'),
    ];

    return ComponentCard(
      title: 'global_components.input_title'.tr(),
      description: 'global_components.input_desc'.tr(),
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
                // 1. Default
                SizedBox(
                  width: 280,
                  child: AppInputField(
                    label: 'global_components.input_label'.tr(),
                    placeholder: 'global_components.input_placeholder'.tr(),
                    helperText: 'global_components.input_helper'.tr(),
                    leadingIcon: LucideIcons.search,
                    trailingIcon: LucideIcons.x,
                    size: size,
                  ),
                ),
                // 2. Filled
                SizedBox(
                  width: 280,
                  child: AppInputField(
                    label: 'global_components.input_label'.tr(),
                    initialValue: 'Value text',
                    helperText: 'global_components.input_helper'.tr(),
                    leadingIcon: LucideIcons.search,
                    trailingIcon: LucideIcons.x,
                    size: size,
                  ),
                ),
                // 3. Error
                SizedBox(
                  width: 280,
                  child: AppInputField(
                    label: 'global_components.input_label'.tr(),
                    initialValue: 'Value text',
                    errorText: 'global_components.input_error'.tr(),
                    leadingIcon: LucideIcons.search,
                    trailingIcon: LucideIcons.x,
                    size: size,
                  ),
                ),
                // 4. Disabled
                SizedBox(
                  width: 280,
                  child: AppInputField(
                    label: 'global_components.input_label'.tr(),
                    placeholder: 'global_components.input_placeholder'.tr(),
                    helperText: 'global_components.input_helper'.tr(),
                    leadingIcon: LucideIcons.search,
                    trailingIcon: LucideIcons.x,
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

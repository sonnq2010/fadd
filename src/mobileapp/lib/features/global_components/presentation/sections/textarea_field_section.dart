import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class TextareaFieldSection extends StatelessWidget {
  const TextareaFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.textarea_title'.tr(),
      description: 'global_components.textarea_desc'.tr(),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            // 1. Default
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: 'global_components.textarea_label'.tr(),
                placeholder: 'global_components.textarea_placeholder'.tr(),
                helperText: 'global_components.textarea_helper'.tr(),
              ),
            ),
            // 2. Filled
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: 'global_components.textarea_label'.tr(),
                initialValue:
                    'This is a longer piece of text spanning multiple lines to demonstrate wrapping.',
                helperText: 'global_components.textarea_helper'.tr(),
              ),
            ),
            // 3. Error
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: 'global_components.textarea_label'.tr(),
                initialValue: 'This value is invalid.',
                errorText: 'global_components.textarea_error'.tr(),
              ),
            ),
            // 4. Disabled
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: 'global_components.textarea_label'.tr(),
                placeholder: 'global_components.textarea_placeholder'.tr(),
                helperText: 'global_components.textarea_helper'.tr(),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

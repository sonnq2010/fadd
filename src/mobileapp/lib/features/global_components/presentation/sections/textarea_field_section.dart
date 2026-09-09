import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class TextareaFieldSection extends StatelessWidget {
  const TextareaFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_textarea_title.tr(),
      description: LocaleKeys.global_components_textarea_desc.tr(),
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
                label: LocaleKeys.global_components_textarea_label.tr(),
                placeholder: LocaleKeys.global_components_textarea_placeholder
                    .tr(),
                helperText: LocaleKeys.global_components_textarea_helper.tr(),
              ),
            ),
            // 2. Filled
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: LocaleKeys.global_components_textarea_label.tr(),
                initialValue:
                    'This is a longer piece of text spanning multiple lines to demonstrate wrapping.',
                helperText: LocaleKeys.global_components_textarea_helper.tr(),
              ),
            ),
            // 3. Error
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: LocaleKeys.global_components_textarea_label.tr(),
                initialValue: 'This value is invalid.',
                errorText: LocaleKeys.global_components_textarea_error.tr(),
              ),
            ),
            // 4. Disabled
            SizedBox(
              width: 320,
              child: AppTextareaField(
                label: LocaleKeys.global_components_textarea_label.tr(),
                placeholder: LocaleKeys.global_components_textarea_placeholder
                    .tr(),
                helperText: LocaleKeys.global_components_textarea_helper.tr(),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

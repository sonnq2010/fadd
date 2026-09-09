import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class AlertSection extends StatelessWidget {
  const AlertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_alert_title.tr(),
      description: LocaleKeys.global_components_alert_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          AppAlert(
            message: 'Success alert message goes here.',
            variant: AppAlertVariant.success,
          ),
          SizedBox(height: AppSpacing.sm),
          AppAlert(
            message: 'Warning alert message goes here.',
            variant: AppAlertVariant.warning,
          ),
          SizedBox(height: AppSpacing.sm),
          AppAlert(
            message: 'Error alert message goes here.',
            variant: AppAlertVariant.error,
          ),
          SizedBox(height: AppSpacing.sm),
          AppAlert(
            message: 'Info alert message goes here.',
            variant: AppAlertVariant.info,
          ),
        ],
      ),
    );
  }
}

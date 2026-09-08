import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class AlertSection extends StatelessWidget {
  const AlertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.alert_title'.tr(),
      description: 'global_components.alert_desc'.tr(),
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

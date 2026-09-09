import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/app_stepper.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class StepperSection extends StatelessWidget {
  const StepperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_stepper_title.tr(),
      description: LocaleKeys.global_components_stepper_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // States
          Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppStepperItem(
                label: 'Upcoming',
                number: '1',
                state: AppStepperState.upcoming,
              ),
              AppStepperItem(
                label: 'Active',
                number: '1',
                state: AppStepperState.active,
              ),
              AppStepperItem(
                label: 'Completed',
                number: '1',
                state: AppStepperState.completed,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          // Composite
          AppStepper(
            steps: [
              AppStepperStep(
                label: 'Account',
                state: AppStepperState.completed,
              ),
              AppStepperStep(label: 'Shipping', state: AppStepperState.active),
              AppStepperStep(label: 'Payment', state: AppStepperState.upcoming),
              AppStepperStep(label: 'Review', state: AppStepperState.upcoming),
            ],
          ),
        ],
      ),
    );
  }
}

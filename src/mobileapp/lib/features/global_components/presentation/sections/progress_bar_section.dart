import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class ProgressBarSection extends StatelessWidget {
  const ProgressBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.progress_bar_title'.tr(),
      description: 'global_components.progress_bar_desc'.tr(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppProgressBar(
              value: 0.6,
              state: AppProgressBarState.defaultState,
              label: 'global_components.progress_bar_sample_label'.tr(),
            ),
            const SizedBox(height: AppSpacing.md),
            AppProgressBar(
              value: 0.6,
              state: AppProgressBarState.success,
              label: 'global_components.progress_bar_sample_label'.tr(),
            ),
            const SizedBox(height: AppSpacing.md),
            AppProgressBar(
              value: 0.6,
              state: AppProgressBarState.error,
              label: 'global_components.progress_bar_sample_label'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

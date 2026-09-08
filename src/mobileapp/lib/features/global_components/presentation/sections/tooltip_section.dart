import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class TooltipSection extends StatelessWidget {
  const TooltipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_tooltip_title.tr(),
      description: LocaleKeys.global_components_tooltip_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppTooltipBubble(
                label: 'Tooltip text',
                position: AppTooltipPosition.top,
              ),
              AppTooltipBubble(
                label: 'Tooltip text',
                position: AppTooltipPosition.bottom,
              ),
              AppTooltipBubble(
                label: 'Tooltip text',
                position: AppTooltipPosition.left,
              ),
              AppTooltipBubble(
                label: 'Tooltip text',
                position: AppTooltipPosition.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

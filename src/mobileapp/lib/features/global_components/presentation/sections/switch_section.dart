import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/selection/selection.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class SwitchSection extends StatefulWidget {
  const SwitchSection({super.key});

  @override
  State<SwitchSection> createState() => _SwitchSectionState();
}

class _SwitchSectionState extends State<SwitchSection> {
  bool _interactiveValue = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: 'global_components.switch_title'.tr(),
      description: 'global_components.switch_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Off state
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Off',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              AppSwitch(
                label: 'global_components.switch_label'.tr(),
                value: false,
                onChanged: (_) {},
              ),
              AppSwitch(
                label: 'global_components.switch_label'.tr(),
                value: false,
                enabled: false,
                onChanged: (_) {},
              ),
            ],
          ),
          const Divider(),

          // 2. On state
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'On',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              AppSwitch(
                label: 'global_components.switch_label'.tr(),
                value: true,
                onChanged: (_) {},
              ),
              AppSwitch(
                label: 'global_components.switch_label'.tr(),
                value: true,
                enabled: false,
                onChanged: (_) {},
              ),
            ],
          ),
          const Divider(),

          // 3. Interactive demo
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Interactive',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          AppSwitch(
            label:
                '${'global_components.switch_label'.tr()} ($_interactiveValue)',
            value: _interactiveValue,
            onChanged: (val) {
              setState(() {
                _interactiveValue = val;
              });
            },
          ),
        ],
      ),
    );
  }
}

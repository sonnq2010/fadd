import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  double _interactiveValue = 50.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: LocaleKeys.global_components_slider_title.tr(),
      description: LocaleKeys.global_components_slider_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Default (50%)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Default (50%)',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          SizedBox(
            width: 240,
            child: AppSlider(
              value: 50.0,
              onChanged: (_) {},
            ),
          ),
          const Divider(),

          // 2. Disabled (50%)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Disabled (50%)',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          SizedBox(
            width: 240,
            child: AppSlider(
              value: 50.0,
              enabled: false,
              onChanged: (_) {},
            ),
          ),
          const Divider(),

          // 3. Interactive
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Interactive: ${_interactiveValue.toStringAsFixed(0)}%',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          SizedBox(
            width: 240,
            child: AppSlider(
              value: _interactiveValue,
              onChanged: (val) {
                setState(() {
                  _interactiveValue = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

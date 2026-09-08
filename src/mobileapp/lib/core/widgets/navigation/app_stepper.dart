import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppStepperState {
  upcoming,
  active,
  completed,
}

class AppStepperStep {
  const AppStepperStep({
    required this.label,
    required this.state,
    this.number,
  });

  final String label;
  final AppStepperState state;
  final String? number;
}

class AppStepperItem extends StatelessWidget {
  const AppStepperItem({
    super.key,
    required this.label,
    required this.state,
    this.number = '1',
  });

  final String label;
  final AppStepperState state;
  final String number;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Widget circleChild;
    final BoxDecoration circleDecoration;
    final Color labelColor;

    switch (state) {
      case AppStepperState.upcoming:
        circleDecoration = BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.border.defaultColor,
            width: 1.5,
          ),
        );
        circleChild = Text(
          number,
          style: typography.labelMedium.withColor(colors.text.disabled),
        );
        labelColor = colors.text.disabled;
      case AppStepperState.active:
        circleDecoration = BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.border.brand,
            width: 1.5,
          ),
        );
        circleChild = Text(
          number,
          style: typography.labelMedium.withColor(colors.text.primary),
        );
        labelColor = colors.text.primary;
      case AppStepperState.completed:
        circleDecoration = BoxDecoration(
          shape: BoxShape.circle,
          color: colors.background.brand,
        );
        circleChild = Icon(
          LucideIcons.check,
          size: 14.0,
          color: colors.text.onBrand,
        );
        labelColor = colors.text.secondary;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: circleDecoration,
          alignment: Alignment.center,
          child: circleChild,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: typography.labelMedium.withColor(labelColor),
        ),
      ],
    );
  }
}

class AppStepper extends StatelessWidget {
  const AppStepper({
    super.key,
    required this.steps,
  });

  final List<AppStepperStep> steps;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 32.0,
                height: 1.5,
                color: steps[i - 1].state == AppStepperState.completed
                    ? colors.border.brand
                    : colors.border.defaultColor,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            AppStepperItem(
              label: steps[i].label,
              number: steps[i].number ?? '${i + 1}',
              state: steps[i].state,
            ),
          ],
        ],
      ),
    );
  }
}

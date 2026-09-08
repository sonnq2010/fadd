import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppProgressBarState {
  defaultState,
  success,
  error,
}

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.state = AppProgressBarState.defaultState,
    this.label,
    this.showLabel = true,
    this.showPercentage = true,
    this.height = 8.0,
  });

  final double value;
  final AppProgressBarState state;
  final String? label;
  final bool showLabel;
  final bool showPercentage;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color fillColor;
    switch (state) {
      case AppProgressBarState.defaultState:
        fillColor = colors.background.brand;
      case AppProgressBarState.success:
        fillColor = colors.background.success;
      case AppProgressBarState.error:
        fillColor = colors.background.error;
    }

    final clampedValue = value.clamp(0.0, 1.0);
    final percentageText = '${(clampedValue * 100).round()}%';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showLabel && (label != null || showPercentage)) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: typography.caption.withColor(colors.text.secondary),
                )
              else
                const SizedBox.shrink(),
              if (showPercentage)
                Text(
                  percentageText,
                  style: typography.caption.withColor(colors.text.secondary),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.background.tertiary,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          clipBehavior: Clip.antiAlias,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: clampedValue,
              heightFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

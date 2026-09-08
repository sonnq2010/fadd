import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

/// Layout patterns for action button pairs (e.g. Cancel + Confirm).
/// Layouts: Justify (dialogs), Start, End, Center (forms), Stack (mobile/narrow).

enum AppButtonGroupAlignment {
  justify,
  start,
  end,
  center,
  stack,
}

class AppButtonGroup extends StatelessWidget {
  const AppButtonGroup({
    super.key,
    required this.children,
    this.alignment = AppButtonGroupAlignment.justify,
    this.spacing = AppSpacing.md, // 12px from Figma
  });

  final List<Widget> children;
  final AppButtonGroupAlignment alignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (alignment == AppButtonGroupAlignment.stack) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) Gap(spacing),
            children[i],
          ],
        ],
      );
    }

    final mainAxisAlignment = switch (alignment) {
      AppButtonGroupAlignment.justify => MainAxisAlignment.spaceBetween,
      AppButtonGroupAlignment.start => MainAxisAlignment.start,
      AppButtonGroupAlignment.end => MainAxisAlignment.end,
      AppButtonGroupAlignment.center => MainAxisAlignment.center,
      AppButtonGroupAlignment.stack => MainAxisAlignment.start,
    };

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (alignment != AppButtonGroupAlignment.justify && i > 0)
            Gap(spacing),
          children[i],
        ],
      ],
    );
  }
}

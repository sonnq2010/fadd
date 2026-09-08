import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppDividerOrientation { horizontal, vertical }

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.orientation = AppDividerOrientation.horizontal,
    this.label,
    this.thickness = 1.0,
  });

  final AppDividerOrientation orientation;
  final String? label;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    if (orientation == AppDividerOrientation.vertical) {
      return Container(
        width: thickness,
        color: colors.border.subtle,
      );
    }

    if (label != null && label!.isNotEmpty) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: thickness,
              color: colors.border.subtle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              label!,
              style: typography.caption.withColor(colors.text.tertiary),
            ),
          ),
          Expanded(
            child: Container(
              height: thickness,
              color: colors.border.subtle,
            ),
          ),
        ],
      );
    }

    return Container(
      height: thickness,
      color: colors.border.subtle,
    );
  }
}

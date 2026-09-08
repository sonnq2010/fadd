import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppBadgeVariant {
  neutral,
  brand,
  secondary,
  success,
  warning,
  error,
  info,
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
  });

  final String label;
  final AppBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color backgroundColor;
    final Color textColor;

    switch (variant) {
      case AppBadgeVariant.neutral:
        backgroundColor = colors.background.tertiary;
        textColor = colors.text.secondary;
      case AppBadgeVariant.brand:
        backgroundColor = colors.background.brandSubtle;
        textColor = colors.text.brand;
      case AppBadgeVariant.secondary:
        backgroundColor = AppPrimitives.violet50;
        textColor = AppPrimitives.violet600;
      case AppBadgeVariant.success:
        backgroundColor = colors.background.successSubtle;
        textColor = colors.text.success;
      case AppBadgeVariant.warning:
        backgroundColor = colors.background.warningSubtle;
        textColor = colors.text.warning;
      case AppBadgeVariant.error:
        backgroundColor = colors.background.errorSubtle;
        textColor = colors.text.error;
      case AppBadgeVariant.info:
        backgroundColor = colors.background.infoSubtle;
        textColor = colors.text.info;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        label,
        style: typography.labelSmall.withColor(textColor),
      ),
    );
  }
}

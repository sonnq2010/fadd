import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppAlertVariant {
  success,
  warning,
  error,
  info,
}

class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.message,
    this.variant = AppAlertVariant.success,
    this.showClose = true,
    this.onClose,
    this.leadingIcon,
  });

  final String message;
  final AppAlertVariant variant;
  final bool showClose;
  final VoidCallback? onClose;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color backgroundColor;
    final Color iconColor;
    final IconData defaultIcon;

    switch (variant) {
      case AppAlertVariant.success:
        backgroundColor = colors.background.successSubtle;
        iconColor = colors.icon.success;
        defaultIcon = LucideIcons.circleCheck;
      case AppAlertVariant.warning:
        backgroundColor = colors.background.warningSubtle;
        iconColor = colors.icon.warning;
        defaultIcon = LucideIcons.triangleAlert;
      case AppAlertVariant.error:
        backgroundColor = colors.background.errorSubtle;
        iconColor = colors.icon.error;
        defaultIcon = LucideIcons.circleAlert;
      case AppAlertVariant.info:
        backgroundColor = colors.background.infoSubtle;
        iconColor = colors.icon.info;
        defaultIcon = LucideIcons.info;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingIcon ??
              Icon(
                defaultIcon,
                size: 20.0,
                color: iconColor,
              ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: typography.bodySmall.withColor(colors.text.primary),
            ),
          ),
          if (showClose) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onClose,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  LucideIcons.x,
                  size: 16.0,
                  color: colors.icon.secondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

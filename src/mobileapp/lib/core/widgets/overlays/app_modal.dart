import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';

class AppModalCard extends StatelessWidget {
  const AppModalCard({
    super.key,
    required this.title,
    this.description,
    this.content,
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Delete',
    this.onClose,
    this.onCancel,
    this.onConfirm,
    this.footer,
    this.isDestructive = true,
  });

  final String title;
  final String? description;
  final Widget? content;
  final String cancelLabel;
  final String confirmLabel;
  final VoidCallback? onClose;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final Widget? footer;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400.0),
      decoration: BoxDecoration(
        color: colors.background.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.md,
              top: AppSpacing.lg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: typography.headingH3.withColor(colors.text.primary),
                  ),
                ),
                if (onClose != null)
                  AppIconButton.ghost(
                    icon: LucideIcons.x,
                    size: AppButtonSize.small,
                    semanticLabel: 'Close modal',
                    onPressed: onClose,
                  ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.sm,
              bottom: AppSpacing.xl,
            ),
            child:
                content ??
                Text(
                  description ?? '',
                  style: typography.bodyMedium.withColor(colors.text.secondary),
                ),
          ),

          // Footer
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colors.border.subtle,
                  width: 1.0,
                ),
              ),
            ),
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            child:
                footer ??
                AppButtonGroup(
                  alignment: AppButtonGroupAlignment.justify,
                  children: [
                    AppButton.secondary(
                      label: cancelLabel,
                      size: AppButtonSize.small,
                      onPressed: onCancel,
                    ),
                    if (isDestructive)
                      AppButton.destructive(
                        label: confirmLabel,
                        size: AppButtonSize.small,
                        onPressed: onConfirm,
                      )
                    else
                      AppButton.primary(
                        label: confirmLabel,
                        size: AppButtonSize.small,
                        onPressed: onConfirm,
                      ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showAppModal<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
}) {
  final colors = context.colors;
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: colors.overlay.scrim,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Center(child: child),
    ),
  );
}

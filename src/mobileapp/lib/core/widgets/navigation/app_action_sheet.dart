import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/navigation/app_menu_item.dart';

class AppActionSheetItem {
  const AppActionSheetItem({
    required this.label,
    this.leadingIcon,
    this.destructive = false,
    this.disabled = false,
    this.onTap,
  });

  final String label;
  final Widget? leadingIcon;
  final bool destructive;
  final bool disabled;
  final VoidCallback? onTap;
}

class AppActionSheet extends StatelessWidget {
  const AppActionSheet({
    super.key,
    required this.actions,
    this.cancelLabel = 'Cancel',
    this.onCancel,
  });

  final List<AppActionSheetItem> actions;
  final String cancelLabel;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 375.0,
      decoration: BoxDecoration(
        color: colors.background.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          topRight: Radius.circular(AppRadius.lg),
        ),
        boxShadow: AppShadows.xl,
      ),
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 24.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle
          Container(
            width: 36.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: colors.border.strong,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          const Gap(AppSpacing.md),
          // Actions list
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final action in actions)
                SizedBox(
                  width: double.infinity,
                  child: AppMenuItem(
                    label: action.label,
                    leadingIcon: action.leadingIcon,
                    destructive: action.destructive,
                    disabled: action.disabled,
                    onTap: action.onTap,
                  ),
                ),
            ],
          ),
          const Gap(AppSpacing.md),
          // Cancel button
          SizedBox(
            width: double.infinity,
            child: AppButton.secondary(
              label: cancelLabel,
              size: AppButtonSize.large,
              onPressed: onCancel ?? () => Navigator.of(context).maybePop(),
            ),
          ),
        ],
      ),
    );
  }
}

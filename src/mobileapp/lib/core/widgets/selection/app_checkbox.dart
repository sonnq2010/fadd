import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';

enum AppCheckboxValue { unchecked, checked, indeterminate }

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    this.value = AppCheckboxValue.unchecked,
    this.onChanged,
    this.label,
    this.enabled = true,
  });

  final AppCheckboxValue value;
  final ValueChanged<AppCheckboxValue>? onChanged;
  final String? label;
  final bool enabled;

  void _handleTap() {
    if (!enabled || onChanged == null) return;
    switch (value) {
      case AppCheckboxValue.unchecked:
        onChanged!(AppCheckboxValue.checked);
        break;
      case AppCheckboxValue.checked:
        onChanged!(AppCheckboxValue.unchecked);
        break;
      case AppCheckboxValue.indeterminate:
        onChanged!(AppCheckboxValue.checked);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Color boxBgColor;
    Border? border;
    Color iconColor;

    if (!enabled) {
      if (value == AppCheckboxValue.unchecked) {
        boxBgColor = colors.background.disabled;
        border = Border.all(color: colors.border.disabled, width: 1.5);
        iconColor = Colors.transparent;
      } else {
        boxBgColor = colors.background.disabled;
        border = null;
        iconColor = colors.icon.disabled;
      }
    } else {
      if (value == AppCheckboxValue.unchecked) {
        boxBgColor = colors.background.primary;
        border = Border.all(color: colors.border.defaultColor, width: 1.5);
        iconColor = Colors.transparent;
      } else {
        boxBgColor = colors.background.brand;
        border = null;
        iconColor = colors.text.onBrand;
      }
    }

    final labelColor = enabled ? colors.text.primary : colors.text.disabled;

    return GestureDetector(
      onTap: enabled ? _handleTap : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: boxBgColor,
              borderRadius: BorderRadius.circular(AppRadius.xs), // 2px radius
              border: border,
            ),
            alignment: Alignment.center,
            child: value == AppCheckboxValue.checked
                ? Icon(LucideIcons.check, size: 14, color: iconColor)
                : value == AppCheckboxValue.indeterminate
                ? Icon(LucideIcons.minus, size: 14, color: iconColor)
                : null,
          ),
          if (label != null) ...[
            const Gap(8),
            Text(
              label!,
              style: typography.bodyMedium.withColor(labelColor),
            ),
          ],
        ],
      ),
    );
  }
}

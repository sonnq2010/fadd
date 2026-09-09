import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool enabled;

  bool get isSelected => value == groupValue;

  void _handleTap() {
    if (!enabled || onChanged == null) return;
    onChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Color outerBorderColor;
    Color outerBgColor;
    Color innerCircleColor;

    if (!enabled) {
      outerBgColor = colors.background.primary;
      outerBorderColor = colors.border.disabled;
      innerCircleColor = isSelected ? colors.icon.disabled : Colors.transparent;
    } else {
      outerBgColor = colors.background.primary;
      outerBorderColor = isSelected
          ? colors.border.brand
          : colors.border.defaultColor;
      innerCircleColor = isSelected
          ? colors.background.brand
          : Colors.transparent;
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
              shape: BoxShape.circle,
              color: outerBgColor,
              border: Border.all(color: outerBorderColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: isSelected
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: innerCircleColor,
                    ),
                  )
                : null,
          ),
          if (label != null) ...[
            const Gap(AppSpacing.sm),
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

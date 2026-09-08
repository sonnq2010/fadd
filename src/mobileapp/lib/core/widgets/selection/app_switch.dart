import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool enabled;

  void _handleTap() {
    if (!enabled || onChanged == null) return;
    onChanged!(!value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color trackColor;
    if (!enabled) {
      trackColor = colors.background.disabled;
    } else if (value) {
      trackColor = colors.background.brand;
    } else {
      trackColor = colors.border.strong;
    }

    final labelColor = enabled ? colors.text.primary : colors.text.disabled;

    return GestureDetector(
      onTap: enabled ? _handleTap : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 40,
            height: 22,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(11),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPrimitives.white1000,
                ),
              ),
            ),
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

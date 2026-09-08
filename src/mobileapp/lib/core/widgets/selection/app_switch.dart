import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

class AppSwitch extends StatefulWidget {
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

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool _isHovered = false;

  void _handleTap() {
    if (!widget.enabled || widget.onChanged == null) return;
    widget.onChanged!(!widget.value);
  }

  void _setHovered(bool value) {
    if (_isHovered != value) {
      setState(() => _isHovered = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final Color trackColor;
    if (!widget.enabled) {
      trackColor = colors.background.disabled;
    } else if (widget.value) {
      trackColor = _isHovered
          ? colors.background.brandHover
          : colors.background.brand;
    } else {
      trackColor = colors.border.strong;
    }

    final labelColor = widget.enabled
        ? colors.text.primary
        : colors.text.disabled;

    return MouseRegion(
      cursor: widget.enabled && widget.onChanged != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: widget.enabled ? (_) => _setHovered(true) : null,
      onExit: widget.enabled ? (_) => _setHovered(false) : null,
      child: GestureDetector(
        onTap: widget.enabled ? _handleTap : null,
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
                alignment: widget.value
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.icon.onBrand,
                  ),
                ),
              ),
            ),
            if (widget.label != null) ...[
              const Gap(8),
              Text(
                widget.label!,
                style: typography.bodySmall.withColor(labelColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

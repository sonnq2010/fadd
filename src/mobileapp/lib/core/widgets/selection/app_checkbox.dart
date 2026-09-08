import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';

enum AppCheckboxValue { unchecked, checked, indeterminate }

class AppCheckbox extends StatefulWidget {
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

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool _isHovered = false;

  void _handleTap() {
    if (!widget.enabled || widget.onChanged == null) return;
    switch (widget.value) {
      case AppCheckboxValue.unchecked:
        widget.onChanged!(AppCheckboxValue.checked);
        break;
      case AppCheckboxValue.checked:
        widget.onChanged!(AppCheckboxValue.unchecked);
        break;
      case AppCheckboxValue.indeterminate:
        widget.onChanged!(AppCheckboxValue.checked);
        break;
    }
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

    Color boxBgColor;
    Border? border;
    Color iconColor;

    if (!widget.enabled) {
      boxBgColor = colors.background.disabled;
      border = widget.value == AppCheckboxValue.unchecked
          ? Border.all(color: colors.border.disabled, width: 1.5)
          : null;
      iconColor = widget.value == AppCheckboxValue.unchecked
          ? Colors.transparent
          : colors.icon.disabled;
    } else if (widget.value == AppCheckboxValue.unchecked) {
      boxBgColor = colors.background.primary;
      border = Border.all(
        color: _isHovered ? colors.border.brand : colors.border.defaultColor,
        width: 1.5,
      );
      iconColor = Colors.transparent;
    } else {
      boxBgColor = _isHovered
          ? colors.background.brandHover
          : colors.background.brand;
      border = null;
      iconColor = colors.text.onBrand;
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
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: boxBgColor,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: border,
              ),
              alignment: Alignment.center,
              child: widget.value == AppCheckboxValue.checked
                  ? Icon(LucideIcons.check, size: 14, color: iconColor)
                  : widget.value == AppCheckboxValue.indeterminate
                  ? Icon(LucideIcons.minus, size: 14, color: iconColor)
                  : null,
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

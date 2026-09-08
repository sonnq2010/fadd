import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';

enum AppSelectSize { large, medium, small }

class AppSelectItem<T> {
  const AppSelectItem({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final String label;
  final bool enabled;
}

class AppSelect<T> extends StatefulWidget {
  const AppSelect({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = AppSelectSize.medium,
    this.enabled = true,
  });

  final List<AppSelectItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final AppSelectSize size;
  final bool enabled;

  @override
  State<AppSelect<T>> createState() => _AppSelectState<T>();
}

class _AppSelectState<T> extends State<AppSelect<T>> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocus);
  }

  void _handleFocus() {
    if (mounted && _isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocus);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final tokens = _selectTokens[widget.size]!;

    final isError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isEnabled = widget.enabled;

    final labelStyle = widget.size == AppSelectSize.small
        ? typography.labelSmall
        : typography.labelMedium;
    final labelColor = isEnabled ? colors.text.secondary : colors.text.disabled;

    Color borderColor;
    List<BoxShadow>? boxShadow;
    if (!isEnabled) {
      borderColor = colors.border.disabled;
      boxShadow = null;
    } else if (isError) {
      borderColor = colors.border.error;
      boxShadow = null;
    } else if (_isFocused) {
      borderColor = colors.border.brand;
      boxShadow = AppShadows.focusRing;
    } else {
      borderColor = colors.border.defaultColor;
      boxShadow = null;
    }

    final backgroundColor = isEnabled
        ? colors.background.primary
        : colors.background.disabled;

    final iconColor = !isEnabled
        ? colors.icon.disabled
        : isError
        ? colors.text.error
        : colors.icon.secondary;

    TextStyle textStyle;
    switch (widget.size) {
      case AppSelectSize.large:
        textStyle = typography.bodyLarge;
        break;
      case AppSelectSize.medium:
        textStyle = typography.bodyMedium;
        break;
      case AppSelectSize.small:
        textStyle = typography.bodySmall;
        break;
    }

    final selectedItem = widget.items
        .where((i) => i.value == widget.value)
        .firstOrNull;
    final hasValue = selectedItem != null;
    final displayText = hasValue
        ? selectedItem.label
        : (widget.placeholder ?? '');
    final textColor = !isEnabled
        ? colors.text.disabled
        : hasValue
        ? colors.text.primary
        : colors.text.placeholder;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: labelStyle.withColor(labelColor),
          ),
          const Gap(6),
        ],
        Container(
          height: tokens.height,
          padding: tokens.padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(tokens.radius),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: boxShadow,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              focusNode: _focusNode,
              value: widget.value,
              isExpanded: true,
              isDense: true,
              hint: Text(
                displayText,
                style: textStyle.withColor(textColor),
                overflow: TextOverflow.ellipsis,
              ),
              icon: Icon(
                LucideIcons.chevronDown,
                size: 16,
                color: iconColor,
              ),
              dropdownColor: colors.background.primary,
              borderRadius: BorderRadius.circular(AppRadius.md),
              items: widget.items.map((item) {
                return DropdownMenuItem<T>(
                  value: item.value,
                  enabled: item.enabled,
                  child: Text(
                    item.label,
                    style: textStyle.withColor(
                      item.enabled ? colors.text.primary : colors.text.disabled,
                    ),
                  ),
                );
              }).toList(),
              onChanged: isEnabled ? widget.onChanged : null,
            ),
          ),
        ),
        if (isError) ...[
          const Gap(6),
          Text(
            widget.errorText!,
            style: typography.caption.withColor(colors.text.error),
          ),
        ] else if (widget.helperText != null) ...[
          const Gap(6),
          Text(
            widget.helperText!,
            style: typography.caption.withColor(
              isEnabled ? colors.text.tertiary : colors.text.disabled,
            ),
          ),
        ],
      ],
    );
  }
}

class _SelectTokens {
  const _SelectTokens({
    required this.height,
    required this.radius,
    required this.padding,
  });

  final double height;
  final double radius;
  final EdgeInsets padding;
}

const Map<AppSelectSize, _SelectTokens> _selectTokens = {
  AppSelectSize.large: _SelectTokens(
    height: 48,
    radius: AppRadius.md,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  AppSelectSize.medium: _SelectTokens(
    height: 40,
    radius: AppRadius.md,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  ),
  AppSelectSize.small: _SelectTokens(
    height: 36,
    radius: AppRadius.sm,
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),
};

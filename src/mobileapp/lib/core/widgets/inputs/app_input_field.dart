import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/app_focus_ring.dart';

/// Text input field for forms:
/// Sizes: Small (36px), Medium (40px), Large (48px), all with 8px radius.
/// States: Default, Focus, Filled, Error, Disabled.
/// Features: label, helper / error text, leading / trailing icon.

enum AppInputSize { large, medium, small }

class AppInputField extends StatefulWidget {
  const AppInputField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.size = AppInputSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final AppInputSize size;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isInternalFocusNode = false;
  bool _isInternalController = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _isInternalFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }
    _focusNode.addListener(_handleFocusChange);

    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
      _isInternalController = true;
    } else {
      _controller = widget.controller!;
    }
  }

  void _handleFocusChange() {
    if (mounted && _isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_isInternalFocusNode) {
      _focusNode.dispose();
    }
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final tokens = _inputTokens[widget.size]!;

    final isError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isEnabled = widget.enabled;

    // Label style
    final labelStyle = widget.size == AppInputSize.small
        ? typography.labelSmall
        : typography.labelMedium;
    final labelColor = isEnabled ? colors.text.secondary : colors.text.disabled;

    // Border & Shadow
    final Color borderColor;
    if (!isEnabled) {
      borderColor = colors.border.disabled;
    } else if (isError) {
      borderColor = colors.border.error;
    } else if (_isFocused) {
      borderColor = colors.border.focus;
    } else {
      borderColor = colors.border.defaultColor;
    }

    final backgroundColor = isEnabled
        ? colors.background.primary
        : colors.background.disabled;

    // Icon colors
    final iconColor = !isEnabled
        ? colors.icon.disabled
        : isError
        ? colors.text.error
        : colors.icon.secondary;

    // Text Style
    TextStyle textStyle;
    switch (widget.size) {
      case AppInputSize.large:
        textStyle = typography.bodyMedium;
        break;
      case AppInputSize.medium:
      case AppInputSize.small:
        textStyle = typography.bodySmall;
        break;
    }

    final textColor = isEnabled ? colors.text.primary : colors.text.disabled;
    final hintColor = isEnabled
        ? colors.text.placeholder
        : colors.text.disabled;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: labelStyle.withColor(labelColor),
          ),
          const Gap(AppSpacing.xs),
        ],
        AppFocusRing(
          visible: isEnabled && !isError && _isFocused,
          radius: tokens.radius,
          child: Container(
            height: tokens.height,
            padding: tokens.padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(tokens.radius),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leadingIcon != null) ...[
                  Icon(
                    widget.leadingIcon,
                    size: 16, // 16px icon from Figma
                    color: iconColor,
                  ),
                  const Gap(AppSpacing.sm), // 8px gap
                ],
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: isEnabled,
                    readOnly: widget.readOnly,
                    obscureText: widget.obscureText,
                    autofocus: widget.autofocus,
                    keyboardType: widget.keyboardType,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: textStyle.withColor(textColor),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: textStyle.withColor(hintColor),
                    ),
                  ),
                ),
                if (widget.trailingIcon != null) ...[
                  const Gap(AppSpacing.sm), // 8px gap
                  GestureDetector(
                    onTap: isEnabled ? widget.onTrailingIconPressed : null,
                    child: Icon(
                      widget.trailingIcon,
                      size: 16, // 16px icon from Figma
                      color: iconColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (isError) ...[
          const Gap(AppSpacing.xs),
          Text(
            widget.errorText!,
            style: typography.caption.withColor(colors.text.error),
          ),
        ] else if (widget.helperText != null) ...[
          const Gap(AppSpacing.xs),
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

class _InputTokens {
  const _InputTokens({
    required this.height,
    required this.radius,
    required this.padding,
  });

  final double height;
  final double radius;
  final EdgeInsets padding;
}

const Map<AppInputSize, _InputTokens> _inputTokens = {
  AppInputSize.large: _InputTokens(
    height: 48,
    radius: AppRadius.md, // 8px from Figma
    padding: EdgeInsets.symmetric(horizontal: 16),
  ),
  AppInputSize.medium: _InputTokens(
    height: 40,
    radius: AppRadius.md, // 8px from Figma
    padding: EdgeInsets.symmetric(horizontal: 12),
  ),
  AppInputSize.small: _InputTokens(
    height: 36,
    radius: AppRadius.md, // 8px from Figma
    padding: EdgeInsets.symmetric(horizontal: 8),
  ),
};

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/app_focus_ring.dart';

class AppTextareaField extends StatefulWidget {
  const AppTextareaField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.minLines = 3,
    this.maxLines = 5,
    this.minHeight = 96.0,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final int minLines;
  final int? maxLines;
  final double minHeight;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  State<AppTextareaField> createState() => _AppTextareaFieldState();
}

class _AppTextareaFieldState extends State<AppTextareaField> {
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
    final isError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isEnabled = widget.enabled;

    final labelStyle = typography.labelMedium;
    final labelColor = isEnabled ? colors.text.secondary : colors.text.disabled;

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
          radius: AppRadius.md,
          child: Container(
            constraints: BoxConstraints(minHeight: widget.minHeight),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: isEnabled,
              readOnly: widget.readOnly,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              keyboardType: TextInputType.multiline,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: typography.bodySmall.withColor(textColor),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: typography.bodySmall.withColor(hintColor),
              ),
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

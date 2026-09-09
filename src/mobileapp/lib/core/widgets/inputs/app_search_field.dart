import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/app_focus_ring.dart';

enum AppSearchFieldSize { large, medium, small }

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.initialValue,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.size = AppSearchFieldSize.medium,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final AppSearchFieldSize size;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isInternalFocusNode = false;
  bool _isInternalController = false;
  bool _isFocused = false;
  bool _hasText = false;

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
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    if (mounted && _isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _handleTextChange() {
    final nowHasText = _controller.text.isNotEmpty;
    if (mounted && _hasText != nowHasText) {
      setState(() {
        _hasText = nowHasText;
      });
    }
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
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
    final tokens = _searchTokens[widget.size]!;
    final isEnabled = widget.enabled;

    final Color borderColor;
    if (!isEnabled) {
      borderColor = colors.border.disabled;
    } else if (_isFocused) {
      borderColor = colors.border.focus;
    } else {
      borderColor = colors.border.defaultColor;
    }

    final backgroundColor = isEnabled
        ? colors.background.primary
        : colors.background.disabled;

    final iconColor = isEnabled ? colors.icon.secondary : colors.icon.disabled;

    TextStyle textStyle;
    switch (widget.size) {
      case AppSearchFieldSize.large:
        textStyle = typography.bodyMedium;
        break;
      case AppSearchFieldSize.medium:
      case AppSearchFieldSize.small:
        textStyle = typography.bodySmall;
        break;
    }

    final textColor = isEnabled ? colors.text.primary : colors.text.disabled;
    final hintColor = isEnabled
        ? colors.text.placeholder
        : colors.text.disabled;

    return AppFocusRing(
      visible: isEnabled && _isFocused,
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
            Icon(
              LucideIcons.search,
              size: 16,
              color: iconColor,
            ),
            const Gap(AppSpacing.sm),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: isEnabled,
                autofocus: widget.autofocus,
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
            if (_hasText && isEnabled) ...[
              const Gap(AppSpacing.sm),
              GestureDetector(
                onTap: _clear,
                child: Icon(
                  LucideIcons.x,
                  size: 16,
                  color: iconColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SearchTokens {
  const _SearchTokens({
    required this.height,
    required this.radius,
    required this.padding,
  });

  final double height;
  final double radius;
  final EdgeInsets padding;
}

const Map<AppSearchFieldSize, _SearchTokens> _searchTokens = {
  AppSearchFieldSize.large: _SearchTokens(
    height: 48,
    radius: AppRadius.md,
    padding: EdgeInsets.symmetric(horizontal: 16),
  ),
  AppSearchFieldSize.medium: _SearchTokens(
    height: 40,
    radius: AppRadius.md,
    padding: EdgeInsets.symmetric(horizontal: 12),
  ),
  AppSearchFieldSize.small: _SearchTokens(
    height: 36,
    radius: AppRadius.md,
    padding: EdgeInsets.symmetric(horizontal: 8),
  ),
};

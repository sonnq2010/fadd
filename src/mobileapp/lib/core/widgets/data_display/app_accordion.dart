import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppAccordionItem extends StatefulWidget {
  const AppAccordionItem({
    super.key,
    required this.title,
    this.description,
    this.content,
    this.initiallyExpanded = false,
    this.isExpanded,
    this.onExpansionChanged,
  });

  final String title;
  final String? description;
  final Widget? content;
  final bool initiallyExpanded;
  final bool? isExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<AppAccordionItem> createState() => _AppAccordionItemState();
}

class _AppAccordionItemState extends State<AppAccordionItem>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded ?? widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: _expanded ? 1.0 : 0.0,
    );
    _iconTurns = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.5).chain(
        CurveTween(curve: Curves.easeInOut),
      ),
    );
    _heightFactor = _controller.drive(
      CurveTween(curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AppAccordionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != null && widget.isExpanded != _expanded) {
      _setExpanded(widget.isExpanded!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setExpanded(bool expanded) {
    setState(() {
      _expanded = expanded;
    });
    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleTap() {
    final next = !_expanded;
    _setExpanded(next);
    widget.onExpansionChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background.primary,
        border: Border(
          bottom: BorderSide(
            color: colors.border.defaultColor,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _handleTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: typography.labelMedium.withColor(
                        colors.text.primary,
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      LucideIcons.chevronDown,
                      size: 18.0,
                      color: colors.icon.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                if (_controller.value == 0.0) {
                  return const SizedBox.shrink();
                }
                return Align(
                  heightFactor: _heightFactor.value,
                  alignment: Alignment.topCenter,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child:
                    widget.content ??
                    Text(
                      widget.description ?? '',
                      style: typography.bodySmall.withColor(
                        colors.text.secondary,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

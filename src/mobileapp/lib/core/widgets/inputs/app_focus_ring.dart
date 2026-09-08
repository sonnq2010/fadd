import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

class AppFocusRing extends StatelessWidget {
  const AppFocusRing({
    super.key,
    required this.visible,
    required this.radius,
    required this.child,
    this.width = 3,
  });

  final bool visible;
  final double radius;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ringColor = context.colors.border.focus.withValues(alpha: 0.45);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (visible)
          Positioned(
            left: -width,
            top: -width,
            right: -width,
            bottom: -width,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius + width),
                  border: Border.all(color: ringColor, width: width),
                ),
              ),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: child,
        ),
      ],
    );
  }
}

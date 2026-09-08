import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

enum AppTooltipPosition {
  top,
  bottom,
  left,
  right,
}

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = AppTooltipPosition.top,
  });

  final String message;
  final Widget child;
  final AppTooltipPosition position;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: colors.background.inverse,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      textStyle: typography.caption.withColor(colors.text.inverse),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      preferBelow: position == AppTooltipPosition.bottom,
      child: child,
    );
  }
}

class AppTooltipBubble extends StatelessWidget {
  const AppTooltipBubble({
    super.key,
    required this.label,
    this.position = AppTooltipPosition.top,
  });

  final String label;
  final AppTooltipPosition position;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final body = Container(
      decoration: BoxDecoration(
        color: colors.background.inverse,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        label,
        style: typography.caption.withColor(colors.text.inverse),
      ),
    );

    final arrow = CustomPaint(
      size:
          position == AppTooltipPosition.top ||
              position == AppTooltipPosition.bottom
          ? const Size(10.0, 6.0)
          : const Size(6.0, 10.0),
      painter: _TooltipArrowPainter(
        color: colors.background.inverse,
        position: position,
      ),
    );

    switch (position) {
      case AppTooltipPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            body,
            arrow,
          ],
        );
      case AppTooltipPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            arrow,
            body,
          ],
        );
      case AppTooltipPosition.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            body,
            arrow,
          ],
        );
      case AppTooltipPosition.right:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            arrow,
            body,
          ],
        );
    }
  }
}

class _TooltipArrowPainter extends CustomPainter {
  const _TooltipArrowPainter({
    required this.color,
    required this.position,
  });

  final Color color;
  final AppTooltipPosition position;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    switch (position) {
      case AppTooltipPosition.top:
        // Points down
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
        break;
      case AppTooltipPosition.bottom:
        // Points up
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
      case AppTooltipPosition.left:
        // Points right
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case AppTooltipPosition.right:
        // Points left
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.position != position;
  }
}

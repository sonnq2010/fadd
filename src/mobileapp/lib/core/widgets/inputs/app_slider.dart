import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

class _AppSliderThumbShape extends SliderComponentShape {
  const _AppSliderThumbShape({
    this.enabledThumbRadius = 8.0,
    this.borderWidth = 2.0,
    required this.fillColor,
    required this.borderColor,
  });

  final double enabledThumbRadius;
  final double borderWidth;
  final Color fillColor;
  final Color borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, strokePaint);
  }
}

class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final activeTrackColor = enabled
        ? colors.background.brand
        : colors.background.secondary;
    final inactiveTrackColor = enabled
        ? colors.border.strong
        : colors.background.secondary;
    final disabledTrackColor = colors.background.secondary;
    final thumbBorderColor = enabled
        ? colors.border.brand
        : colors.border.defaultColor;
    final thumbFillColor = colors.background.primary;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 4.0,
        trackShape: const RoundedRectSliderTrackShape(),
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        disabledActiveTrackColor: disabledTrackColor,
        disabledInactiveTrackColor: disabledTrackColor,
        thumbShape: _AppSliderThumbShape(
          enabledThumbRadius: 8.0,
          borderWidth: 2.0,
          fillColor: thumbFillColor,
          borderColor: thumbBorderColor,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
        overlayColor: colors.overlay.hover,
      ),
      child: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}

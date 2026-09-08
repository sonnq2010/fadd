import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppTooltipBubble renders label for all 4 positions', (
    tester,
  ) async {
    for (final pos in AppTooltipPosition.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppTooltipBubble(
            label: 'Tooltip ${pos.name}',
            position: pos,
          ),
        ),
      );

      expect(find.text('Tooltip ${pos.name}'), findsOneWidget);
      expect(find.byType(AppTooltipBubble), findsOneWidget);
    }
  });

  testWidgets('AppTooltip wraps child widget and shows tooltip on long press', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppTooltip(
          message: 'Help text',
          child: Text('Hover target'),
        ),
      ),
    );

    expect(find.text('Hover target'), findsOneWidget);

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Hover target')),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Help text'), findsOneWidget);
    await gesture.up();
  });
}

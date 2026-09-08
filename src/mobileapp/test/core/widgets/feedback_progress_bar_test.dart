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

  testWidgets('AppProgressBar renders all 3 states with label and percentage', (
    tester,
  ) async {
    for (final state in AppProgressBarState.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppProgressBar(
            value: 0.6,
            state: state,
            label: 'Uploading file.pdf',
          ),
        ),
      );

      expect(find.text('Uploading file.pdf'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
      expect(find.byType(AppProgressBar), findsOneWidget);
    }
  });

  testWidgets('AppProgressBar hides label when showLabel is false', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppProgressBar(
          value: 0.6,
          label: 'Hidden label',
          showLabel: false,
        ),
      ),
    );

    expect(find.text('Hidden label'), findsNothing);
  });
}

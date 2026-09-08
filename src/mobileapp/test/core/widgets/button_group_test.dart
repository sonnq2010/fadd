import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppButtonGroup Tests', () {
    testWidgets('renders children buttons correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppButtonGroup(
            alignment: AppButtonGroupAlignment.justify,
            children: [
              AppButton.secondary(label: 'Cancel', onPressed: () {}),
              AppButton.primary(label: 'Confirm', onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(AppButtonGroup), findsOneWidget);
    });

    testWidgets('renders column in stack alignment', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppButtonGroup(
            alignment: AppButtonGroupAlignment.stack,
            children: [
              AppButton.secondary(label: 'Cancel', onPressed: () {}),
              AppButton.primary(label: 'Confirm', onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('supports all 5 alignments without error', (tester) async {
      for (final alignment in AppButtonGroupAlignment.values) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppButtonGroup(
              alignment: alignment,
              children: [
                AppButton.secondary(label: 'Cancel', onPressed: () {}),
                AppButton.primary(label: 'Confirm', onPressed: () {}),
              ],
            ),
          ),
        );

        expect(find.byType(AppButtonGroup), findsOneWidget);
      }
    });
  });
}

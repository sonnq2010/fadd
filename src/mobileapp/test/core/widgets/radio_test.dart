import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/selection/selection.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppRadio Tests', () {
    testWidgets('renders unselected radio with label', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppRadio<int>(
            value: 1,
            groupValue: 2,
            label: 'Option 1',
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      // Outer 20x20 container exists, inner 10x10 doesn't
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('renders selected radio with inner indicator', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppRadio<int>(
            value: 1,
            groupValue: 1,
            label: 'Option 1',
            onChanged: (_) {},
          ),
        ),
      );

      // Outer and inner container exist
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('tapping unselected radio triggers onChanged with its value', (tester) async {
      int? selected;
      await tester.pumpWidget(
        buildTestableWidget(
          AppRadio<int>(
            value: 1,
            groupValue: 2,
            label: 'Select me',
            onChanged: (val) => selected = val,
          ),
        ),
      );

      await tester.tap(find.text('Select me'));
      expect(selected, 1);
    });

    testWidgets('disabled radio does not trigger onChanged', (tester) async {
      int? selected;
      await tester.pumpWidget(
        buildTestableWidget(
          AppRadio<int>(
            value: 1,
            groupValue: 2,
            label: 'Disabled option',
            enabled: false,
            onChanged: (val) => selected = val,
          ),
        ),
      );

      await tester.tap(find.text('Disabled option'));
      expect(selected, isNull);
    });
  });
}

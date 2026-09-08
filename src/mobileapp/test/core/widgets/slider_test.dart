import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: SizedBox(width: 240, child: widget))),
    );
  }

  group('AppSlider Tests', () {
    testWidgets('renders slider with initial value', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppSlider(
            value: 50.0,
            min: 0.0,
            max: 100.0,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(AppSlider), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('dragging slider triggers onChanged', (tester) async {
      double? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSlider(
            value: 0.0,
            min: 0.0,
            max: 100.0,
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.drag(find.byType(Slider), const Offset(100, 0));
      expect(updated, isNotNull);
      expect(updated!, greaterThan(0));
    });

    testWidgets('disabled slider does not trigger onChanged', (tester) async {
      double? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSlider(
            value: 50.0,
            min: 0.0,
            max: 100.0,
            enabled: false,
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.drag(find.byType(Slider), const Offset(100, 0));
      expect(updated, isNull);
    });
  });
}

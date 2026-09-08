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

  group('AppSwitch Tests', () {
    testWidgets('renders off switch with label', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppSwitch(
            value: false,
            label: 'Switch label',
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Switch label'), findsOneWidget);
      expect(find.byType(AppSwitch), findsOneWidget);
    });

    testWidgets('renders on switch with label', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppSwitch(
            value: true,
            label: 'Active switch',
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Active switch'), findsOneWidget);
      expect(find.byType(AppSwitch), findsOneWidget);
    });

    testWidgets('tapping off switch triggers onChanged with true', (tester) async {
      bool? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSwitch(
            value: false,
            label: 'Toggle me',
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.tap(find.text('Toggle me'));
      expect(updated, isTrue);
    });

    testWidgets('tapping on switch triggers onChanged with false', (tester) async {
      bool? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSwitch(
            value: true,
            label: 'Toggle me off',
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.tap(find.text('Toggle me off'));
      expect(updated, isFalse);
    });

    testWidgets('disabled switch does not trigger onChanged', (tester) async {
      bool? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSwitch(
            value: false,
            label: 'Disabled switch',
            enabled: false,
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.tap(find.text('Disabled switch'));
      expect(updated, isNull);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/selection/selection.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppCheckbox Tests', () {
    testWidgets('renders label and unchecked state', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppCheckbox(
            label: 'Accept terms',
            value: AppCheckboxValue.unchecked,
          ),
        ),
      );

      expect(find.text('Accept terms'), findsOneWidget);
      expect(find.byIcon(LucideIcons.check), findsNothing);
      expect(find.byIcon(LucideIcons.minus), findsNothing);
    });

    testWidgets('renders check icon when checked', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppCheckbox(
            value: AppCheckboxValue.checked,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.check), findsOneWidget);
    });

    testWidgets('renders minus icon when indeterminate', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppCheckbox(
            value: AppCheckboxValue.indeterminate,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.minus), findsOneWidget);
    });

    testWidgets('tapping unchecked checkbox triggers onChanged with checked', (
      tester,
    ) async {
      AppCheckboxValue? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppCheckbox(
            label: 'Remember me',
            value: AppCheckboxValue.unchecked,
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.tap(find.text('Remember me'));
      expect(updated, AppCheckboxValue.checked);
    });

    testWidgets('disabled checkbox does not trigger onChanged', (tester) async {
      AppCheckboxValue? updated;
      await tester.pumpWidget(
        buildTestableWidget(
          AppCheckbox(
            label: 'Disabled option',
            value: AppCheckboxValue.unchecked,
            enabled: false,
            onChanged: (val) => updated = val,
          ),
        ),
      );

      await tester.tap(find.text('Disabled option'));
      expect(updated, isNull);
    });

    testWidgets('uses body small label and brand hover states', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppCheckbox(
            label: 'Hover me',
            value: AppCheckboxValue.unchecked,
            onChanged: (_) {},
          ),
        ),
      );

      final label = tester.widget<Text>(find.text('Hover me'));
      expect(label.style?.fontSize, 14.0);

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byType(AppCheckbox)));
      await tester.pump();

      var box = tester.widget<Container>(
        find.descendant(
          of: find.byType(AppCheckbox),
          matching: find.byType(Container),
        ),
      );
      var decoration = box.decoration! as BoxDecoration;
      final colors = tester.element(find.byType(AppCheckbox)).colors;
      expect((decoration.border! as Border).top.color, colors.border.brand);

      await tester.pumpWidget(
        buildTestableWidget(
          AppCheckbox(
            value: AppCheckboxValue.checked,
            onChanged: (_) {},
          ),
        ),
      );
      await mouse.moveTo(tester.getCenter(find.byType(AppCheckbox)));
      await tester.pump();

      box = tester.widget<Container>(
        find.descendant(
          of: find.byType(AppCheckbox),
          matching: find.byType(Container),
        ),
      );
      decoration = box.decoration! as BoxDecoration;
      expect(decoration.color, colors.background.brandHover);
      await mouse.removePointer();
    });
  });
}

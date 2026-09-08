import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppButton Tests', () {
    testWidgets('renders label and triggers onPressed', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppButton.primary(
            label: 'Click Me',
            onPressed: () => pressed = true,
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
      await tester.tap(find.text('Click Me'));
      expect(pressed, isTrue);
    });

    testWidgets('disabled button does not trigger callback', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppButton.primary(
            label: 'Disabled',
            onPressed: null,
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders all 6 variants without error', (tester) async {
      final variants = [
        AppButton.primary(label: 'Primary', onPressed: () {}),
        AppButton.secondary(label: 'Secondary', onPressed: () {}),
        AppButton.outline(label: 'Outline', onPressed: () {}),
        AppButton.ghost(label: 'Ghost', onPressed: () {}),
        AppButton.destructive(label: 'Destructive', onPressed: () {}),
        AppButton.destructiveOutline(
          label: 'Destructive Outline',
          onPressed: () {},
        ),
      ];

      for (final btn in variants) {
        await tester.pumpWidget(buildTestableWidget(btn));
        expect(find.byType(AppButton), findsOneWidget);
      }
    });

    testWidgets('renders icons when provided', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppButton.secondary(
            label: 'With Icons',
            onPressed: () {},
            leadingIcon: LucideIcons.arrowLeft,
            trailingIcon: LucideIcons.arrowRight,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
      expect(find.byIcon(LucideIcons.arrowRight), findsOneWidget);
      expect(find.text('With Icons'), findsOneWidget);
    });
  });
}

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

  group('AppIconButton Tests', () {
    testWidgets('renders icon and triggers onPressed', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppIconButton.primary(
            icon: LucideIcons.plus,
            onPressed: () => pressed = true,
            semanticLabel: 'Add item',
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      await tester.tap(find.byType(AppIconButton));
      expect(pressed, isTrue);
    });

    testWidgets('disabled icon button does not trigger callback', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppIconButton.primary(
            icon: LucideIcons.plus,
            onPressed: null,
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders all 6 variants without error', (tester) async {
      final variants = [
        AppIconButton.primary(icon: LucideIcons.plus, onPressed: () {}),
        AppIconButton.secondary(icon: LucideIcons.plus, onPressed: () {}),
        AppIconButton.outline(icon: LucideIcons.plus, onPressed: () {}),
        AppIconButton.ghost(icon: LucideIcons.plus, onPressed: () {}),
        AppIconButton.destructive(icon: LucideIcons.plus, onPressed: () {}),
        AppIconButton.destructiveOutline(
          icon: LucideIcons.plus,
          onPressed: () {},
        ),
      ];

      for (final btn in variants) {
        await tester.pumpWidget(buildTestableWidget(btn));
        expect(find.byType(AppIconButton), findsOneWidget);
      }
    });

    testWidgets('renders sizes with correct dimensions', (tester) async {
      for (final (size, dimension) in [
        (AppButtonSize.large, 48.0),
        (AppButtonSize.medium, 40.0),
        (AppButtonSize.small, 36.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppIconButton.secondary(
              icon: LucideIcons.plus,
              onPressed: () {},
              size: size,
            ),
          ),
        );

        final renderBox = tester.renderObject<RenderBox>(
          find.byType(AppIconButton),
        );
        expect(renderBox.size.width, dimension);
        expect(renderBox.size.height, dimension);
      }
    });

    testWidgets('renders tooltip when provided', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppIconButton.ghost(
            icon: LucideIcons.plus,
            onPressed: () {},
            tooltip: 'Add item tooltip',
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
    });
  });
}

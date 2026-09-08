import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_color.dart';
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

    testWidgets('uses pressed backgrounds for every variant', (tester) async {
      for (final (theme, colors) in [
        (AppTheme.light, AppColors.light),
        (AppTheme.dark, AppColors.dark),
      ]) {
        final cases = <(Widget, Color)>[
          (
            AppButton.primary(label: 'Primary', onPressed: () {}),
            colors.background.brandPressed,
          ),
          (
            AppButton.secondary(label: 'Secondary', onPressed: () {}),
            colors.background.secondaryHover,
          ),
          (
            AppButton.outline(label: 'Outline', onPressed: () {}),
            colors.background.brandSubtle,
          ),
          (
            AppButton.ghost(label: 'Ghost', onPressed: () {}),
            colors.background.secondaryHover,
          ),
          (
            AppButton.destructive(label: 'Destructive', onPressed: () {}),
            colors.background.errorPressed,
          ),
          (
            AppButton.destructiveOutline(
              label: 'Destructive Outline',
              onPressed: () {},
            ),
            colors.background.errorSubtle,
          ),
        ];

        for (final (widget, expectedColor) in cases) {
          await tester.pumpWidget(buildTestableWidget(widget, theme: theme));
          await tester.pumpAndSettle();

          final button = tester.widget<ElevatedButton>(
            find.byType(ElevatedButton),
          );
          final actualColor = button.style?.backgroundColor?.resolve({
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          });

          expect(actualColor, expectedColor);
        }
      }
    });

    testWidgets('uses variant foreground colors for splash', (tester) async {
      for (final (theme, colors) in [
        (AppTheme.light, AppColors.light),
        (AppTheme.dark, AppColors.dark),
      ]) {
        final cases = <(Widget, Color)>[
          (
            AppButton.primary(label: 'Primary', onPressed: () {}),
            colors.text.onBrand,
          ),
          (
            AppButton.secondary(label: 'Secondary', onPressed: () {}),
            colors.text.primary,
          ),
          (
            AppButton.outline(label: 'Outline', onPressed: () {}),
            colors.text.brand,
          ),
          (
            AppButton.ghost(label: 'Ghost', onPressed: () {}),
            colors.text.primary,
          ),
          (
            AppButton.destructive(label: 'Destructive', onPressed: () {}),
            colors.text.onBrand,
          ),
          (
            AppButton.destructiveOutline(
              label: 'Destructive Outline',
              onPressed: () {},
            ),
            colors.text.error,
          ),
        ];

        for (final (widget, splashColor) in cases) {
          await tester.pumpWidget(buildTestableWidget(widget, theme: theme));
          await tester.pumpAndSettle();

          final button = tester.widget<ElevatedButton>(
            find.byType(ElevatedButton),
          );

          expect(
            button.style?.overlayColor?.resolve({WidgetState.pressed}),
            splashColor.withValues(alpha: 0.12),
          );
        }
      }
    });

    testWidgets('disabled background takes precedence over pressed', (
      tester,
    ) async {
      for (final (theme, colors) in [
        (AppTheme.light, AppColors.light),
        (AppTheme.dark, AppColors.dark),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            const AppButton.primary(label: 'Disabled', onPressed: null),
            theme: theme,
          ),
        );
        await tester.pumpAndSettle();

        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        final actualColor = button.style?.backgroundColor?.resolve({
          WidgetState.disabled,
          WidgetState.pressed,
          WidgetState.hovered,
        });

        expect(actualColor, colors.background.disabled);
      }
    });
  });
}

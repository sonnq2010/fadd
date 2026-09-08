import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/app_fab.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppFab Tests', () {
    testWidgets('renders icon and triggers onPressed', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppFab(
            icon: LucideIcons.plus,
            onPressed: () => pressed = true,
            semanticLabel: 'Add',
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      await tester.tap(find.byType(AppFab));
      expect(pressed, isTrue);
    });

    testWidgets('disabled FAB does not trigger callback', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppFab(
            icon: LucideIcons.plus,
            onPressed: null,
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders all 3 sizes with correct dimensions', (tester) async {
      for (final (size, dimension) in [
        (AppFabSize.large, 72.0),
        (AppFabSize.medium, 56.0),
        (AppFabSize.small, 40.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppFab(
              icon: LucideIcons.plus,
              onPressed: () {},
              size: size,
            ),
          ),
        );

        final renderBox = tester.renderObject<RenderBox>(find.byType(AppFab));
        expect(renderBox.size.width, dimension);
        expect(renderBox.size.height, dimension);
      }
    });

    testWidgets('renders tooltip when provided', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppFab(
            icon: LucideIcons.plus,
            onPressed: () {},
            tooltip: 'FAB tooltip',
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
    });

    testWidgets('uses semantic backgrounds for pressed and focused states', (
      tester,
    ) async {
      for (final (theme, colors) in [
        (AppTheme.light, AppColors.light),
        (AppTheme.dark, AppColors.dark),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppFab(icon: LucideIcons.plus, onPressed: () {}),
            theme: theme,
          ),
        );
        await tester.pumpAndSettle();

        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        final backgroundColor = button.style?.backgroundColor;

        expect(
          backgroundColor?.resolve({
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          }),
          colors.background.brandPressed,
        );
        expect(
          backgroundColor?.resolve({WidgetState.focused}),
          colors.background.brandHover,
        );
        expect(
          button.style?.overlayColor?.resolve({WidgetState.pressed}),
          colors.text.onBrand.withValues(alpha: 0.12),
        );
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
            const AppFab(icon: LucideIcons.plus, onPressed: null),
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

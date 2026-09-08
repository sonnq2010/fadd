import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(
        body: Center(child: SizedBox(width: 300, child: widget)),
      ),
    );
  }

  group('AppSearchField Tests', () {
    testWidgets('renders placeholder and leading search icon', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSearchField(
            placeholder: 'Search here...',
          ),
        ),
      );

      expect(find.text('Search here...'), findsOneWidget);
      expect(find.byIcon(LucideIcons.search), findsOneWidget);
      // No clear icon when empty
      expect(find.byIcon(LucideIcons.x), findsNothing);
    });

    testWidgets('shows clear icon when filled and clicking it clears text', (
      tester,
    ) async {
      var cleared = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppSearchField(
            initialValue: 'Hello search',
            onClear: () => cleared = true,
          ),
        ),
      );

      expect(find.text('Hello search'), findsOneWidget);
      expect(find.byIcon(LucideIcons.x), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pumpAndSettle();

      expect(cleared, isTrue);
      expect(find.text('Hello search'), findsNothing);
      expect(find.byIcon(LucideIcons.x), findsNothing);
    });

    testWidgets('disabled field disables underlying TextField', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSearchField(
            enabled: false,
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('renders all 3 sizes with correct container heights', (
      tester,
    ) async {
      for (final (size, expectedHeight) in [
        (AppSearchFieldSize.large, 48.0),
        (AppSearchFieldSize.medium, 40.0),
        (AppSearchFieldSize.small, 36.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppSearchField(size: size),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container),
        );
        expect(container.constraints?.maxHeight ?? 0, expectedHeight);
      }
    });

    testWidgets('uses revised radius and typography contracts', (tester) async {
      for (final (size, expectedFontSize) in [
        (AppSearchFieldSize.large, 16.0),
        (AppSearchFieldSize.medium, 14.0),
        (AppSearchFieldSize.small, 14.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppSearchField(size: size),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.style?.fontSize, expectedFontSize);

        if (size == AppSearchFieldSize.small) {
          final container = tester.widget<Container>(
            find
                .descendant(
                  of: find.byType(AppSearchField),
                  matching: find.byType(Container),
                )
                .first,
          );
          final decoration = container.decoration! as BoxDecoration;
          final radius = decoration.borderRadius! as BorderRadius;
          expect(radius.topLeft.x, 8.0);
        }
      }
    });
  });
}

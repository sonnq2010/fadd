import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';

void main() {
  const testItems = [
    AppSelectItem(value: '1', label: 'Item 1'),
    AppSelectItem(value: '2', label: 'Item 2'),
  ];

  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(
        body: Center(child: SizedBox(width: 300, child: widget)),
      ),
    );
  }

  group('AppSelect Tests', () {
    testWidgets('renders label, placeholder, and helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSelect<String>(
            label: 'Category',
            placeholder: 'Choose category',
            helperText: 'Select one category',
            items: testItems,
          ),
        ),
      );

      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Choose category'), findsOneWidget);
      expect(find.text('Select one category'), findsOneWidget);
      expect(find.byIcon(LucideIcons.chevronDown), findsOneWidget);
    });

    testWidgets('renders selected value text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSelect<String>(
            label: 'Category',
            value: '2',
            items: testItems,
          ),
        ),
      );

      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('renders error text and overrides helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSelect<String>(
            label: 'Category',
            helperText: 'Select one category',
            errorText: 'Please select a valid option',
            items: testItems,
          ),
        ),
      );

      expect(find.text('Please select a valid option'), findsOneWidget);
      expect(find.text('Select one category'), findsNothing);
    });

    testWidgets('disabled select does not trigger dropdown', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSelect<String>(
            label: 'Category',
            enabled: false,
            items: testItems,
          ),
        ),
      );

      final dropdown = tester.widget<DropdownButton<String>>(
        find.byType(DropdownButton<String>),
      );
      expect(dropdown.onChanged, isNull);
    });

    testWidgets('renders all 3 sizes with correct container heights', (
      tester,
    ) async {
      for (final (size, expectedHeight) in [
        (AppSelectSize.large, 48.0),
        (AppSelectSize.medium, 40.0),
        (AppSelectSize.small, 36.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppSelect<String>(
              size: size,
              items: testItems,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppSelect<String>),
            matching: find.byType(Container),
          ),
        );
        expect(container.constraints?.maxHeight ?? 0, expectedHeight);
      }
    });

    testWidgets('uses revised radius and typography contracts', (tester) async {
      for (final (size, expectedFontSize) in [
        (AppSelectSize.large, 16.0),
        (AppSelectSize.medium, 14.0),
        (AppSelectSize.small, 14.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppSelect<String>(size: size, items: testItems),
          ),
        );

        final dropdown = tester.widget<DropdownButton<String>>(
          find.byType(DropdownButton<String>),
        );
        final hint = dropdown.hint! as Text;
        expect(hint.style?.fontSize, expectedFontSize);

        if (size == AppSelectSize.small) {
          final container = tester.widget<Container>(
            find
                .descendant(
                  of: find.byType(AppSelect<String>),
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

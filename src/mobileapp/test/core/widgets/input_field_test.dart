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

  group('AppInputField Tests', () {
    testWidgets('renders label, placeholder, and helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppInputField(
            label: 'Username',
            placeholder: 'Enter your username',
            helperText: 'Your unique identifier',
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Enter your username'), findsOneWidget);
      expect(find.text('Your unique identifier'), findsOneWidget);
    });

    testWidgets('renders error text and overrides helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppInputField(
            label: 'Email',
            helperText: 'We will not share your email',
            errorText: 'Invalid email address',
          ),
        ),
      );

      expect(find.text('Invalid email address'), findsOneWidget);
      expect(find.text('We will not share your email'), findsNothing);
    });

    testWidgets('renders leading and trailing icons', (tester) async {
      var iconTapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppInputField(
            leadingIcon: LucideIcons.search,
            trailingIcon: LucideIcons.x,
            onTrailingIconPressed: () => iconTapped = true,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.search), findsOneWidget);
      expect(find.byIcon(LucideIcons.x), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.x));
      expect(iconTapped, isTrue);
    });

    testWidgets('accepts input and triggers onChanged', (tester) async {
      String? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          AppInputField(
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello world');
      expect(changedValue, 'Hello world');
    });

    testWidgets('disabled field sets TextField enabled to false', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppInputField(
            label: 'Disabled',
            enabled: false,
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('renders sizes with correct heights', (tester) async {
      for (final (size, expectedHeight) in [
        (AppInputSize.large, 48.0),
        (AppInputSize.medium, 40.0),
        (AppInputSize.small, 36.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppInputField(size: size),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppInputField),
            matching: find.byType(Container),
          ),
        );
        expect(container.constraints?.maxHeight ?? 0, expectedHeight);
      }
    });

    testWidgets('uses revised radius and typography contracts', (tester) async {
      for (final (size, expectedFontSize) in [
        (AppInputSize.large, 16.0),
        (AppInputSize.medium, 14.0),
        (AppInputSize.small, 14.0),
      ]) {
        await tester.pumpWidget(
          buildTestableWidget(
            AppInputField(size: size),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.style?.fontSize, expectedFontSize);

        if (size == AppInputSize.small) {
          final container = tester.widget<Container>(
            find
                .descendant(
                  of: find.byType(AppInputField),
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

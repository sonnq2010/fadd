import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: SizedBox(width: 320, child: widget))),
    );
  }

  group('AppTextareaField Tests', () {
    testWidgets('renders label, placeholder, and helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTextareaField(
            label: 'Bio',
            placeholder: 'Tell us about yourself',
            helperText: 'Max 500 characters',
          ),
        ),
      );

      expect(find.text('Bio'), findsOneWidget);
      expect(find.text('Tell us about yourself'), findsOneWidget);
      expect(find.text('Max 500 characters'), findsOneWidget);
    });

    testWidgets('renders error text and overrides helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTextareaField(
            label: 'Bio',
            helperText: 'Max 500 characters',
            errorText: 'Bio cannot be empty',
          ),
        ),
      );

      expect(find.text('Bio cannot be empty'), findsOneWidget);
      expect(find.text('Max 500 characters'), findsNothing);
    });

    testWidgets('accepts multi-line text input', (tester) async {
      String? changed;
      await tester.pumpWidget(
        buildTestableWidget(
          AppTextareaField(
            onChanged: (val) => changed = val,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Line 1\nLine 2\nLine 3');
      expect(changed, 'Line 1\nLine 2\nLine 3');
    });

    testWidgets('disabled field sets TextField enabled to false', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTextareaField(
            enabled: false,
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('respects minimum height 96px', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTextareaField(),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AppTextareaField),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.minHeight, 96.0);
    });
  });
}

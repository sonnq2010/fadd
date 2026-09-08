import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/selection/app_chip.dart';

void main() {
  Widget buildFrame({required Widget child, ThemeMode mode = ThemeMode.light}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  group('AppChip public contract', () {
    testWidgets('renders label and handles tap in default state', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        buildFrame(
          child: AppChip(
            label: 'Filter',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );

      expect(find.text('Filter'), findsOneWidget);
      await tester.tap(find.byType(AppChip));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('shows checkmark when selected is true', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          child: const AppChip(
            label: 'Filter',
            selected: true,
          ),
        ),
      );

      expect(find.text('Filter'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows close icon when onDeleted is provided', (tester) async {
      var deleted = false;

      await tester.pumpWidget(
        buildFrame(
          child: AppChip(
            label: 'Filter',
            onDeleted: () {
              deleted = true;
            },
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(deleted, isTrue);
    });

    testWidgets('does not respond to tap when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        buildFrame(
          child: AppChip(
            label: 'Filter',
            enabled: false,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(AppChip));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });
  });
}

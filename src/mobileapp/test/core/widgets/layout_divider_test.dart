import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/layout/app_divider.dart';

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

  group('AppDivider public contract', () {
    testWidgets('renders horizontal line', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          child: const SizedBox(
            width: 200,
            child: AppDivider(),
          ),
        ),
      );

      expect(find.byType(AppDivider), findsOneWidget);
    });

    testWidgets('renders horizontal line with centered label', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          child: const SizedBox(
            width: 200,
            child: AppDivider(label: 'OR'),
          ),
        ),
      );

      expect(find.text('OR'), findsOneWidget);
    });

    testWidgets('renders vertical line', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          child: const SizedBox(
            height: 100,
            child: AppDivider(orientation: AppDividerOrientation.vertical),
          ),
        ),
      );

      expect(find.byType(AppDivider), findsOneWidget);
    });
  });
}

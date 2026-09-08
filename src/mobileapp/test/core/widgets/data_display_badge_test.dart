import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/data_display/app_badge.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppBadge renders label for all variant styles', (tester) async {
    for (final variant in AppBadgeVariant.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppBadge(
            label: variant.name,
            variant: variant,
          ),
        ),
      );

      expect(find.text(variant.name), findsOneWidget);
    }
  });
}

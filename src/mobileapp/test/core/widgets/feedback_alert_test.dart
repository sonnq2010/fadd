import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/feedback/feedback.dart';

void main() {
  Widget buildFrame({
    required Widget child,
    ThemeMode themeMode = ThemeMode.light,
  }) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppAlert renders message and icons for all semantic styles', (
    tester,
  ) async {
    for (final variant in AppAlertVariant.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppAlert(
            message: '${variant.name} message',
            variant: variant,
          ),
        ),
      );

      expect(find.text('${variant.name} message'), findsOneWidget);
      expect(find.byType(AppAlert), findsOneWidget);
    }
  });

  testWidgets(
    'AppAlert triggers onClose callback when close button is tapped',
    (tester) async {
      var closed = false;

      await tester.pumpWidget(
        buildFrame(
          child: AppAlert(
            message: 'Dismissable alert',
            variant: AppAlertVariant.info,
            showClose: true,
            onClose: () {
              closed = true;
            },
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.x), findsOneWidget);
      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    },
  );

  testWidgets('AppAlert hides close button when showClose is false', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppAlert(
          message: 'Persistent alert',
          variant: AppAlertVariant.warning,
          showClose: false,
        ),
      ),
    );

    expect(find.byIcon(LucideIcons.x), findsNothing);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/data_display/app_badge.dart';
import 'package:mobileapp/core/widgets/data_display/app_card.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppCard renders media, badge, title, description, and actions', (
    tester,
  ) async {
    var detailsTapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppCard(
          badge: const AppBadge(
            label: 'Active',
            variant: AppBadgeVariant.success,
          ),
          title: 'Card title',
          description: 'A short supporting description.',
          actions: [
            AppButton.primary(
              label: 'View details',
              size: AppButtonSize.small,
              onPressed: () => detailsTapped = true,
            ),
            AppButton.ghost(
              label: 'Dismiss',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );

    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Card title'), findsOneWidget);
    expect(find.text('A short supporting description.'), findsOneWidget);
    expect(find.text('View details'), findsOneWidget);
    expect(find.text('Dismiss'), findsOneWidget);

    await tester.tap(find.text('View details'));
    await tester.pumpAndSettle();
    expect(detailsTapped, isTrue);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/navigation/app_nav_bar.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppNavBar renders brand, tabs, and action items', (
    tester,
  ) async {
    var selectedIndex = 0;
    var actionTapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppNavBar(
          brandTitle: 'Acme',
          tabs: const ['Overview', 'Projects', 'Settings'],
          selectedTabIndex: selectedIndex,
          onTabSelected: (index) => selectedIndex = index,
          actions: [
            AppIconButton.ghost(
              icon: LucideIcons.bell,
              semanticLabel: 'Notifications',
              onPressed: () {},
            ),
            AppButton.primary(
              label: 'New project',
              leadingIcon: LucideIcons.plus,
              trailingIcon: LucideIcons.arrowUpRight,
              onPressed: () => actionTapped = true,
            ),
          ],
        ),
      ),
    );

    expect(find.text('Acme'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('New project'), findsOneWidget);
    expect(find.byIcon(LucideIcons.bell), findsOneWidget);

    await tester.tap(find.text('Projects'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 1);

    await tester.tap(find.text('New project'));
    await tester.pumpAndSettle();
    expect(actionTapped, isTrue);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_side_nav_item.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppSideNavItem renders icon, label and handles taps', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppSideNavItem(
          icon: LucideIcons.house,
          label: 'Dashboard',
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.byIcon(LucideIcons.house), findsOneWidget);

    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('AppSideNavItem does not trigger onTap when disabled', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppSideNavItem(
          icon: LucideIcons.house,
          label: 'Settings',
          enabled: false,
          onTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(tapped, isFalse);
  });
}

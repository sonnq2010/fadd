import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
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

  testWidgets('AppSideNavItem renders icon, label and handles taps', (
    tester,
  ) async {
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

  testWidgets('AppSideNavItem does not trigger onTap when disabled', (
    tester,
  ) async {
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
  testWidgets('AppSideNavItem uses body small and hover colors', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFrame(
        child: AppSideNavItem(
          icon: LucideIcons.house,
          label: 'Hover nav',
          onTap: () {},
        ),
      ),
    );

    final label = tester.widget<Text>(find.text('Hover nav'));
    expect(label.style?.fontSize, 14.0);

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer();
    await mouse.moveTo(tester.getCenter(find.byType(AppSideNavItem)));
    await tester.pump();

    final material = tester.widget<Material>(
      find.descendant(
        of: find.byType(AppSideNavItem),
        matching: find.byType(Material),
      ),
    );
    final colors = tester.element(find.byType(AppSideNavItem)).colors;
    expect(material.color, colors.background.secondaryHover);
    expect(
      tester.widget<Text>(find.text('Hover nav')).style?.color,
      colors.text.primary,
    );
    await mouse.removePointer();
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/navigation/app_top_bar.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppTopBar renders leading, title, and trailing actions', (
    tester,
  ) async {
    var leadingTapped = false;
    var trailingTapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppTopBar(
          title: 'Screen title',
          leading: AppIconButton.ghost(
            icon: LucideIcons.arrowLeft,
            semanticLabel: 'Back',
            onPressed: () => leadingTapped = true,
          ),
          trailing: AppIconButton.ghost(
            icon: LucideIcons.menu,
            semanticLabel: 'Menu',
            onPressed: () => trailingTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Screen title'), findsOneWidget);
    expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
    expect(find.byIcon(LucideIcons.menu), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.arrowLeft));
    await tester.pumpAndSettle();
    expect(leadingTapped, isTrue);

    await tester.tap(find.byIcon(LucideIcons.menu));
    await tester.pumpAndSettle();
    expect(trailingTapped, isTrue);
  });
}

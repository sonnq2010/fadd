import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_breadcrumb.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppBreadcrumbItem renders all 3 states', (tester) async {
    for (final state in AppBreadcrumbItemState.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppBreadcrumbItem(
            label: state.name,
            state: state,
          ),
        ),
      );

      expect(find.text(state.name), findsOneWidget);
    }
  });

  testWidgets('AppBreadcrumb renders items trail with separator', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppBreadcrumb(
          items: [
            AppBreadcrumbItemData(label: 'Home', onTap: () => tapped = true),
            const AppBreadcrumbItemData(label: 'Projects'),
            const AppBreadcrumbItemData(label: 'Design System', isCurrent: true),
          ],
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Design System'), findsOneWidget);

    await tester.tap(find.text('Home'));
    expect(tapped, isTrue);
  });
}

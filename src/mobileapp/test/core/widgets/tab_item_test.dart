import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppTabItem Tests', () {
    testWidgets('renders default tab item', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTabItem(label: 'Overview'),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
    });

    testWidgets('renders active tab item with indicator', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTabItem(label: 'Details', isActive: true),
        ),
      );

      expect(find.text('Details'), findsOneWidget);
    });

    testWidgets('tapping tab item triggers onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppTabItem(
            label: 'Settings',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Settings'));
      expect(tapped, isTrue);
    });

    testWidgets('renders AppTabs composite with multiple tabs', (tester) async {
      var selected = 0;
      await tester.pumpWidget(
        buildTestableWidget(
          AppTabs(
            tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
            selectedIndex: selected,
            onTabSelected: (idx) => selected = idx,
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Tab 3'), findsOneWidget);

      await tester.tap(find.text('Tab 2'));
      expect(selected, 1);
    });
  });
}

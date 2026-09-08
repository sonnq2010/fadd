import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_bottom_tab_bar.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(bottomNavigationBar: child),
    );
  }

  testWidgets('AppBottomTabBar renders tab items and responds to selection', (
    tester,
  ) async {
    var currentIndex = 0;

    await tester.pumpWidget(
      buildFrame(
        child: AppBottomTabBar(
          currentIndex: currentIndex,
          onTap: (index) => currentIndex = index,
          items: const [
            AppBottomTabItemData(icon: LucideIcons.house, label: 'Home'),
            AppBottomTabItemData(icon: LucideIcons.search, label: 'Search'),
            AppBottomTabItemData(
              icon: LucideIcons.bell,
              label: 'Notifications',
            ),
            AppBottomTabItemData(icon: LucideIcons.mail, label: 'Messages'),
            AppBottomTabItemData(icon: LucideIcons.user, label: 'Profile'),
          ],
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(currentIndex, 1);
  });
  testWidgets('AppBottomTabItem matches revised size and typography', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: Center(
            child: AppBottomTabItem(
              icon: LucideIcons.house,
              label: 'Home',
            ),
          ),
        ),
      ),
    );

    final itemBox = tester.widget<SizedBox>(
      find
          .descendant(
            of: find.byType(AppBottomTabItem),
            matching: find.byType(SizedBox),
          )
          .first,
    );
    expect(itemBox.width, 67.5);
    final label = tester.widget<Text>(find.text('Home'));
    expect(label.style?.fontSize, 14.0);
    expect(label.style?.fontWeight, FontWeight.w500);
  });

  testWidgets('AppBottomTabBar uses 12px gaps and Figma padding', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFrame(
        child: AppBottomTabBar(
          currentIndex: 0,
          onTap: (_) {},
          items: const [
            AppBottomTabItemData(icon: LucideIcons.house, label: 'Home'),
            AppBottomTabItemData(icon: LucideIcons.search, label: 'Search'),
            AppBottomTabItemData(icon: LucideIcons.user, label: 'Profile'),
          ],
        ),
      ),
    );

    final row = tester.widget<Row>(
      find.descendant(
        of: find.byType(AppBottomTabBar),
        matching: find.byType(Row),
      ),
    );
    expect(row.children.whereType<Gap>().length, 2);

    final container = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(AppBottomTabBar),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(
      container.padding,
      const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 24),
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('AppBottomTabBar renders tab items and responds to selection', (tester) async {
    var currentIndex = 0;

    await tester.pumpWidget(
      buildFrame(
        child: AppBottomTabBar(
          currentIndex: currentIndex,
          onTap: (index) => currentIndex = index,
          items: const [
            AppBottomTabItemData(icon: LucideIcons.house, label: 'Home'),
            AppBottomTabItemData(icon: LucideIcons.search, label: 'Search'),
            AppBottomTabItemData(icon: LucideIcons.bell, label: 'Notifications'),
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
}

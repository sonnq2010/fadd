import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_menu_item.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: SizedBox(width: 220, child: widget))),
    );
  }

  group('AppMenuItem Tests', () {
    testWidgets('renders menu item with label and shortcut', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppMenuItem(
            label: 'Cut',
            shortcut: '⌘X',
          ),
        ),
      );

      expect(find.text('Cut'), findsOneWidget);
      expect(find.text('⌘X'), findsOneWidget);
    });

    testWidgets('renders selected menu item with check icon', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppMenuItem(
            label: 'Show line numbers',
            selected: true,
          ),
        ),
      );

      expect(find.text('Show line numbers'), findsOneWidget);
      expect(find.byIcon(LucideIcons.check), findsOneWidget);
    });

    testWidgets('tapping menu item triggers onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppMenuItem(
            label: 'Copy',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Copy'));
      expect(tapped, isTrue);
    });

    testWidgets('disabled menu item does not trigger onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppMenuItem(
            label: 'Paste',
            disabled: true,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Paste'));
      expect(tapped, isFalse);
    });
  });
}

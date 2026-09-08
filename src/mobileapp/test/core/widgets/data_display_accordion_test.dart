import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/data_display/app_accordion.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppAccordionItem renders collapsed state and expands on tap', (tester) async {
    var expanded = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppAccordionItem(
          title: 'Accordion item title',
          description: 'This is the expandable content area.',
          initiallyExpanded: false,
          onExpansionChanged: (val) => expanded = val,
        ),
      ),
    );

    expect(find.text('Accordion item title'), findsOneWidget);
    expect(find.byIcon(LucideIcons.chevronDown), findsOneWidget);
    // Content should not be visible when collapsed
    expect(find.text('This is the expandable content area.'), findsNothing);

    // Tap to expand
    await tester.tap(find.text('Accordion item title'));
    await tester.pumpAndSettle();

    expect(expanded, isTrue);
    expect(find.text('This is the expandable content area.'), findsOneWidget);
  });

  testWidgets('AppAccordionItem renders initiallyExpanded state', (tester) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppAccordionItem(
          title: 'Expanded title',
          description: 'Expanded body text',
          initiallyExpanded: true,
        ),
      ),
    );

    expect(find.text('Expanded title'), findsOneWidget);
    expect(find.text('Expanded body text'), findsOneWidget);
  });
}

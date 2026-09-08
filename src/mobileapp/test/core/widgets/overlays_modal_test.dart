import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/overlays/overlays.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppModalCard renders title, description and actions', (
    tester,
  ) async {
    var canceled = false;
    var confirmed = false;
    var closed = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppModalCard(
          title: 'Delete project?',
          description: 'This action cannot be undone.',
          cancelLabel: 'Cancel',
          confirmLabel: 'Delete',
          onClose: () => closed = true,
          onCancel: () => canceled = true,
          onConfirm: () => confirmed = true,
        ),
      ),
    );

    expect(find.text('Delete project?'), findsOneWidget);
    expect(find.text('This action cannot be undone.'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    expect(canceled, isTrue);

    await tester.tap(find.text('Delete'));
    expect(confirmed, isTrue);

    await tester.tap(find.byIcon(LucideIcons.x));
    expect(closed, isTrue);
  });
}

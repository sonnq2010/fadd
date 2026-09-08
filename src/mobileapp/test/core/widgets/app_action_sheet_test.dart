import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_action_sheet.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppActionSheet renders drag handle, actions, and cancel button', (tester) async {
    var shareTapped = false;
    var cancelTapped = false;

    await tester.pumpWidget(
      buildFrame(
        child: AppActionSheet(
          actions: [
            AppActionSheetItem(
              label: 'Share',
              onTap: () => shareTapped = true,
            ),
            AppActionSheetItem(
              label: 'Add to favorites',
              onTap: () {},
            ),
            AppActionSheetItem(
              label: 'Duplicate',
              onTap: () {},
            ),
            AppActionSheetItem(
              label: 'Report',
              onTap: () {},
            ),
          ],
          cancelLabel: 'Cancel',
          onCancel: () => cancelTapped = true,
        ),
      ),
    );

    expect(find.text('Share'), findsOneWidget);
    expect(find.text('Add to favorites'), findsOneWidget);
    expect(find.text('Duplicate'), findsOneWidget);
    expect(find.text('Report'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Share'));
    await tester.pumpAndSettle();
    expect(shareTapped, isTrue);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(cancelTapped, isTrue);
  });
}

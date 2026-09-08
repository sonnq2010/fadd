import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_pagination.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppPaginationItem renders all 5 states', (tester) async {
    for (final state in AppPaginationItemState.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppPaginationItem(
            label: state == AppPaginationItemState.ellipsis ? '...' : '1',
            state: state,
          ),
        ),
      );

      if (state == AppPaginationItemState.ellipsis) {
        expect(find.text('...'), findsOneWidget);
      } else {
        expect(find.text('1'), findsOneWidget);
      }
    }
  });

  testWidgets('AppPagination renders full navigation control and handles page change', (tester) async {
    var page = 1;

    await tester.pumpWidget(
      buildFrame(
        child: AppPagination(
          currentPage: 1,
          totalPages: 12,
          onPageChanged: (newPage) => page = newPage,
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('...'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);

    // Tap page 2
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    expect(page, 2);
  });
}

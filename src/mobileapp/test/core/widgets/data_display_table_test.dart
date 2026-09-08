import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/data_display/app_table.dart';
import 'package:mobileapp/core/widgets/selection/app_checkbox.dart';

void main() {
  Widget buildFrame({required Widget child, ThemeMode mode = ThemeMode.light}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  group('AppTable public contract', () {
    testWidgets('renders columns and data rows with custom composed cells', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          child: AppTable<Map<String, String>>(
            columns: const [
              AppTableColumn(
                header: Text('Name'),
                width: 150,
              ),
              AppTableColumn(
                header: Text('Role'),
                width: 100,
              ),
            ],
            data: const [
              {'name': 'Alex Kim', 'role': 'Admin'},
              {'name': 'Maria Jones', 'role': 'Editor'},
            ],
            rowBuilder: (context, item, index) {
              return [
                Text(item['name']!),
                Text(item['role']!),
              ];
            },
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Role'), findsOneWidget);
      expect(find.text('Alex Kim'), findsOneWidget);
      expect(find.text('Maria Jones'), findsOneWidget);
      expect(find.text('Admin'), findsOneWidget);
      expect(find.text('Editor'), findsOneWidget);
    });

    testWidgets('handles row selection when onRowSelectionChanged is provided', (tester) async {
      final selectedIndices = <int>{};

      await tester.pumpWidget(
        buildFrame(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AppTable<String>(
                selectable: true,
                selectedIndices: selectedIndices,
                onRowSelectionChanged: (index, selected) {
                  setState(() {
                    if (selected) {
                      selectedIndices.add(index);
                    } else {
                      selectedIndices.remove(index);
                    }
                  });
                },
                columns: const [
                  AppTableColumn(header: Text('Item'), width: 100),
                ],
                data: const ['First', 'Second'],
                rowBuilder: (context, item, index) => [Text(item)],
              );
            },
          ),
        ),
      );

      expect(find.byType(AppCheckbox), findsNWidgets(3)); // 1 header + 2 rows
      await tester.tap(find.byType(AppCheckbox).at(1));
      await tester.pumpAndSettle();

      expect(selectedIndices.contains(0), isTrue);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/inputs/app_focus_ring.dart';

void main() {
  Widget buildTestableWidget(Widget widget, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(body: Center(child: widget)),
    );
  }

  group('AppFocusRing Tests', () {
    testWidgets('keeps the child size and clips it to the input radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppFocusRing(
            visible: false,
            radius: 8,
            child: SizedBox(width: 120, height: 40),
          ),
        ),
      );

      expect(tester.getSize(find.byType(AppFocusRing)), const Size(120, 40));

      final clip = tester.widget<ClipRRect>(find.byType(ClipRRect));
      final radius = clip.borderRadius as BorderRadius;
      expect(radius.topLeft.x, 8);
      expect(find.byType(Positioned), findsNothing);
    });

    testWidgets('adds ring width to the outer border radius', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppFocusRing(
            visible: true,
            radius: 8,
            child: SizedBox(width: 120, height: 40),
          ),
        ),
      );

      final positioned = tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned.left, -3);
      expect(positioned.top, -3);
      expect(positioned.right, -3);
      expect(positioned.bottom, -3);

      final ring = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(Positioned),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = ring.decoration as BoxDecoration;
      final radius = decoration.borderRadius! as BorderRadius;
      final border = decoration.border! as Border;

      expect(radius.topLeft.x, 11);
      expect(border.top.width, 3);
      expect(
        border.top.color,
        AppColors.light.border.focus.withValues(alpha: 0.45),
      );
    });
  });
}

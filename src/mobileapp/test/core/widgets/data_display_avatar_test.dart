import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/data_display/app_avatar.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppAvatar renders initials for all sizes', (tester) async {
    for (final size in AppAvatarSize.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppAvatar(
            initials: 'JD',
            size: size,
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    }
  });

  testWidgets('AppAvatar renders status dot when showStatus is true', (tester) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppAvatar(
          initials: 'JD',
          showStatus: true,
          size: AppAvatarSize.xl,
        ),
      ),
    );

    expect(find.byKey(const Key('app_avatar_status_dot')), findsOneWidget);
  });
}

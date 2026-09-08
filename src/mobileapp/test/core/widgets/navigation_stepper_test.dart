import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/widgets/navigation/app_stepper.dart';

void main() {
  Widget buildFrame({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('AppStepperItem renders all 3 states', (tester) async {
    for (final state in AppStepperState.values) {
      await tester.pumpWidget(
        buildFrame(
          child: AppStepperItem(
            label: state.name,
            number: '1',
            state: state,
          ),
        ),
      );

      expect(find.text(state.name), findsOneWidget);
      if (state == AppStepperState.completed) {
        expect(find.byIcon(LucideIcons.check), findsOneWidget);
      } else {
        expect(find.text('1'), findsOneWidget);
      }
    }
  });

  testWidgets('AppStepper renders connected flow', (tester) async {
    await tester.pumpWidget(
      buildFrame(
        child: const AppStepper(
          steps: [
            AppStepperStep(label: 'Account', state: AppStepperState.completed),
            AppStepperStep(label: 'Shipping', state: AppStepperState.active),
            AppStepperStep(label: 'Payment', state: AppStepperState.upcoming),
            AppStepperStep(label: 'Review', state: AppStepperState.upcoming),
          ],
        ),
      ),
    );

    expect(find.text('Account'), findsOneWidget);
    expect(find.text('Shipping'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Review'), findsOneWidget);
  });
}

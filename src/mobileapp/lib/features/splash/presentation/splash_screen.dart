import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/router/app_router.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Splash Screen'),
            AppButton.primary(
              label: 'Showcase',
              onPressed: () {
                context.go(AppRoutes.globalComponents.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}

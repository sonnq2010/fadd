import 'package:change_case/change_case.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/features/auth/presentation/auth_screen.dart';
import 'package:mobileapp/features/onboarding/presentation/onboarding_screen.dart';
import 'package:mobileapp/features/splash/presentation/splash_screen.dart';

part 'app_routes.dart';

abstract class AppRouter {
  static final config = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.onboarding.name,
        path: AppRoutes.onboarding.path,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: AppRoutes.auth.name,
        path: AppRoutes.auth.path,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}

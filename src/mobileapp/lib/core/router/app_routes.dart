part of 'app_router.dart';

enum AppRoutes {
  splash,
  onboarding,
  auth,
  globalComponents;

  String get path => switch (this) {
    AppRoutes.splash => '/',
    AppRoutes.globalComponents => '/global-components',
    _ => '/${name.toParamCase()}',
  };
}

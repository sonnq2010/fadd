part of 'app_router.dart';

enum AppRoutes {
  splash,
  onboarding,
  auth;

  String get path => switch (this) {
    AppRoutes.splash => '/',
    _ => '/${name.toParamCase()}',
  };
}

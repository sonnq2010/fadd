import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/locale_constant.dart';
import 'package:mobileapp/core/router/app_router.dart';
import 'package:mobileapp/core/app/observer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [Observer()],
      child: EasyLocalization(
        path: LocaleConstant.translationsPath,
        supportedLocales: LocaleConstant.supportedLocales,
        fallbackLocale: LocaleConstant.fallbackLocale,
        child: MaterialApp.router(
          routerConfig: AppRouter.config,
        ),
      ),
    );
  }
}

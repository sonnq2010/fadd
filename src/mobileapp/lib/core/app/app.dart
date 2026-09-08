import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/locale_constants.dart';
import 'package:mobileapp/core/router/app_router.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/theme/providers/theme_mode_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return EasyLocalization(
      path: LocaleConstants.translationsPath,
      supportedLocales: LocaleConstants.supportedLocales,
      fallbackLocale: LocaleConstants.fallbackLocale,
      child: MaterialApp.router(
        routerConfig: AppRouter.config,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
      ),
    );
  }
}

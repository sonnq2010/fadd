import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/app/app.dart';
import 'package:mobileapp/core/constants/locale_constants.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('configures and switches supported locales', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          path: LocaleConstants.translationsPath,
          supportedLocales: LocaleConstants.supportedLocales,
          fallbackLocale: LocaleConstants.fallbackLocale,
          startLocale: LocaleConstants.english,
          saveLocale: false,
          child: const App(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    var materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    var appContext = tester.element(find.byType(MaterialApp));

    expect(materialApp.locale, LocaleConstants.english);
    expect(materialApp.supportedLocales, LocaleConstants.supportedLocales);
    expect(materialApp.localizationsDelegates, isNotEmpty);
    expect(
      LocaleKeys.hello.tr(context: tester.element(find.text('Splash Screen'))),
      'Hello',
    );

    await appContext.setLocale(LocaleConstants.vietnamese);
    await tester.pumpAndSettle();

    materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.locale, LocaleConstants.vietnamese);
    expect(
      LocaleKeys.hello.tr(context: tester.element(find.text('Splash Screen'))),
      'Xin chào',
    );
  });
}

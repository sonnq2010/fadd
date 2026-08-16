import 'dart:ui';

abstract class LocaleConstant {
  static const String translationsPath = 'assets/translations';

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  static const Locale fallbackLocale = Locale('vi', 'VN');
}

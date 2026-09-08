import 'dart:ui';

abstract class LocaleConstants {
  static const String translationsPath = 'assets/translations';

  static const Locale english = Locale('en');
  static const Locale vietnamese = Locale('vi');

  static const List<Locale> supportedLocales = [english, vietnamese];

  static const Locale fallbackLocale = vietnamese;
}

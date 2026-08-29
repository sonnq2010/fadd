abstract class AppConfig {
  static String get apiBaseUrl => const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  ).replaceFirst(RegExp(r'/+$'), '');

  // Supabase Configuration
  static String get supabaseUrl => const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static String get supabaseAnonKey => const String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  // Validate required application configuration
  static void validate() {
    if (apiBaseUrl.isEmpty) {
      throw Exception(
        'API_BASE_URL is required. '
        'Please provide it via --dart-define=API_BASE_URL=your_url',
      );
    }
    if (supabaseUrl.isEmpty) {
      throw Exception(
        'SUPABASE_URL is required. '
        'Please provide it via --dart-define=SUPABASE_URL=your_url',
      );
    }
    if (supabaseAnonKey.isEmpty) {
      throw Exception(
        'SUPABASE_ANON_KEY is required. '
        'Please provide it via --dart-define=SUPABASE_ANON_KEY=your_key',
      );
    }
  }
}

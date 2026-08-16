abstract class AppConfig {
  // Supabase Configuration
  static String get supabaseUrl => const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static String get supabaseAnonKey => const String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  // Validate required Supabase configuration
  static void validate() {
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

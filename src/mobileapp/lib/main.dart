import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobileapp/core/app/app.dart';
import 'package:mobileapp/core/configs/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Validate configuration (throws exception if missing)
  // In production, you might want to handle this more gracefully
  AppConfig.validate();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
    // authOptions: const FlutterAuthClientOptions(
    //   authFlowType: AuthFlowType.pkce,
    //   // Optional: Configure deep links for OAuth
    //   // redirectTo: 'your-app://auth-callback',
    // ),
    // Optional: Configure realtime
    // realtimeClientOptions: const RealtimeClientOptions(
    //   logLevel: RealtimeLogLevel.info,
    // ),
    // Optional: Configure storage
    // storageOptions: const StorageClientOptions(
    //   retryAttempts: 3,
    // ),
  );

  runApp(const App());
}

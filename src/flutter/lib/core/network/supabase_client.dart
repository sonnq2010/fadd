import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

part 'supabase_client.g.dart';

/// Provider for the Supabase client instance
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return SupabaseClient();
}

/// Wrapper class for Supabase client to provide type-safe access
class SupabaseClient {
  /// Get the Supabase client instance
  sp.SupabaseClient get client => sp.Supabase.instance.client;

  /// Auth methods
  sp.GoTrueClient get auth => client.auth;

  /// Database methods (Postgrest)
  sp.SupabaseQueryBuilder from(String table) => client.from(table);

  /// Storage methods
  sp.SupabaseStorageClient get storage => client.storage;

  /// Realtime methods
  sp.RealtimeClient get realtime => client.realtime;

  /// Functions methods (Edge Functions)
  sp.FunctionsClient get functions => client.functions;

  /// Rest methods
  sp.PostgrestClient get rest => client.rest;

  /// Get current user
  sp.User? get currentUser => auth.currentUser;

  /// Get current session
  sp.Session? get currentSession => auth.currentSession;

  /// Check if user is signed in
  bool get isSignedIn => currentUser != null;

  /// Sign in with email and password
  Future<sp.AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) {
    return auth.signInWithPassword(email: email, password: password);
  }

  /// Sign up with email and password
  Future<sp.AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return auth.signUp(email: email, password: password, data: data);
  }

  /// Sign out
  Future<void> signOut() {
    return auth.signOut();
  }

  /// Reset password
  Future<void> resetPasswordForEmail(String email) {
    return auth.resetPasswordForEmail(email);
  }

  /// Update user
  Future<sp.UserResponse> updateUser(sp.UserAttributes attributes) {
    return auth.updateUser(attributes);
  }

  /// Listen to auth state changes
  Stream<sp.AuthState> get onAuthStateChange => auth.onAuthStateChange;

  /// Refresh session
  Future<sp.AuthResponse> refreshSession() {
    return auth.refreshSession();
  }

  /// Sign in with OAuth
  Future<bool> signInWithOAuth(sp.OAuthProvider provider) {
    return auth.signInWithOAuth(provider);
  }

  /// Verify OTP
  Future<sp.AuthResponse> verifyOTP({
    required String email,
    required String token,
    required sp.OtpType type,
  }) {
    return auth.verifyOTP(email: email, token: token, type: type);
  }
}

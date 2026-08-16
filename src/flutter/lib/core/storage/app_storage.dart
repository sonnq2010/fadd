import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_frontend/core/storage/shared_preferences_storage.dart';

part 'app_storage.g.dart';

@Riverpod(keepAlive: true)
AppStorage appStorage(Ref ref) {
  final storage = SharedPreferencesStorage();
  storage.initialize();
  return storage;
}

abstract class AppStorage {
  void initialize();

  bool get hasInitialized;

  Future<Object?> get(String key);

  Future<bool> set(String key, Object data);

  Future<bool> has(String key);

  Future<bool> remove(String key);

  Future<void> clear();
}

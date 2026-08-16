import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_frontend/core/storage/app_storage.dart';

class SharedPreferencesStorage implements AppStorage {
  SharedPreferences? _sharedPreferences;

  final Completer<SharedPreferences> _initCompleter =
      Completer<SharedPreferences>();

  @override
  void initialize() async {
    _initCompleter.complete(SharedPreferences.getInstance());
    _initCompleter.future.then((value) {
      _sharedPreferences = value;
    });
  }

  @override
  bool get hasInitialized => _sharedPreferences != null;

  @override
  Future<Object?> get(String key) async {
    _sharedPreferences = await _initCompleter.future;
    return _sharedPreferences?.get(key);
  }

  @override
  Future<bool> set(String key, Object data) async {
    _sharedPreferences = await _initCompleter.future;
    return _sharedPreferences?.setString(key, data.toString()) ?? false;
  }

  @override
  Future<bool> has(String key) async {
    _sharedPreferences = await _initCompleter.future;
    return _sharedPreferences?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    _sharedPreferences = await _initCompleter.future;
    return _sharedPreferences?.remove(key) ?? false;
  }

  @override
  Future<void> clear() async {
    _sharedPreferences = await _initCompleter.future;
    await _sharedPreferences?.clear();
  }
}

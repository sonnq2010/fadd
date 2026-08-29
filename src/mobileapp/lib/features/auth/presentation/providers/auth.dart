import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobileapp/features/auth/presentation/states/auth_state.dart';

part 'auth.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthState.initial();
  }
}

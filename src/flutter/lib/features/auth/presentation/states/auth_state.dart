import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_frontend/core/exceptions/failure.dart';
import 'package:flutter_frontend/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(UserEntity user) = _Success;
  const factory AuthState.error(Failure failure) = _Error;
}

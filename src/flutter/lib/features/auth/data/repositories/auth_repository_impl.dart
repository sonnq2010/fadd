import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_frontend/core/exceptions/failure.dart';
import 'package:flutter_frontend/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_frontend/features/auth/domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.authRemoteDataSource);

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await authRemoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return Failure.handleException(e);
    }
  }
}

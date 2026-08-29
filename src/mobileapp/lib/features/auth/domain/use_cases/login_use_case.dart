import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobileapp/core/exceptions/failure.dart';
import 'package:mobileapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobileapp/features/auth/domain/entities/user_entity.dart';
import 'package:mobileapp/features/auth/domain/repositories/auth_repository.dart';

part 'login_use_case.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
}

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return authRepository.login(email, password);
  }
}

import 'package:dartz/dartz.dart';
import 'package:mobileapp/core/exceptions/failure.dart';
import 'package:mobileapp/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}

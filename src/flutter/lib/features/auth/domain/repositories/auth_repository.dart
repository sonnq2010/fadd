import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/core/exceptions/failure.dart';
import 'package:flutter_frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}

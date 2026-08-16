import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_frontend/core/network/supabase_client.dart';
import 'package:flutter_frontend/features/auth/domain/entities/user_entity.dart';

part 'auth_remote_data_source.g.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.read(supabaseClientProvider));
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<UserEntity> login(String email, String password) async {
    return UserEntity(id: '1', name: 'John Doe');
  }
}

import '../entities/user_entity.dart';

export '../entities/user_entity.dart' show AppRole;

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password, [AppRole? role]);
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
  });
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}

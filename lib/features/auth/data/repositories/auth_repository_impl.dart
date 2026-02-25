import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_mock_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    AuthRemoteDataSource? remoteDataSource,
  }) : remoteDataSource = remoteDataSource ?? AuthMockDataSource();

  @override
  Future<UserEntity> login(String email, String password, [AppRole? role]) async {
    try {
      final userModel = await remoteDataSource.login(email, password, role);
      return userModel;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      final userModel = await remoteDataSource.signup(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      return userModel;
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return userModel;
    } catch (e) {
      return null;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/auth_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final signupUseCaseProvider = Provider<SignupUseCase>((ref) {
  return SignupUseCase(ref.watch(authRepositoryProvider));
});

/// Role selected on role-selection screen; passed into login so user gets correct role.
final selectedRoleProvider = StateProvider<AppRole?>((ref) => null);

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserEntity?>>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AsyncValue.loading()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final user = await repository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> login(String email, String password, [AppRole? role]) async {
    state = const AsyncValue.loading();
    try {
      final useCase = LoginUseCase(repository);
      final user = await useCase(email, password, role);
      state = AsyncValue.data(user);
      await AuthStorage.setLoggedIn(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    try {
      final useCase = SignupUseCase(repository);
      final user = await useCase(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      state = AsyncValue.data(user);
      await AuthStorage.setLoggedIn(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await repository.logout();
      await AuthStorage.setLoggedIn(false);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

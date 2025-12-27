
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/auth/domain/entities/user_entity.dart';
import 'package:shoptoo/features/auth/domain/repositories/auth_repository.dart';
class AuthController extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository repository;

  AuthController(this.repository)
      : super(const AsyncValue.loading()) {
    repository.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repository.signIn(email: email, password: password),
    );
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repository.signUp(email: email, password: password),
    );
  }

  Future<void> resetPassword(String email) {
    return repository.sendPasswordReset(email);
  }

  Future<void> signOut() {
    return repository.signOut();
  }
}

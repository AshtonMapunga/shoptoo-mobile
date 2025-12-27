import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  /// Registers a new user with email and password
  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return repository.signUp(email: email, password: password);
  }
}

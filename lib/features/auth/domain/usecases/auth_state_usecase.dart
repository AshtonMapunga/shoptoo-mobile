import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class AuthStateUseCase {
  final AuthRepository repository;

  AuthStateUseCase(this.repository);

  /// Stream of current user
  Stream<UserEntity?> call() {
    return repository.authStateChanges();
  }
}

import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  /// Logs the user out
  Future<void> call() async {
    await repository.signOut();
  }
}

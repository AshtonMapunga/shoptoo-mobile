// lib/features/auth/domain/usecases/sign_in_with_google_usecase.dart

import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}

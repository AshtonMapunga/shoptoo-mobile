import 'package:shoptoo/features/auth/domain/entities/user_entity.dart';
import 'package:shoptoo/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

    /// Registers a new user with email and password
  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return repository.signIn(email: email, password: password);
  }}





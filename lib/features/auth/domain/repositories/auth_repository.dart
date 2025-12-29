import 'package:shoptoo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();

  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

    Future<UserEntity> signInWithGoogle();

  Future<UserEntity> signUp({
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset(String email);

  Future<void> signOut();

  // Future<void> resetPassword({required String email});



}

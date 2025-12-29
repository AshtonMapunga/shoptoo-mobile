import 'package:shoptoo/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:shoptoo/features/auth/domain/entities/user_entity.dart';
import 'package:shoptoo/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Stream<UserEntity?> authStateChanges() {
    return datasource.authStateChanges().map((user) {
      if (user == null) return null;
      return UserEntity(
        id: user.uid,
        email: user.email ?? '',
        emailVerified: user.emailVerified,
      );
    });
  }


  @override
  Future<UserEntity> signInWithGoogle() async {
    final firebaseUser = await datasource.signInWithGoogle();
    return UserEntity(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      emailVerified: firebaseUser.emailVerified,
    );
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final result = await datasource.signIn(email, password);
    final user = result.user!;
    return UserEntity(
      id: user.uid,
      email: user.email!,
      emailVerified: user.emailVerified,
    );
  }

  @override
 Future<UserEntity> signUp({
  required String email,
  required String password,
}) async {
  final result = await datasource.signUp(email, password);
  final user = result.user!;

  if (!user.emailVerified) {
    await user.sendEmailVerification();
    

  }

  return UserEntity(
    id: user.uid,
    email: user.email!,
    emailVerified: user.emailVerified,
  );
}

  @override
  Future<void> sendPasswordReset(String email) {
    return datasource.resetPassword(email);
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }
}

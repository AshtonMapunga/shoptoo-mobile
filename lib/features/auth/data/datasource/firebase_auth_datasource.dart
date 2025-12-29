import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDataSource {
  Stream<User?> authStateChanges();

  Future<User> signInWithGoogle();

  Future<UserCredential> signIn(String email, String password);

  Future<UserCredential> signUp(String email, String password);

  Future<void> resetPassword(String email);

  Future<void> signOut();
}

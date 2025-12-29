import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/auth/data/datasource/firebase_data_source_impl.dart';
import 'package:shoptoo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shoptoo/features/auth/domain/entities/user_entity.dart';
import 'package:shoptoo/features/auth/domain/repositories/auth_repository.dart';
import 'package:shoptoo/features/auth/domain/usecases/sign_in_google.dart';
import 'package:shoptoo/features/auth/presentation/controllers/auth_controller.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authDataSourceProvider =
    Provider((ref) => FirebaseAuthDataSourceImpl(ref.read(firebaseAuthProvider)));

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepositoryImpl(
          ref.read(authDataSourceProvider),
        ));

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserEntity?>>(
  (ref) => AuthController(ref.read(authRepositoryProvider)),
);

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInWithGoogleUseCase(repository);
});

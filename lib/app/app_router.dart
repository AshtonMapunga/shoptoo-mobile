import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/app/providers.dart';
import 'package:shoptoo/features/auth/screens/login_screen.dart';
import 'package:shoptoo/features/auth/screens/verify_email_screen.dart';
import 'package:shoptoo/features/layouts/screens/home_screen.dart';
import 'package:shoptoo/features/welcome/screens/splash_screen.dart';


Widget buildAppRouter(WidgetRef ref) {
  final authState = ref.watch(authControllerProvider);

  return authState.when(
    loading: () => const SplashScreenPage(),
    error: (_, __) => const LoginScreen(),
    data: (user) {
      if (user == null) return const LoginScreen();
      if (!user.emailVerified) return const VerifyEmailScreen(email: 'ashton@gmail.com');
      return const HomeScreen();
    },
  );
}

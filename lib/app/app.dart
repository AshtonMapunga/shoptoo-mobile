import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shoptoo/app/app_router.dart';
import 'package:shoptoo/app/app_startup.dart';
import 'package:shoptoo/features/welcome/screens/splash_screen.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(appStartupProvider);

    return startup.when(
      loading: () => const SplashScreenPage(),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: buildAppRouter(ref),
      ),
    );
  }
}

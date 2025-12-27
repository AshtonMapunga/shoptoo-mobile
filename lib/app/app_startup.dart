import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStartupProvider = FutureProvider<void>((ref) async {
  await Firebase.initializeApp();
});

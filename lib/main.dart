import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/app/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
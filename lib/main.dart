import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoptoo/app/app.dart';
import 'package:shoptoo/features/cart/data/models/cart_item_hive.dart';
import 'package:shoptoo/features/notifications/presentation/services/firebase_notification_service.dart';
import 'package:shoptoo/features/wishlist/data/model/wishlist_item_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // -------------------------
  // Initialize Hive first
  // -------------------------
  await Hive.initFlutter();

  // Cart
  Hive.registerAdapter(CartItemHiveAdapter());
  await Hive.openBox<CartItemHive>('cartBox');

  // Wishlist
  Hive.registerAdapter(WishlistItemModelAdapter());
  await Hive.openBox<WishlistItemModel>('wishlistBox');

  FirebaseMessaging.onBackgroundMessage(
    FirebaseNotificationService.backgroundHandler,
  );


  await dotenv.load(fileName: ".env");


  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

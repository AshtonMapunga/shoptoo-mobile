import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    // Save token to Firestore (used by admin)
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/app_notification_model.dart';

abstract class NotificationRemoteDataSource {
  Stream<List<AppNotificationModel>> getNotifications(String userId);
  Future<void> saveNotification(
    String userId,
    AppNotificationModel notification,
  );
  Future<void> markAsRead(String userId, String notificationId);
}

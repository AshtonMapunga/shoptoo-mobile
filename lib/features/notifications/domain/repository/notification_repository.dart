// features/notifications/domain/repository/notification_repository.dart
import '../entity/app_notification_entity.dart';

abstract class NotificationRepository {
  Stream<List<AppNotificationEntity>> getUserNotifications(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Future<void> saveNotification(
    String userId,
    AppNotificationEntity notification,
  );
}

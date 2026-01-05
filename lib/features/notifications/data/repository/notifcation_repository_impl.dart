import 'package:shoptoo/features/notifications/data/datasource/notification_remote_datasource.dart';
import 'package:shoptoo/features/notifications/data/model/app_notification_model.dart';
import 'package:shoptoo/features/notifications/domain/entity/app_notification_entity.dart';
import 'package:shoptoo/features/notifications/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remote;

  NotificationRepositoryImpl(this.remote);

  @override
  Stream<List<AppNotificationEntity>> getUserNotifications(
      String userId) {
    return remote.getNotifications(userId).map(
          (models) =>
              models.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Future<void> markAsRead(
      String userId, String notificationId) {
    return remote.markAsRead(userId, notificationId);
  }

  @override
  Future<void> saveNotification(
      String userId, AppNotificationEntity notification) {
    return remote.saveNotification(
      userId,
      AppNotificationModel(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        createdAt: notification.createdAt,
        isRead: notification.isRead,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoptoo/features/notifications/data/datasource/notification_remote_datasource.dart';
import 'package:shoptoo/features/notifications/data/model/app_notification_model.dart';

class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {
  final FirebaseFirestore firestore;

  NotificationRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<AppNotificationModel>> getNotifications(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    AppNotificationModel.fromJson(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  @override
  Future<void> saveNotification(
      String userId, AppNotificationModel notification) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notification.id)
        .set(notification.toJson());
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }
}

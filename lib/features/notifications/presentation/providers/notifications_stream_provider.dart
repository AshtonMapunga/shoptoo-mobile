import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/features/notifications/domain/entity/app_notification_entity.dart';
import 'package:shoptoo/features/notifications/presentation/providers/notification_provider.dart';

final userNotificationsProvider =
    StreamProvider.family<List<AppNotificationEntity>, String>(
  (ref, userId) {
    return ref
        .watch(notificationRepositoryProvider)
        .getUserNotifications(userId);
  },
);

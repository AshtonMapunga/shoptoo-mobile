import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/features/notifications/data/datasource/notification_remote_datasource.dart';
import 'package:shoptoo/features/notifications/data/datasource/notification_remote_datasource_impl.dart';
import 'package:shoptoo/features/notifications/data/repository/notifcation_repository_impl.dart';
import 'package:shoptoo/features/notifications/domain/repository/notification_repository.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>(
  (ref) => NotificationRemoteDataSourceImpl(
    ref.watch(firestoreProvider),
  ),
);

final notificationRepositoryProvider =
    Provider<NotificationRepository>(
  (ref) => NotificationRepositoryImpl(
    ref.watch(notificationRemoteDataSourceProvider),
  ),
);

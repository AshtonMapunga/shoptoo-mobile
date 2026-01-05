import '../../domain/entity/app_notification_entity.dart';

class AppNotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  AppNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
  });

  factory AppNotificationModel.fromJson(
      Map<String, dynamic> json, String id) {
    return AppNotificationModel(
      id: id,
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  AppNotificationEntity toEntity() {
    return AppNotificationEntity(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      isRead: isRead,
    );
  }
}

import 'package:equatable/equatable.dart';

class AppNotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  const AppNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
  });

  @override
  List<Object?> get props => [id];
}

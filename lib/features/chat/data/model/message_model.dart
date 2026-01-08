import 'package:shoptoo/features/chat/domain/entity/message_entity.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool read;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String id) {
    return MessageModel(
      id: id,
      senderId: json['senderId'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
      read: json['read'],
    );
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
        'read': read,
      };

  MessageEntity toEntity() => MessageEntity(
        id: id,
        senderId: senderId,
        text: text,
        timestamp: timestamp,
        read: read,
      );
}

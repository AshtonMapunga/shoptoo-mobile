import 'package:shoptoo/features/chat/domain/entity/chat_user_entity.dart';

class ChatUserModel {
  final String id;
  final String name;
  final String avatar;
  final String role;

  ChatUserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.role,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json, String id) {
    return ChatUserModel(
      id: id,
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  ChatUserEntity toEntity() => ChatUserEntity(
        id: id,
        name: name,
        avatar: avatar,
        role: role,
      );
}

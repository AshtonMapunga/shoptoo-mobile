import 'package:shoptoo/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:shoptoo/features/chat/domain/entity/chat_user_entity.dart';
import 'package:shoptoo/features/chat/domain/entity/message_entity.dart';
import 'package:shoptoo/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;

  ChatRepositoryImpl(this.remote);

  @override
  Stream<List<ChatUserEntity>> getTechnicians() {
    return remote
        .getTechnicians()
        .map((list) => list.map((e) => e.toEntity()).toList());
  }

  @override
  Future<String> createOrGetChat(
      String userId, String technicianId) {
    return remote.createOrGetChat(userId, technicianId);
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return remote.getMessages(chatId).map(
          (list) => list.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Future<void> sendMessage(
      String chatId, String senderId, String text) {
    return remote.sendMessage(chatId, senderId, text);
  }
}

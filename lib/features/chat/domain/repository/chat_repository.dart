import '../entity/chat_user_entity.dart';
import '../entity/message_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatUserEntity>> getTechnicians();
  Future<String> createOrGetChat(String userId, String technicianId);
  Stream<List<MessageEntity>> getMessages(String chatId);
  Future<void> sendMessage(
    String chatId,
    String senderId,
    String text,
  );
}

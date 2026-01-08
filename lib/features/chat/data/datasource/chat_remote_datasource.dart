import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoptoo/features/chat/data/model/chat_user_model.dart';
import 'package:shoptoo/features/chat/data/model/message_model.dart';

class ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSource(this.firestore);

  Stream<List<ChatUserModel>> getTechnicians() {
    return firestore
        .collection('users')
        .where('role', isEqualTo: 'technician')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((d) => ChatUserModel.fromJson(d.data(), d.id))
              .toList(),
        );
  }

  Future<String> createOrGetChat(
      String userId, String technicianId) async {
    final query = await firestore
        .collection('chats')
        .where('members', arrayContains: userId)
        .get();

    for (final doc in query.docs) {
      final members = List<String>.from(doc['members']);
      if (members.contains(technicianId)) return doc.id;
    }

    final chatRef = await firestore.collection('chats').add({
      'members': [userId, technicianId],
      'lastMessage': '',
      'lastMessageTime': DateTime.now().toIso8601String(),
    });

    return chatRef.id;
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return firestore
        .collection('messages')
        .doc(chatId)
        .collection('items')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((d) => MessageModel.fromJson(d.data(), d.id))
              .toList(),
        );
  }

  Future<void> sendMessage(
      String chatId, String senderId, String text) async {
    final message = MessageModel(
      id: '',
      senderId: senderId,
      text: text,
      timestamp: DateTime.now(),
      read: false,
    );

    await firestore
        .collection('messages')
        .doc(chatId)
        .collection('items')
        .add(message.toJson());

    await firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': DateTime.now().toIso8601String(),
    });
  }
}

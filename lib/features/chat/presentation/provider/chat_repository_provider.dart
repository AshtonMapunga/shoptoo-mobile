import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:shoptoo/features/chat/data/repository/chat_repository_impl.dart';
import 'package:shoptoo/features/chat/domain/entity/chat_user_entity.dart';
import 'package:shoptoo/features/chat/domain/entity/message_entity.dart';
import 'package:shoptoo/features/chat/domain/repository/chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepositoryImpl(
    ChatRemoteDataSource(FirebaseFirestore.instance),
  ),
);

final techniciansProvider =
    StreamProvider<List<ChatUserEntity>>(
  (ref) => ref.watch(chatRepositoryProvider).getTechnicians(),
);

final messagesProvider =
    StreamProvider.family<List<MessageEntity>, String>(
  (ref, chatId) =>
      ref.watch(chatRepositoryProvider).getMessages(chatId),
);

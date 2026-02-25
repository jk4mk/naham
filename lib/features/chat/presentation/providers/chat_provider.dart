import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl();
});

final chatsProvider = FutureProvider<List<ChatEntity>>((ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getChats();
});

final messagesProvider = FutureProvider.family<List<MessageEntity>, String>((ref, chatId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getMessages(chatId);
});

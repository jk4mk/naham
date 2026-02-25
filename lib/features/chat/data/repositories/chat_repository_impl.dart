import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_mock_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({
    ChatRemoteDataSource? remoteDataSource,
  }) : remoteDataSource = remoteDataSource ?? ChatMockDataSource();

  @override
  Future<List<ChatEntity>> getChats() async {
    try {
      final chats = await remoteDataSource.getChats();
      return chats;
    } catch (e) {
      throw Exception('Failed to get chats: ${e.toString()}');
    }
  }

  @override
  Future<List<MessageEntity>> getMessages(String chatId) async {
    try {
      final messages = await remoteDataSource.getMessages(chatId);
      return messages;
    } catch (e) {
      throw Exception('Failed to get messages: ${e.toString()}');
    }
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    try {
      await remoteDataSource.sendMessage(chatId, content);
    } catch (e) {
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }

  @override
  Future<void> markAsRead(String chatId) async {
    try {
      await remoteDataSource.markAsRead(chatId);
    } catch (e) {
      throw Exception('Failed to mark as read: ${e.toString()}');
    }
  }
}

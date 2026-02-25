import 'dart:math';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/chat_entity.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'chat_remote_datasource.dart';

class ChatMockDataSource implements ChatRemoteDataSource {
  final List<ChatModel> _chats = [];
  final Map<String, List<MessageModel>> _messages = {};
  final String _currentUserId = 'cook_1';

  ChatMockDataSource() {
    _initializeMockData();
  }

  void _initializeMockData() {
    final random = Random();
    final names = ['Ahmed', 'Sara', 'Mohammed', 'Fatima', 'Ali', 'Layla'];

    for (int i = 0; i < 5; i++) {
      final chatId = 'chat_$i';
      final userId = 'user_$i';
      final userName = names[i % names.length];

      final messages = List.generate(
        3,
        (index) => MessageModel(
          id: 'msg_$i$index',
          chatId: chatId,
          senderId: index % 2 == 0 ? userId : _currentUserId,
          content: 'Message ${index + 1} from ${index % 2 == 0 ? userName : "You"}',
          timestamp: DateTime.now().subtract(Duration(minutes: 30 - index * 10)),
          isRead: index < 2,
        ),
      );

      _messages[chatId] = messages;

      _chats.add(
        ChatModel(
          id: chatId,
          userId: userId,
          userName: userName,
          lastMessage: messages.last.content,
          lastMessageTime: messages.last.timestamp,
          unreadCount: random.nextInt(5),
        ),
      );
    }
  }

  @override
  Future<List<ChatModel>> getChats() async {
    await Future.delayed(AppConstants.mockDelay);
    return List.from(_chats);
  }

  @override
  Future<List<MessageModel>> getMessages(String chatId) async {
    await Future.delayed(AppConstants.mockDelay);
    return List.from(_messages[chatId] ?? []);
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final message = MessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: _currentUserId,
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
    );

    _messages[chatId] = [...(_messages[chatId] ?? []), message];

    // Update chat last message
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = ChatModel(
        id: _chats[chatIndex].id,
        userId: _chats[chatIndex].userId,
        userName: _chats[chatIndex].userName,
        userImageUrl: _chats[chatIndex].userImageUrl,
        lastMessage: content,
        lastMessageTime: DateTime.now(),
        unreadCount: _chats[chatIndex].unreadCount,
      );
    }
  }

  @override
  Future<void> markAsRead(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final messages = _messages[chatId];
    if (messages != null) {
      _messages[chatId] = messages
          .map((MessageModel msg) => MessageModel(
                id: msg.id,
                chatId: msg.chatId,
                senderId: msg.senderId,
                content: msg.content,
                timestamp: msg.timestamp,
                isRead: true,
              ))
          .toList();
    }

    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = ChatModel(
        id: _chats[chatIndex].id,
        userId: _chats[chatIndex].userId,
        userName: _chats[chatIndex].userName,
        userImageUrl: _chats[chatIndex].userImageUrl,
        lastMessage: _chats[chatIndex].lastMessage,
        lastMessageTime: _chats[chatIndex].lastMessageTime,
        unreadCount: 0,
      );
    }
  }
}

// ============================================================
// COOK CHAT — Same layout & design as Customer Chat (purple theme)
// ============================================================

import 'package:flutter/material.dart';

import '../../customer/naham_customer_screens.dart';

// ══════════════════════════════════════════════════════════════
// CHAT SCREEN (list) — exact Customer layout
// ══════════════════════════════════════════════════════════════
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'name': 'Ahmad Ali', 'last': 'I am allergic to eggs, no eggs please', 'time': '2:30 PM', 'unread': '2'},
      {'name': 'Nadia Salem', 'last': 'Can you add extra pepper?', 'time': '1:15 PM', 'unread': '0'},
      {'name': 'Layla Mohammed', 'last': 'We are preparing your food', 'time': 'Yesterday', 'unread': '0'},
      {'name': 'Naham Support', 'last': 'I need help with inspection', 'time': '3 hours ago', 'unread': '1'},
    ];

    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          nahamCustomerHeader(
            title: 'Chat',
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final hasUnread = chat['unread'] != '0';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: NahamCustomerColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _CookChatConversationScreen(
                          name: chat['name']!,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: NahamCustomerColors.primaryLight.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: NahamCustomerColors.primaryDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                chat['last']!,
                                style: const TextStyle(
                                  color: NahamCustomerColors.textGrey,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              chat['time']!,
                              style: const TextStyle(
                                color: NahamCustomerColors.textGrey,
                                fontSize: 11,
                              ),
                            ),
                            if (hasUnread) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: NahamCustomerColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  chat['unread']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Conversation (detail) — keep purple theme ─────────────────────────
class _CookChatConversationScreen extends StatefulWidget {
  final String name;

  const _CookChatConversationScreen({required this.name});

  @override
  State<_CookChatConversationScreen> createState() => _CookChatConversationScreenState();
}

class _CookChatConversationScreenState extends State<_CookChatConversationScreen> {
  final _ctrl = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How can I help?', 'isMe': false, 'time': '09:30 AM'},
    {'text': 'I need help with my order', 'isMe': true, 'time': '09:32 AM'},
  ];

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _ctrl.text.trim(), 'isMe': true, 'time': 'Now'});
      _ctrl.clear();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        title: Text(widget.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                final isMe = msg['isMe'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMe ? NahamCustomerColors.primary : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: Radius.circular(isMe ? 18 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 18),
                            ),
                          ),
                          child: Text(
                            msg['text'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: isMe ? Colors.white : NahamCustomerColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: NahamCustomerColors.textGrey, fontSize: 14),
                      filled: true,
                      fillColor: NahamCustomerColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: NahamCustomerColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

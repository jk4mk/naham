import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatPreview> _customerChats = const [
    _ChatPreview(
      name: 'خالد إبراهيم',
      role: 'Customer',
      message: 'السلام عليكم، عندي استفسار عن الطلب الأخير.',
      timeAgo: 'منذ ٤ ساعات',
      unreadCount: 2,
    ),
    _ChatPreview(
      name: 'سارة أحمد',
      role: 'Customer',
      message: 'متى يتم توصيل طلبي؟',
      timeAgo: 'منذ ساعة',
      unreadCount: 0,
    ),
    _ChatPreview(
      name: 'محمد سالم',
      role: 'Customer',
      message: 'شكراً على الخدمة المميزة.',
      timeAgo: 'قبل يوم',
      unreadCount: 0,
    ),
  ];

  final List<_ChatPreview> _cookChats = const [
    _ChatPreview(
      name: 'أحمد محمد',
      role: 'Cook',
      message: 'تم تجهيز الطلب وجاهز للتسليم.',
      timeAgo: 'قبل ٣٠ دقيقة',
      unreadCount: 1,
    ),
    _ChatPreview(
      name: 'نورا حسن',
      role: 'Cook',
      message: 'هل يمكن تعديل وقت الاستلام؟',
      timeAgo: 'منذ ساعتين',
      unreadCount: 0,
    ),
    _ChatPreview(
      name: 'سعود عبد الله',
      role: 'Cook',
      message: 'انتهيت من جميع الطلبات الحالية.',
      timeAgo: 'منذ ١٠ دقائق',
      unreadCount: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildTabs(context),
              const SizedBox(height: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBarView(
                    children: [
                      _ChatsList(chats: _customerChats),
                      _ChatsList(chats: _cookChats),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6A5AE0),
            Color(0xFF8E7BFF),
            Color(0xFFE6E1FF),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                'Chat & Support',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(24),
        ),
        child: TabBar(
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          labelColor: const Color(0xFF111827),
          unselectedLabelColor: const Color(0xFF6B7280),
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Customer'),
            Tab(text: 'Cook'),
          ],
        ),
      ),
    );
  }
}

class _ChatsList extends StatelessWidget {
  final List<_ChatPreview> chats;

  const _ChatsList({required this.chats});

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return const Center(
        child: Text('لا توجد محادثات حالياً'),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 4 : 8,
            bottom: index == chats.length - 1 ? 16 : 4,
          ),
          child: _ChatCard(chat: chat),
        );
      },
    );
  }
}

class _ChatPreview {
  final String name;
  final String role;
  final String message;
  final String timeAgo;
  final int unreadCount;

  const _ChatPreview({
    required this.name,
    required this.role,
    required this.message,
    required this.timeAgo,
    required this.unreadCount,
  });
}

class _ChatCard extends StatelessWidget {
  final _ChatPreview chat;

  const _ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.06),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatDetailsPlaceholder(userName: chat.name),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 3,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF6A5AE0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 10),
              _AvatarWithBadge(
                name: chat.name,
                unreadCount: chat.unreadCount,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            chat.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF111827),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          chat.timeAgo,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        chat.role,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      chat.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  final String name;
  final int unreadCount;

  const _AvatarWithBadge({
    required this.name,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    final String initial =
        name.isNotEmpty ? name.trim().characters.first : '?';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFE6E1FF),
          child: Text(
            initial,
            style: const TextStyle(
              color: Color(0xFF6A5AE0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white,
                  width: 1.2,
                ),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ChatDetailsPlaceholder extends StatelessWidget {
  final String userName;

  const ChatDetailsPlaceholder({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Center(
        child: Text(
          'Chat details with $userName (placeholder)',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


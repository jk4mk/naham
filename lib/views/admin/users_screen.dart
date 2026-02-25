import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _CooksTab(),
                  _CustomersTab(),
                ],
              ),
            ),
          ],
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
                'Users',
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

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF6A5AE0),
        unselectedLabelColor: const Color(0xFF9A9AB0),
        indicatorColor: const Color(0xFF6A5AE0),
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        tabs: const [
          Tab(text: 'Cooks (4)'),
          Tab(text: 'Customers (3)'),
        ],
      ),
    );
  }
}

class _CooksTab extends StatelessWidget {
  final List<_CookUser> _cooks = const [
    _CookUser(
      name: 'أحمد محمد',
      status: 'Active',
      ordersCount: 342,
    ),
    _CookUser(
      name: 'فاطمة علي',
      status: 'Active',
      ordersCount: 189,
    ),
    _CookUser(
      name: 'سعود عبد الله',
      status: 'Frozen',
      ordersCount: 56,
    ),
    _CookUser(
      name: 'نورا حسن',
      status: 'Active',
      ordersCount: 278,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cooks.length,
      itemBuilder: (context, index) {
        final cook = _cooks[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == _cooks.length - 1 ? 0 : 12,
          ),
          child: _CookCard(cook: cook),
        );
      },
    );
  }
}

class _CustomersTab extends StatelessWidget {
  final List<_CustomerUser> _customers = const [
    _CustomerUser(
      name: 'خالد إبراهيم',
      ordersCount: 5,
    ),
    _CustomerUser(
      name: 'سارة أحمد',
      ordersCount: 12,
    ),
    _CustomerUser(
      name: 'محمد سالم',
      ordersCount: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _customers.length,
      itemBuilder: (context, index) {
        final customer = _customers[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == _customers.length - 1 ? 0 : 12,
          ),
          child: _CustomerCard(customer: customer),
        );
      },
    );
  }
}

class _CookUser {
  final String name;
  final String status;
  final int ordersCount;

  const _CookUser({
    required this.name,
    required this.status,
    required this.ordersCount,
  });
}

class _CustomerUser {
  final String name;
  final int ordersCount;

  const _CustomerUser({
    required this.name,
    required this.ordersCount,
  });
}

class _CookCard extends StatelessWidget {
  final _CookUser cook;

  const _CookCard({required this.cook});

  @override
  Widget build(BuildContext context) {
    final bool isActive = cook.status == 'Active';

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E1FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF6A5AE0),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          cook.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F1F33),
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF22C55E).withOpacity(0.1)
                              : const Color(0xFF9A9AB0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          cook.status,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? const Color(0xFF22C55E)
                                    : const Color(0xFF9A9AB0),
                                fontSize: 11,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 16,
                        color: Color(0xFF7A7A8C),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${cook.ordersCount} orders',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF7A7A8C),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  final _CustomerUser customer;

  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E1FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF6A5AE0),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F33),
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 16,
                        color: Color(0xFF7A7A8C),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${customer.ordersCount} orders',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF7A7A8C),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

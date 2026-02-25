// ============================================================
// COOK ORDERS SCREEN — Naham App (#9B7EC8 purple, match Customer)
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/theme/app_design_system.dart';
import '../../../core/widgets/naham_screen_header.dart';

// ─── Colors (Naham purple #9B7EC8) ──────────────────────────
class _NC {
  static const primary = Color(0xFF9B7EC8);
  static const primaryMid = Color(0xFF9B7EC8);
  static const primaryBright = Color(0xFF7B5EA7);
  static const primaryLight = Color(0xFFE8E4F0);
  static const primaryGlow = Color(0x309B7EC8);
  static const bg = Color(0xFFF5F0FF);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF1A1A1A);
  static const textSub = Color(0xFF6B7280);
  static const border = Color(0xFFE8E0F5);
  static const error = Color(0xFFE74C3C);
  static const warning = Color(0xFFF59E0B);
  static const success = Color(0xFF2ECC71);
  static const almostReady = Color(0xFFF5A623);
  static const cooking = Color(0xFF9B7EC8);
}

// ══════════════════════════════════════════════════════════════
// ORDERS SCREEN
// ══════════════════════════════════════════════════════════════
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  final _newOrders = [
    {
      'id': '#2053',
      'customer': 'Sara Ahmed',
      'items': '2x Jareesh, 1x Margog',
      'earnings': 65.0,
      'prepTime': '25 min',
      'placed': '2 minutes ago',
      'note': '🌶️ Less spicy please',
    },
    {
      'id': '#2052',
      'customer': 'Omar Hassan',
      'items': '1x Jareesh, 2x Margog',
      'earnings': 59.0,
      'prepTime': '30 min',
      'placed': '5 minutes ago',
      'note': '',
    },
  ];

  final _activeOrders = [
    {
      'id': '#2051',
      'customer': 'Ahmad Ali',
      'items': '2x Jareesh, 1x Margog',
      'amount': 64.0,
      'status': 'Cooking',
      'readyIn': '17 min',
      'estTime': '2:35 PM',
    },
    {
      'id': '#2050',
      'customer': 'Fatima Hassan',
      'items': '1x Jareesh, 1x Margog',
      'amount': 48.0,
      'status': 'Almost Ready',
      'readyIn': '5 min',
      'estTime': '2:30 PM',
    },
  ];

  final _completedOrders = [
    {
      'id': '#2045',
      'customer': 'Mohammed Ali',
      'items': '1x Margog, 2x Jareesh',
      'amount': 45.0,
      'completedAt': '1:45 PM',
    },
    {
      'id': '#2042',
      'customer': 'Nora Abdullah',
      'items': '1x Margog',
      'amount': 35.0,
      'completedAt': '12:30 PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _NC.bg,
      body: Column(
        children: [
          const NahamScreenHeader(title: 'Orders'),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tab,
              indicatorColor: AppDesignSystem.primaryDark,
              labelColor: AppDesignSystem.primaryDark,
              unselectedLabelColor: _NC.textSub,
              tabs: const [
                Tab(text: 'New'),
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildNewOrders(),
                _buildActiveOrders(),
                _buildCompletedOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewOrders() => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _newOrders.length,
      itemBuilder: (ctx, i) => _NewOrderCard(order: _newOrders[i]));

  Widget _buildActiveOrders() => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activeOrders.length,
      itemBuilder: (ctx, i) => _ActiveOrderCard(order: _activeOrders[i]));

  Widget _buildCompletedOrders() => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _completedOrders.length,
      itemBuilder: (ctx, i) =>
          _CompletedOrderCard(order: _completedOrders[i]));
}

// ─── New Order Card ───────────────────────────────────────────
class _NewOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _NewOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _NC.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(order['id'] as String,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: _NC.text)),
                    const SizedBox(width: 8),
                    Text(order['customer'] as String,
                        style: const TextStyle(
                            fontSize: 13, color: _NC.textSub)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _NC.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('New',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _NC.primaryMid)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _InfoRow('Items', order['items'] as String),
                const SizedBox(height: 6),
                _InfoRow('Estimated earnings',
                    '${(order['earnings'] as double).toStringAsFixed(2)} SAR',
                    valueColor: _NC.success, valueBold: true),
                const SizedBox(height: 6),
                _InfoRow('Suggested prep time',
                    order['prepTime'] as String),
                const SizedBox(height: 6),
                _InfoRow('Placed', order['placed'] as String,
                    valueColor: _NC.error),
                if ((order['note'] as String).isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBE6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFFE58F)),
                    ),
                    child: Text(order['note'] as String,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF8A6914))),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: const Text('Reject'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _NC.error,
                      side: const BorderSide(color: _NC.error),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle_outline_rounded,
                        size: 16),
                    label: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _NC.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
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

// ─── Active Order Card ────────────────────────────────────────
class _ActiveOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _ActiveOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final isCooking = order['status'] == 'Cooking';
    final statusColor = isCooking ? _NC.cooking : _NC.almostReady;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _NC.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order['id'] as String,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: _NC.text)),
                          const SizedBox(height: 2),
                          Text(order['customer'] as String,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: _NC.textSub)),
                          const SizedBox(height: 4),
                          Text(order['items'] as String,
                              style: const TextStyle(
                                  fontSize: 13, color: _NC.text)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${(order['amount'] as double).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: _NC.primaryMid)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(order['status'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: statusColor)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: _NC.bg,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(Icons.timer_rounded,
                          size: 15,
                          color: isCooking ? _NC.primaryMid : _NC.error),
                      const SizedBox(width: 6),
                      Text('Ready in ${order['readyIn']}',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isCooking
                                  ? _NC.primaryMid
                                  : _NC.error)),
                      const Spacer(),
                      Text('Est. ${order['estTime']}',
                          style: const TextStyle(
                              fontSize: 12, color: _NC.textSub)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: _NC.border))),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.visibility_rounded, size: 16),
              label: const Text('View Details'),
              style: TextButton.styleFrom(
                foregroundColor: _NC.primaryMid,
                minimumSize: const Size(double.infinity, 44),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Completed Order Card ─────────────────────────────────────
class _CompletedOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _CompletedOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _NC.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(order['id'] as String,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: _NC.text)),
                    const Spacer(),
                    Text(
                        '${(order['amount'] as double).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _NC.success)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(order['customer'] as String,
                    style: const TextStyle(
                        fontSize: 13, color: _NC.textSub)),
                const SizedBox(height: 4),
                Text(order['items'] as String,
                    style: const TextStyle(
                        fontSize: 13, color: _NC.text)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _NC.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('Completed',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _NC.success)),
                    ),
                    const SizedBox(width: 8),
                    Text('Completed: ${order['completedAt']}',
                        style: const TextStyle(
                            fontSize: 11, color: _NC.textSub)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Info Row Helper ──────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool valueBold;

  const _InfoRow(this.label, this.value,
      {this.valueColor, this.valueBold = false});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: _NC.textSub)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      valueBold ? FontWeight.w700 : FontWeight.w500,
                  color: valueColor ?? _NC.text)),
        ],
      );
}

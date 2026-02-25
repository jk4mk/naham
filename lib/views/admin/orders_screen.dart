import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedStatusIndex = 0;

  final List<_OrderStatus> _statuses = const [
    
    _OrderStatus(label: 'New', icon: Icons.fiber_new_rounded),
    _OrderStatus(label: 'Active', icon: Icons.play_arrow_rounded),
    _OrderStatus(label: 'Canceled', icon: Icons.cancel_outlined),
    _OrderStatus(label: 'Completed', icon: Icons.check_circle_outline),
  ];
final List<Map<String, String>> _ordersNew = [
  {'id': '#4521', 'customer': 'نادية سالم', 'cook': 'فاطمة'},
  {'id': '#4522', 'customer': 'سارة العتيبي', 'cook': 'أحمد'},
];

final List<Map<String, String>> _ordersActive = [
  {'id': '#7812', 'customer': 'ريم عبدالله', 'cook': 'هند'},
  {'id': '#7813', 'customer': 'منى الحربي', 'cook': 'سعود'},
];

final List<Map<String, String>> _ordersCanceled = [
  {'id': '#1110', 'customer': 'هيا القحطاني', 'cook': 'ليان'},
];

final List<Map<String, String>> _ordersCompleted = [
  {'id': '#9901', 'customer': 'دلال', 'cook': 'فاطمة'},
];

List<Map<String, String>> get _currentOrders {
  switch (_selectedStatusIndex) {
    case 0:
      return _ordersNew;
    case 1:
      return _ordersActive;
    case 2:
      return _ordersCanceled;
    case 3:
      return _ordersCompleted;
    default:
      return _ordersNew;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildSearchBar(context),
            ),
            const SizedBox(height: 16),
            Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          children: [
            _OrdersHeaderRow(),
            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 0.6),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _currentOrders.length,
                itemBuilder: (context, index) {
                  final order = _currentOrders[index];

                  return _OrderRow(
                    orderId: order['id'] ?? '',
                    customer: order['customer'] ?? '',
                    cook: order['cook'] ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
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
                'Orders',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 8),
          _buildStatusSelectorRow(),
        ],
      ),
    );
  }

  Widget _buildStatusSelectorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_statuses.length, (index) {
        final status = _statuses[index];
        final bool isSelected = index == _selectedStatusIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 6,
              right: index == _statuses.length - 1 ? 0 : 6,
            ),
            child: _StatusButton(
              status: status,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedStatusIndex = index;
                });
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by order id',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6A5AE0),
          ),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFFB2B2C8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final _OrderStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusButton({
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedTextColor = const Color(0xFF1F1F33);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                status.icon,
                size: 22,
                color: isSelected ? selectedTextColor : Colors.white,
              ),
              const SizedBox(height: 4),
              Text(
                status.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? selectedTextColor : Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderStatus {
  final String label;
  final IconData icon;

  const _OrderStatus({
    required this.label,
    required this.icon,
  });
}


class _OrdersHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF7A7A8C),
        );

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Order ID',
            style: headerStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Customer',
            style: headerStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Cook',
            style: headerStyle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String orderId;
  final String customer;
  final String cook;

  const _OrderRow({
    required this.orderId,
    required this.customer,
    required this.cook,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: const Color(0xFF1F1F33),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              orderId,
              style: valueStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              customer,
              style: valueStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cook,
              style: valueStyle,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}


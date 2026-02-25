import 'dart:math';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';
import 'orders_remote_datasource.dart';

class OrdersMockDataSource implements OrdersRemoteDataSource {
  final List<OrderModel> _orders = [];

  OrdersMockDataSource() {
    _initializeMockData();
  }

  void _initializeMockData() {
    final random = Random();
    final dishNames = [
      'Chicken Biryani',
      'Beef Kabsa',
      'Mandi',
      'Shawarma',
      'Falafel Plate',
      'Hummus',
      'Tabbouleh',
      'Kunafa',
    ];

    for (int i = 0; i < 10; i++) {
      final items = List.generate(
        random.nextInt(3) + 1,
        (index) => OrderItemModel(
          id: 'item_$i$index',
          dishName: dishNames[random.nextInt(dishNames.length)],
          quantity: random.nextInt(3) + 1,
          price: (random.nextDouble() * 50 + 10).roundToDouble(),
        ),
      );

      final totalAmount = items.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      _orders.add(
        OrderModel(
          id: 'order_$i',
          customerName: 'Customer ${i + 1}',
          customerImageUrl: null,
          items: items,
          totalAmount: totalAmount,
          status: OrderStatus.values[random.nextInt(OrderStatus.values.length)],
          createdAt: DateTime.now().subtract(Duration(hours: random.nextInt(24))),
          deliveryAddress: 'Address ${i + 1}',
          notes: random.nextBool() ? 'Special instructions $i' : null,
        ),
      );
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(AppConstants.mockDelay);
    return List.from(_orders);
  }

  @override
  Future<List<OrderModel>> getOrdersByStatus(OrderStatus status) async {
    await Future.delayed(AppConstants.mockDelay);
    return _orders.where((order) => order.status == status).toList();
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    await Future.delayed(AppConstants.mockDelay);
    final order = _orders.firstWhere(
      (order) => order.id == id,
      orElse: () => throw Exception('Order not found'),
    );
    return order;
  }

  @override
  Future<void> acceptOrder(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      _orders[index] = OrderModel(
        id: _orders[index].id,
        customerName: _orders[index].customerName,
        customerImageUrl: _orders[index].customerImageUrl,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
        status: OrderStatus.accepted,
        createdAt: _orders[index].createdAt,
        deliveryAddress: _orders[index].deliveryAddress,
        notes: _orders[index].notes,
      );
    }
  }

  @override
  Future<void> rejectOrder(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      _orders[index] = OrderModel(
        id: _orders[index].id,
        customerName: _orders[index].customerName,
        customerImageUrl: _orders[index].customerImageUrl,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
        status: OrderStatus.rejected,
        createdAt: _orders[index].createdAt,
        deliveryAddress: _orders[index].deliveryAddress,
        notes: _orders[index].notes,
      );
    }
  }

  @override
  Future<void> updateOrderStatus(String id, OrderStatus status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      _orders[index] = OrderModel(
        id: _orders[index].id,
        customerName: _orders[index].customerName,
        customerImageUrl: _orders[index].customerImageUrl,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
        status: status,
        createdAt: _orders[index].createdAt,
        deliveryAddress: _orders[index].deliveryAddress,
        notes: _orders[index].notes,
      );
    }
  }
}

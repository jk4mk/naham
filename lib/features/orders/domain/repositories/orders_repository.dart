import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<List<OrderEntity>> getOrders();
  Future<List<OrderEntity>> getOrdersByStatus(OrderStatus status);
  Future<OrderEntity> getOrderById(String id);
  Future<void> acceptOrder(String id);
  Future<void> rejectOrder(String id);
  Future<void> updateOrderStatus(String id, OrderStatus status);
}

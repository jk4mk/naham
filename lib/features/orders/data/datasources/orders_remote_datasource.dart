import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<List<OrderModel>> getOrdersByStatus(OrderStatus status);
  Future<OrderModel> getOrderById(String id);
  Future<void> acceptOrder(String id);
  Future<void> rejectOrder(String id);
  Future<void> updateOrderStatus(String id, OrderStatus status);
}

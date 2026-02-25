import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_mock_datasource.dart';
import '../datasources/orders_remote_datasource.dart';
import '../models/order_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl({
    OrdersRemoteDataSource? remoteDataSource,
  }) : remoteDataSource = remoteDataSource ?? OrdersMockDataSource();

  @override
  Future<List<OrderEntity>> getOrders() async {
    try {
      final orders = await remoteDataSource.getOrders();
      return orders;
    } catch (e) {
      throw Exception('Failed to get orders: ${e.toString()}');
    }
  }

  @override
  Future<List<OrderEntity>> getOrdersByStatus(OrderStatus status) async {
    try {
      final orders = await remoteDataSource.getOrdersByStatus(status);
      return orders;
    } catch (e) {
      throw Exception('Failed to get orders by status: ${e.toString()}');
    }
  }

  @override
  Future<OrderEntity> getOrderById(String id) async {
    try {
      final order = await remoteDataSource.getOrderById(id);
      return order;
    } catch (e) {
      throw Exception('Failed to get order: ${e.toString()}');
    }
  }

  @override
  Future<void> acceptOrder(String id) async {
    try {
      await remoteDataSource.acceptOrder(id);
    } catch (e) {
      throw Exception('Failed to accept order: ${e.toString()}');
    }
  }

  @override
  Future<void> rejectOrder(String id) async {
    try {
      await remoteDataSource.rejectOrder(id);
    } catch (e) {
      throw Exception('Failed to reject order: ${e.toString()}');
    }
  }

  @override
  Future<void> updateOrderStatus(String id, OrderStatus status) async {
    try {
      await remoteDataSource.updateOrderStatus(id, status);
    } catch (e) {
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }
}

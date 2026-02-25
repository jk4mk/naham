import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/orders_repository_impl.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl();
});

final ordersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final repository = ref.watch(ordersRepositoryProvider);
  return await repository.getOrders();
});

final pendingOrdersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final repository = ref.watch(ordersRepositoryProvider);
  return await repository.getOrdersByStatus(OrderStatus.pending);
});

final activeOrdersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final repository = ref.watch(ordersRepositoryProvider);
  final accepted = await repository.getOrdersByStatus(OrderStatus.accepted);
  final preparing = await repository.getOrdersByStatus(OrderStatus.preparing);
  return [...accepted, ...preparing];
});

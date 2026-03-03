import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/admin_firebase_datasource.dart';
import '../data/datasources/orders_firebase_datasource.dart';
import '../data/models/order_model.dart';
import '../data/models/user_model.dart';

final adminFirebaseDataSourceProvider = Provider<AdminFirebaseDataSource>((ref) => AdminFirebaseDataSource());

final ordersFirebaseDataSourceProvider = Provider<OrdersFirebaseDataSource>((ref) => OrdersFirebaseDataSource());

final pendingChefsProvider = StreamProvider<List<UserModel>>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).watchPendingChefs();
});

final pendingChefsCountProvider = StreamProvider<int>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).watchPendingChefsCount();
});

final allChefsProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).getAllChefs();
});

final allCustomersProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).getAllCustomers();
});

final allOrdersProvider = StreamProvider<List<OrderModel>>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).watchOrders();
});

final delayedOrdersCountProvider = StreamProvider<int>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).watchDelayedOrdersCount();
});

final todayOrdersCountProvider = StreamProvider<int>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).watchTodayOrdersCount();
});

final todayRevenueProvider = StreamProvider<double>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).watchTodayRevenue();
});

final supportUnreadCountProvider = StreamProvider<int>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).watchSupportUnreadCount();
});

final adminNotificationsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).watchAdminNotifications();
});

final supportConversationsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(adminFirebaseDataSourceProvider).watchSupportConversations();
});

// Analytics (one-time fetch)
final totalOrdersCountProvider = FutureProvider<int>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getTotalOrdersCount();
});

final thisMonthOrdersCountProvider = FutureProvider<int>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getThisMonthOrdersCount();
});

final last7DaysRevenueProvider = FutureProvider<List<double>>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getLast7DaysRevenue();
});

final mostOrderedDishesProvider = FutureProvider<List<MapEntry<String, int>>>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getMostOrderedDishes(limit: 10);
});

final mostActiveChefsProvider = FutureProvider<List<MapEntry<String, int>>>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getMostActiveChefs(limit: 10);
});

final peakOrderHoursProvider = FutureProvider<Map<int, int>>((ref) {
  return ref.read(ordersFirebaseDataSourceProvider).getPeakOrderHours();
});

final supportMessagesStreamProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, conversationId) {
  return ref.read(adminFirebaseDataSourceProvider).watchConversationMessages(conversationId);
});

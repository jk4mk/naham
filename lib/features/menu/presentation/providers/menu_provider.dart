import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/entities/dish_entity.dart';
import '../../domain/repositories/menu_repository.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepositoryImpl();
});

final dishesProvider = FutureProvider<List<DishEntity>>((ref) async {
  final repository = ref.watch(menuRepositoryProvider);
  return await repository.getDishes();
});

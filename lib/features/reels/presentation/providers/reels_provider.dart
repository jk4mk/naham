import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/reels_repository_impl.dart';
import '../../domain/entities/reel_entity.dart';
import '../../domain/repositories/reels_repository.dart';

final reelsRepositoryProvider = Provider<ReelsRepository>((ref) {
  return ReelsRepositoryImpl();
});

final reelsProvider = FutureProvider<List<ReelEntity>>((ref) async {
  final repository = ref.watch(reelsRepositoryProvider);
  return await repository.getReels();
});

final myReelsProvider = FutureProvider<List<ReelEntity>>((ref) async {
  final repository = ref.watch(reelsRepositoryProvider);
  return await repository.getMyReels();
});

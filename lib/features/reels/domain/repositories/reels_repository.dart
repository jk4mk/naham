import '../entities/reel_entity.dart';

abstract class ReelsRepository {
  Future<List<ReelEntity>> getReels();
  Future<List<ReelEntity>> getMyReels();
  Future<List<ReelEntity>> getReelsByCook(String cookId);
  Future<ReelEntity> uploadReel({
    required String videoUrl,
    String? caption,
  });
  Future<void> likeReel(String reelId);
  Future<void> unlikeReel(String reelId);
  Future<void> deleteReel(String reelId);
}

import '../../domain/entities/reel_entity.dart';
import '../models/reel_model.dart';

abstract class ReelsRemoteDataSource {
  Future<List<ReelModel>> getReels();
  Future<List<ReelModel>> getMyReels();
  Future<List<ReelModel>> getReelsByCook(String cookId);
  Future<ReelModel> uploadReel({
    required String videoUrl,
    String? caption,
  });
  Future<void> likeReel(String reelId);
  Future<void> unlikeReel(String reelId);
  Future<void> deleteReel(String reelId);
}

import 'dart:math';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/reel_entity.dart';
import '../models/reel_model.dart';
import 'reels_remote_datasource.dart';

class ReelsMockDataSource implements ReelsRemoteDataSource {
  final List<ReelModel> _reels = [];
  final String _currentCookId = 'cook_1';
  final String _currentCookName = 'My Cook Name';

  ReelsMockDataSource() {
    _initializeMockData();
  }

  void _initializeMockData() {
    final cookNames = ['Ahmed', 'Sara', 'Mohammed', 'Fatima'];
    for (int i = 0; i < 8; i++) {
      _reels.add(
        ReelModel(
          id: 'reel_$i',
          cookId: i == 0 ? _currentCookId : 'cook_${i + 1}',
          cookName: i == 0 ? _currentCookName : cookNames[i % cookNames.length],
          videoUrl: 'https://example.com/video_$i.mp4',
          caption: i % 2 == 0 ? 'Delicious food! #cooking #food' : null,
          likesCount: Random().nextInt(1000),
          commentsCount: Random().nextInt(100),
          createdAt: DateTime.now().subtract(Duration(hours: i)),
          isLiked: Random().nextBool(),
        ),
      );
    }
  }

  @override
  Future<List<ReelModel>> getReels() async {
    await Future.delayed(AppConstants.mockDelay);
    return List.from(_reels);
  }

  @override
  Future<List<ReelModel>> getMyReels() async {
    await Future.delayed(AppConstants.mockDelay);
    return _reels.where((reel) => reel.cookId == _currentCookId).toList();
  }

  @override
  Future<List<ReelModel>> getReelsByCook(String cookId) async {
    await Future.delayed(AppConstants.mockDelay);
    return _reels.where((reel) => reel.cookId == cookId).toList();
  }

  @override
  Future<ReelModel> uploadReel({
    required String videoUrl,
    String? caption,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final reel = ReelModel(
      id: 'reel_${DateTime.now().millisecondsSinceEpoch}',
      cookId: _currentCookId,
      cookName: _currentCookName,
      videoUrl: videoUrl,
      caption: caption,
      likesCount: 0,
      commentsCount: 0,
      createdAt: DateTime.now(),
      isLiked: false,
    );
    _reels.insert(0, reel);
    return reel;
  }

  @override
  Future<void> likeReel(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _reels.indexWhere((reel) => reel.id == reelId);
    if (index != -1 && !_reels[index].isLiked) {
      _reels[index] = ReelModel(
        id: _reels[index].id,
        cookId: _reels[index].cookId,
        cookName: _reels[index].cookName,
        cookImageUrl: _reels[index].cookImageUrl,
        videoUrl: _reels[index].videoUrl,
        thumbnailUrl: _reels[index].thumbnailUrl,
        caption: _reels[index].caption,
        likesCount: _reels[index].likesCount + 1,
        commentsCount: _reels[index].commentsCount,
        createdAt: _reels[index].createdAt,
        isLiked: true,
      );
    }
  }

  @override
  Future<void> unlikeReel(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _reels.indexWhere((reel) => reel.id == reelId);
    if (index != -1 && _reels[index].isLiked) {
      _reels[index] = ReelModel(
        id: _reels[index].id,
        cookId: _reels[index].cookId,
        cookName: _reels[index].cookName,
        cookImageUrl: _reels[index].cookImageUrl,
        videoUrl: _reels[index].videoUrl,
        thumbnailUrl: _reels[index].thumbnailUrl,
        caption: _reels[index].caption,
        likesCount: _reels[index].likesCount - 1,
        commentsCount: _reels[index].commentsCount,
        createdAt: _reels[index].createdAt,
        isLiked: false,
      );
    }
  }

  @override
  Future<void> deleteReel(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _reels.removeWhere((reel) => reel.id == reelId);
  }
}

import 'package:equatable/equatable.dart';

class ReelEntity extends Equatable {
  final String id;
  final String cookId;
  final String cookName;
  final String? cookImageUrl;
  final String videoUrl;
  final String? thumbnailUrl;
  final String? caption;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isLiked;

  const ReelEntity({
    required this.id,
    required this.cookId,
    required this.cookName,
    this.cookImageUrl,
    required this.videoUrl,
    this.thumbnailUrl,
    this.caption,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
        id,
        cookId,
        cookName,
        cookImageUrl,
        videoUrl,
        thumbnailUrl,
        caption,
        likesCount,
        commentsCount,
        createdAt,
        isLiked,
      ];
}

import '../../domain/entities/reel_entity.dart';

class ReelModel extends ReelEntity {
  const ReelModel({
    required super.id,
    required super.cookId,
    required super.cookName,
    super.cookImageUrl,
    required super.videoUrl,
    super.thumbnailUrl,
    super.caption,
    super.likesCount,
    super.commentsCount,
    required super.createdAt,
    super.isLiked,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'] as String,
      cookId: json['cookId'] as String,
      cookName: json['cookName'] as String,
      cookImageUrl: json['cookImageUrl'] as String?,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      caption: json['caption'] as String?,
      likesCount: json['likesCount'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cookId': cookId,
      'cookName': cookName,
      'cookImageUrl': cookImageUrl,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
    };
  }
}

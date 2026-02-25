import '../../domain/entities/dish_entity.dart';

class DishModel extends DishEntity {
  const DishModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.imageUrl,
    super.categories,
    super.isAvailable,
    super.preparationTime,
    required super.createdAt,
    super.updatedAt,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isAvailable: json['isAvailable'] as bool? ?? true,
      preparationTime: json['preparationTime'] as int? ?? 30,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categories': categories,
      'isAvailable': isAvailable,
      'preparationTime': preparationTime,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

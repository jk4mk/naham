import 'package:equatable/equatable.dart';

class DishEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final List<String> categories;
  final bool isAvailable;
  final int preparationTime; // in minutes
  final DateTime createdAt;
  final DateTime? updatedAt;

  const DishEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.categories = const [],
    this.isAvailable = true,
    this.preparationTime = 30,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        categories,
        isAvailable,
        preparationTime,
        createdAt,
        updatedAt,
      ];
}

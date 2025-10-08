import 'package:vietnamese_fish_sauce_app/features/home/domain/entities/category.dart';

/// Data model for category with JSON serialization
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    this.badgeCount = 0,
    this.order = 0,
  });

  /// Convert from domain entity
  factory CategoryModel.fromEntity(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      iconPath: entity.iconPath,
      badgeCount: entity.badgeCount,
      order: entity.order,
    );
  }

  /// Convert from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconPath: json['iconPath'] as String,
      badgeCount: json['badgeCount'] as int? ?? 0,
      order: json['order'] as int? ?? 0,
    );
  }

  final String id;
  final String name;
  final String iconPath;
  final int badgeCount;
  final int order;

  /// Convert to domain entity
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      iconPath: iconPath,
      badgeCount: badgeCount,
      order: order,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
      'badgeCount': badgeCount,
      'order': order,
    };
  }
}

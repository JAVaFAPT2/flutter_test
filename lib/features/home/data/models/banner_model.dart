import 'package:vietnamese_fish_sauce_app/features/home/domain/entities/banner.dart';

/// Data model for banner with JSON serialization
class BannerModel {
  const BannerModel({
    required this.id,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionUrl,
    this.order = 0,
  });

  /// Convert from domain entity
  factory BannerModel.fromEntity(Banner entity) {
    return BannerModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      title: entity.title,
      subtitle: entity.subtitle,
      actionUrl: entity.actionUrl,
      order: entity.order,
    );
  }

  /// Convert from JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      actionUrl: json['actionUrl'] as String?,
      order: json['order'] as int? ?? 0,
    );
  }

  final String id;
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionUrl;
  final int order;

  /// Convert to domain entity
  Banner toEntity() {
    return Banner(
      id: id,
      imageUrl: imageUrl,
      title: title,
      subtitle: subtitle,
      actionUrl: actionUrl,
      order: order,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'actionUrl': actionUrl,
      'order': order,
    };
  }
}

import 'package:equatable/equatable.dart';

/// Domain entity for product category
class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
    this.badgeCount = 0,
    this.order = 0,
  });

  final String id;
  final String name;
  final String iconPath;
  final int badgeCount;
  final int order;

  @override
  List<Object?> get props => [id, name, iconPath, badgeCount, order];
}


import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart.dart';
import 'cart_item_model.dart';

/// Data model for cart with JSON serialization
class CartModel {
  const CartModel({
    required this.items,
    required this.selectedVariantKeys,
    required this.isEditing,
  });

  /// Convert from domain entity
  factory CartModel.fromEntity(Cart entity) {
    return CartModel(
      items:
          entity.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      selectedVariantKeys: entity.selectedVariantKeys,
      isEditing: entity.isEditing,
    );
  }

  /// Convert from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      selectedVariantKeys: (json['selectedVariantKeys'] as List<dynamic>?)
              ?.map((key) => key as String)
              .toSet() ??
          <String>{},
      isEditing: json['isEditing'] as bool? ?? false,
    );
  }

  final List<CartItemModel> items;
  final Set<String> selectedVariantKeys;
  final bool isEditing;

  /// Convert to domain entity
  Cart toEntity() {
    return Cart(
      items: items.map((item) => item.toEntity()).toList(),
      selectedVariantKeys: selectedVariantKeys,
      isEditing: isEditing,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'selectedVariantKeys': selectedVariantKeys.toList(),
      'isEditing': isEditing,
    };
  }
}

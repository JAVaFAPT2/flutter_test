import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart_item.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';

/// Data model for cart item with JSON serialization
class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.productName,
    required this.productSubtitle,
    required this.productImageUrl,
    required this.quantity,
    required this.volume,
    required this.unitPrice,
    required this.addedAt,
  });

  /// Convert from domain entity
  factory CartItemModel.fromEntity(CartItem entity) {
    return CartItemModel(
      productId: entity.product.id,
      productName: entity.product.name,
      productSubtitle: entity.product.subtitle,
      productImageUrl: entity.product.imageUrl,
      quantity: entity.quantity,
      volume: entity.volume,
      unitPrice: entity.unitPrice,
      addedAt: entity.addedAt,
    );
  }

  /// Convert from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productSubtitle: json['productSubtitle'] as String,
      productImageUrl: json['productImageUrl'] as String,
      quantity: json['quantity'] as int,
      volume: json['volume'] as String?,
      unitPrice: json['unitPrice'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  final String productId;
  final String productName;
  final String productSubtitle;
  final String productImageUrl;
  final int quantity;
  final String? volume;
  final int unitPrice;
  final DateTime addedAt;

  /// Convert to domain entity
  /// Note: This creates a simplified ProductEntity
  /// For full product details, fetch from ProductRepository
  CartItem toEntity() {
    return CartItem(
      product: ProductEntity(
        id: productId,
        name: productName,
        subtitle: productSubtitle,
        price: '', // Not stored in cart
        imageUrl: productImageUrl,
      ),
      quantity: quantity,
      volume: volume,
      unitPrice: unitPrice,
      addedAt: addedAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productSubtitle': productSubtitle,
      'productImageUrl': productImageUrl,
      'quantity': quantity,
      'volume': volume,
      'unitPrice': unitPrice,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}

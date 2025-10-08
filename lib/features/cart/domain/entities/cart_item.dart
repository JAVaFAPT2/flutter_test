import 'package:equatable/equatable.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';

/// Pure domain entity representing an item in the shopping cart
/// Framework-agnostic and immutable
class CartItem extends Equatable {
  const CartItem({
    required this.product,
    required this.quantity,
    this.volume,
    required this.unitPrice,
    required this.addedAt,
  });

  final ProductEntity product;
  final int quantity;
  final String? volume;
  final int unitPrice;
  final DateTime addedAt;

  /// Generate a unique key for this cart item based on product and variant
  String get variantKey => '${product.id}_${volume ?? "default"}';

  /// Calculate total price for this item
  int get totalPrice => unitPrice * quantity;

  /// Get formatted total price
  String get formattedTotalPrice {
    return totalPrice.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// Create a copy with modified fields
  CartItem copyWith({
    ProductEntity? product,
    int? quantity,
    String? volume,
    int? unitPrice,
    DateTime? addedAt,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      volume: volume ?? this.volume,
      unitPrice: unitPrice ?? this.unitPrice,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  List<Object?> get props => [product, quantity, volume, unitPrice, addedAt];
}

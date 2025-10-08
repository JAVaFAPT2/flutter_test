import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

/// Use case for adding an item to the cart
/// Contains business logic for adding items
class AddItemToCart {
  const AddItemToCart(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  /// Returns updated cart after adding the item
  Future<Cart> call(AddItemToCartParams params) async {
    // Get current cart
    final currentCart = await _repository.getCart();

    // Check if item already exists
    final existingItemIndex = currentCart.items.indexWhere(
      (item) =>
          item.product.id == params.product.id && item.volume == params.volume,
    );

    List<CartItem> updatedItems;

    if (existingItemIndex >= 0) {
      // Update quantity of existing item
      updatedItems = List<CartItem>.from(currentCart.items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + params.quantity,
      );
    } else {
      // Add new item
      final newItem = CartItem(
        product: params.product,
        quantity: params.quantity,
        volume: params.volume,
        unitPrice: params.unitPrice,
        addedAt: DateTime.now(),
      );
      updatedItems = [...currentCart.items, newItem];
    }

    // Create updated cart
    final updatedCart = currentCart.copyWith(items: updatedItems);

    // Persist cart
    await _repository.saveCart(updatedCart);

    return updatedCart;
  }
}

/// Parameters for adding item to cart
class AddItemToCartParams {
  const AddItemToCartParams({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.volume,
  });

  final ProductEntity product;
  final int quantity;
  final String? volume;
  final int unitPrice;
}


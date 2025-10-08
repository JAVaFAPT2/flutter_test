import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for removing an item from the cart
class RemoveItemFromCart {
  const RemoveItemFromCart(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  /// Returns updated cart after removing the item
  Future<Cart> call(RemoveItemFromCartParams params) async {
    // Get current cart
    final currentCart = await _repository.getCart();

    // Build variant key
    final variantKey = params.volume != null
        ? '${params.productId}_${params.volume}'
        : params.productId;

    // Remove item
    final updatedItems = currentCart.items
        .where((item) => item.variantKey != variantKey)
        .toList();

    // Remove from selection if present
    final updatedSelection = Set<String>.from(currentCart.selectedVariantKeys);
    updatedSelection.remove(variantKey);

    // Create updated cart
    final updatedCart = currentCart.copyWith(
      items: updatedItems,
      selectedVariantKeys: updatedSelection,
    );

    // Persist cart
    await _repository.saveCart(updatedCart);

    return updatedCart;
  }
}

/// Parameters for removing item from cart
class RemoveItemFromCartParams {
  const RemoveItemFromCartParams({
    required this.productId,
    this.volume,
  });

  final String productId;
  final String? volume;
}


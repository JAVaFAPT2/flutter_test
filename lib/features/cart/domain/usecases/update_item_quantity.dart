import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for updating item quantity in cart
class UpdateItemQuantity {
  const UpdateItemQuantity(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  /// Returns updated cart after changing quantity
  Future<Cart> call(UpdateItemQuantityParams params) async {
    // Get current cart
    final currentCart = await _repository.getCart();

    // Build variant key
    final variantKey = params.volume != null
        ? '${params.productId}_${params.volume}'
        : params.productId;

    // Update quantity
    final updatedItems = currentCart.items.map((item) {
      if (item.variantKey == variantKey) {
        return item.copyWith(quantity: params.newQuantity);
      }
      return item;
    }).toList();

    // Create updated cart
    final updatedCart = currentCart.copyWith(items: updatedItems);

    // Persist cart
    await _repository.saveCart(updatedCart);

    return updatedCart;
  }
}

/// Parameters for updating item quantity
class UpdateItemQuantityParams {
  const UpdateItemQuantityParams({
    required this.productId,
    required this.newQuantity,
    this.volume,
  });

  final String productId;
  final int newQuantity;
  final String? volume;
}


import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for deleting selected items from cart
class DeleteSelectedItems {
  const DeleteSelectedItems(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  Future<Cart> call() async {
    final currentCart = await _repository.getCart();

    final remainingItems = currentCart.items
        .where((item) =>
            !currentCart.selectedVariantKeys.contains(item.variantKey))
        .toList();

    final updatedCart = currentCart.copyWith(
      items: remainingItems,
      selectedVariantKeys: <String>{},
    );

    await _repository.saveCart(updatedCart);
    return updatedCart;
  }
}


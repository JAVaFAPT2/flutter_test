import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for selecting/deselecting all items
class ToggleSelectAll {
  const ToggleSelectAll(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  Future<Cart> call(bool selectAll) async {
    final currentCart = await _repository.getCart();

    final updatedSelection = selectAll
        ? currentCart.items.map((item) => item.variantKey).toSet()
        : <String>{};

    final updatedCart = currentCart.copyWith(
      selectedVariantKeys: updatedSelection,
    );

    await _repository.saveCart(updatedCart);
    return updatedCart;
  }
}


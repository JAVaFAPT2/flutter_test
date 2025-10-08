import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for toggling item selection in cart
class ToggleItemSelection {
  const ToggleItemSelection(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  Future<Cart> call(ToggleItemSelectionParams params) async {
    final currentCart = await _repository.getCart();

    final variantKey = params.volume != null
        ? '${params.productId}_${params.volume}'
        : params.productId;

    final updatedSelection = Set<String>.from(currentCart.selectedVariantKeys);

    if (params.isSelected) {
      updatedSelection.add(variantKey);
    } else {
      updatedSelection.remove(variantKey);
    }

    final updatedCart = currentCart.copyWith(
      selectedVariantKeys: updatedSelection,
    );

    await _repository.saveCart(updatedCart);
    return updatedCart;
  }
}

class ToggleItemSelectionParams {
  const ToggleItemSelectionParams({
    required this.productId,
    required this.isSelected,
    this.volume,
  });

  final String productId;
  final bool isSelected;
  final String? volume;
}


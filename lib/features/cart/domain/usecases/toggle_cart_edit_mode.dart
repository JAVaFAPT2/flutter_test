import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for toggling cart edit mode
class ToggleCartEditMode {
  const ToggleCartEditMode(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  Future<Cart> call(bool isEditing) async {
    final currentCart = await _repository.getCart();
    final updatedCart = currentCart.copyWith(isEditing: isEditing);
    await _repository.saveCart(updatedCart);
    return updatedCart;
  }
}


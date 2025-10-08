import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for clearing all items from cart
class ClearCart {
  const ClearCart(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  /// Returns empty cart after clearing
  Future<Cart> call() async {
    // Clear cart from storage
    await _repository.clearCart();

    // Return empty cart
    return const Cart();
  }
}


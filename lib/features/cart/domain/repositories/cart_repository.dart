import '../entities/cart.dart';

/// Repository interface for cart data operations
/// Defines contract for cart data access
abstract class CartRepository {
  /// Get current cart
  Future<Cart> getCart();

  /// Watch cart changes (stream)
  Stream<Cart> watchCart();

  /// Save cart to local storage
  Future<void> saveCart(Cart cart);

  /// Clear all cart data
  Future<void> clearCart();

  /// Get last saved cart timestamp
  Future<DateTime?> getLastUpdated();
}


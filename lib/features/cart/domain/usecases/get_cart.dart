import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Use case for retrieving the current cart
class GetCart {
  const GetCart(this._repository);

  final CartRepository _repository;

  /// Execute the use case
  Future<Cart> call() async {
    return await _repository.getCart();
  }
}


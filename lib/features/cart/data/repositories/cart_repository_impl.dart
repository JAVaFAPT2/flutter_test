import 'dart:async';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_model.dart';

/// Implementation of cart repository
/// Handles cart data access through local data source
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._localDataSource);

  final CartLocalDataSource _localDataSource;

  // Stream controller for cart updates
  final _cartController = StreamController<Cart>.broadcast();

  @override
  Future<Cart> getCart() async {
    final cartModel = await _localDataSource.getCart();
    if (cartModel == null) {
      return const Cart();
    }
    return cartModel.toEntity();
  }

  @override
  Stream<Cart> watchCart() {
    return _cartController.stream;
  }

  @override
  Future<void> saveCart(Cart cart) async {
    final cartModel = CartModel.fromEntity(cart);
    await _localDataSource.saveCart(cartModel);

    // Notify watchers
    _cartController.add(cart);
  }

  @override
  Future<void> clearCart() async {
    await _localDataSource.clearCart();

    // Notify watchers
    _cartController.add(const Cart());
  }

  @override
  Future<DateTime?> getLastUpdated() async {
    return await _localDataSource.getLastUpdated();
  }

  /// Dispose stream controller
  void dispose() {
    _cartController.close();
  }
}


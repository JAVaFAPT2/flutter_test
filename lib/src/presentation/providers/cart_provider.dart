import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';

/// Cart item model
class CartItem {
  const CartItem({
    required this.product,
    required this.quantity,
    this.addedAt,
  });

  final Product product;
  final int quantity;
  final DateTime? addedAt;

  double get totalPrice => product.displayPrice * quantity;

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(0)}₫';

  CartItem copyWith({
    Product? product,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

/// Cart state
class CartState {
  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(0)}₫';

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Provider for shopping cart state management
class CartProvider extends ChangeNotifier {
  CartProvider();

  CartState _state = const CartState();
  CartState get state => _state;

  /// Add product to cart
  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _state.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      final updatedItems = List<CartItem>.from(_state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + quantity,
      );
      _state = _state.copyWith(items: updatedItems);
    } else {
      // Add new item
      final newItem = CartItem(
        product: product,
        quantity: quantity,
        addedAt: DateTime.now(),
      );
      _state = _state.copyWith(items: [..._state.items, newItem]);
    }

    notifyListeners();
  }

  /// Remove product from cart
  void removeFromCart(String productId) {
    final updatedItems = _state.items
        .where(
          (item) => item.product.id != productId,
        )
        .toList();
    _state = _state.copyWith(items: updatedItems);
    notifyListeners();
  }

  /// Update product quantity in cart
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final updatedItems = _state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    _state = _state.copyWith(items: updatedItems);
    notifyListeners();
  }

  /// Clear cart
  void clearCart() {
    _state = const CartState();
    notifyListeners();
  }

  /// Check if product is in cart
  bool isInCart(String productId) {
    return _state.items.any((item) => item.product.id == productId);
  }

  /// Get cart item for specific product
  CartItem? getCartItem(String productId) {
    try {
      return _state.items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  /// Get total number of items in cart
  int getTotalItems() {
    return _state.totalItems;
  }

  /// Get total price of cart
  double getTotalPrice() {
    return _state.totalPrice;
  }
}

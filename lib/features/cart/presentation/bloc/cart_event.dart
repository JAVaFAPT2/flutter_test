part of 'cart_bloc.dart';

/// Base class for cart events
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load cart from storage
class CartLoadRequested extends CartEvent {
  const CartLoadRequested();
}

/// Event to add item to cart
class CartItemAdded extends CartEvent {
  const CartItemAdded({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.volume,
  });

  final ProductEntity product;
  final int quantity;
  final String? volume;
  final int unitPrice;

  @override
  List<Object?> get props => [product, quantity, volume, unitPrice];
}

/// Event to remove item from cart
class CartItemRemoved extends CartEvent {
  const CartItemRemoved({
    required this.productId,
    this.volume,
  });

  final String productId;
  final String? volume;

  @override
  List<Object?> get props => [productId, volume];
}

/// Event to update item quantity
class CartItemQuantityUpdated extends CartEvent {
  const CartItemQuantityUpdated({
    required this.productId,
    required this.quantity,
    this.volume,
  });

  final String productId;
  final int quantity;
  final String? volume;

  @override
  List<Object?> get props => [productId, quantity, volume];
}

/// Event to clear entire cart
class CartCleared extends CartEvent {
  const CartCleared();
}

/// Event to toggle edit mode
class CartEditModeToggled extends CartEvent {
  const CartEditModeToggled(this.isEditing);

  final bool isEditing;

  @override
  List<Object?> get props => [isEditing];
}

/// Event to toggle item selection
class CartItemSelectionToggled extends CartEvent {
  const CartItemSelectionToggled({
    required this.productId,
    required this.isSelected,
    this.volume,
  });

  final String productId;
  final bool isSelected;
  final String? volume;

  @override
  List<Object?> get props => [productId, isSelected, volume];
}

/// Event to toggle select all items
class CartSelectAllToggled extends CartEvent {
  const CartSelectAllToggled(this.isSelected);

  final bool isSelected;

  @override
  List<Object?> get props => [isSelected];
}

/// Event to delete selected items
class CartDeleteSelectedRequested extends CartEvent {
  const CartDeleteSelectedRequested();
}

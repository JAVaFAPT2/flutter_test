part of '../bloc/cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded({
    required this.product,
    this.quantity = 1,
    this.volume,
    this.unitPrice,
  });
  final domain.Product product;
  final int quantity;
  final String? volume;
  final int? unitPrice;
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved({
    required this.productId,
    this.volume,
  });
  final String productId;
  final String? volume;
}

class CartItemQuantityUpdated extends CartEvent {
  const CartItemQuantityUpdated({
    required this.productId,
    required this.quantity,
    this.volume,
  });
  final String productId;
  final int quantity;
  final String? volume;
}

class CartCleared extends CartEvent {
  const CartCleared();
}

class CartEditModeToggled extends CartEvent {
  const CartEditModeToggled({required this.isEditing});
  final bool isEditing;
  @override
  List<Object?> get props => [isEditing];
}

class CartItemSelectionToggled extends CartEvent {
  const CartItemSelectionToggled({
    required this.productId,
    this.volume,
    required this.isSelected,
  });
  final String productId;
  final String? volume;
  final bool isSelected;
  @override
  List<Object?> get props => [productId, volume, isSelected];
}

class CartSelectAllToggled extends CartEvent {
  const CartSelectAllToggled({required this.isSelected});
  final bool isSelected;
  @override
  List<Object?> get props => [isSelected];
}

class CartDeleteSelectedRequested extends CartEvent {
  const CartDeleteSelectedRequested();
}

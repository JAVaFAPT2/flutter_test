part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded({required this.product, this.quantity = 1});
  final domain.Product product;
  final int quantity;
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved({required this.productId});
  final String productId;
}

class CartItemQuantityUpdated extends CartEvent {
  const CartItemQuantityUpdated({required this.productId, required this.quantity});
  final String productId;
  final int quantity;
}

class CartCleared extends CartEvent {
  const CartCleared();
}


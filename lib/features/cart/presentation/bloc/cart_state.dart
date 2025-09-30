part of 'cart_bloc.dart';

class CartItem extends Equatable {
  const CartItem({required this.product, required this.quantity, this.addedAt});
  final domain.Product product;
  final int quantity;
  final DateTime? addedAt;

  double get totalPrice => product.displayPrice * quantity;

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(0)}đ';

  CartItem copyWith(
      {domain.Product? product, int? quantity, DateTime? addedAt}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  List<Object?> get props => [product, quantity, addedAt];
}

class CartState extends Equatable {
  const CartState(
      {this.items = const [], this.isLoading = false, this.errorMessage});
  final List<CartItem> items;
  final bool isLoading;
  final String? errorMessage;

  int get totalItems => items.fold(0, (s, i) => s + i.quantity);
  double get totalPrice => items.fold(0.0, (s, i) => s + i.totalPrice);

  CartState copyWith(
      {List<CartItem>? items, bool? isLoading, String? errorMessage}) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, errorMessage];
}

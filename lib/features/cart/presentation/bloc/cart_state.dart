part of 'cart_bloc.dart';

/// State for cart
/// Contains domain cart entity and UI state
class CartState extends Equatable {
  const CartState({
    this.cart = const Cart(),
    this.isLoading = false,
    this.errorMessage,
  });

  final Cart cart;
  final bool isLoading;
  final String? errorMessage;

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [cart, isLoading, errorMessage];

  // Expose cart properties for convenience
  List<CartItem> get items => cart.items;
  Set<String> get selectedVariantKeys => cart.selectedVariantKeys;
  bool get isEditing => cart.isEditing;
  bool get isEmpty => cart.isEmpty;
  int get itemCount => cart.itemCount;
  int get totalQuantity => cart.totalQuantity;
  int get subtotal => cart.subtotal;
  String get formattedSubtotal => cart.formattedSubtotal;
  int get shippingFee => cart.shippingFee;
  String get formattedShippingFee => cart.formattedShippingFee;
  int get total => cart.total;
  String get formattedTotal => cart.formattedTotal;
  bool get allItemsSelected => cart.allItemsSelected;
  int get selectedItemsCount => cart.selectedItemsCount;

  // Selected items getter
  List<CartItem> get selectedItems => cart.items
      .where((item) => cart.selectedVariantKeys.contains(item.variantKey))
      .toList();

  // Selected total getter
  int get selectedTotal =>
      selectedItems.fold<int>(0, (sum, item) => sum + item.totalPrice);
}

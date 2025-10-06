part of 'cart_bloc.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.product,
    required this.quantity,
    this.addedAt,
    this.volume,
    this.unitPrice,
  });
  final domain.Product product;
  final int quantity;
  final DateTime? addedAt;
  final String? volume;
  final int? unitPrice;

  /// Get the variant key for this cart item (productId + volume)
  String get variantKey =>
      volume != null ? '${product.id}_$volume' : product.id;

  /// Get the effective unit price (from variant or product)
  double get effectiveUnitPrice =>
      unitPrice?.toDouble() ?? product.displayPrice;

  double get totalPrice => effectiveUnitPrice * quantity;

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(0)}đ';

  String get displayName =>
      volume != null ? '${product.name} ($volume)' : product.name;

  CartItem copyWith({
    domain.Product? product,
    int? quantity,
    DateTime? addedAt,
    String? volume,
    int? unitPrice,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      volume: volume ?? this.volume,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  List<Object?> get props => [product, quantity, addedAt, volume, unitPrice];
}

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isEditing = false,
    this.selectedVariantKeys = const {},
  });
  final List<CartItem> items;
  final bool isLoading;
  final String? errorMessage;
  final bool isEditing;
  final Set<String> selectedVariantKeys;

  int get totalItems => items.fold(0, (s, i) => s + i.quantity);
  double get totalPrice => items.fold(0.0, (s, i) => s + i.totalPrice);

  // Selection-based getters
  List<CartItem> get selectedItems =>
      items.where((i) => selectedVariantKeys.contains(i.variantKey)).toList();
  int get selectedCount => selectedItems.fold(0, (s, i) => s + i.quantity);
  double get selectedTotal =>
      selectedItems.fold(0.0, (s, i) => s + i.totalPrice);
  bool get allSelected =>
      items.isNotEmpty && selectedVariantKeys.length == items.length;

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? errorMessage,
    bool? isEditing,
    Set<String>? selectedVariantKeys,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditing: isEditing ?? this.isEditing,
      selectedVariantKeys: selectedVariantKeys ?? this.selectedVariantKeys,
    );
  }

  @override
  List<Object?> get props =>
      [items, isLoading, errorMessage, isEditing, selectedVariantKeys];
}

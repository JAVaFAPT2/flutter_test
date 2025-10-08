import 'package:equatable/equatable.dart';
import 'cart_item.dart';

/// Pure domain entity representing a shopping cart
/// Framework-agnostic and immutable
class Cart extends Equatable {
  const Cart({
    this.items = const [],
    this.selectedVariantKeys = const {},
    this.isEditing = false,
  });

  final List<CartItem> items;
  final Set<String> selectedVariantKeys;
  final bool isEditing;

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Get total number of items in cart
  int get itemCount => items.length;

  /// Get total quantity of all items
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  /// Calculate subtotal (sum of all item prices)
  int get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Get formatted subtotal
  String get formattedSubtotal {
    return subtotal.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// Calculate shipping fee (business logic)
  int get shippingFee {
    if (subtotal >= 500000) return 0; // Free shipping over 500k VND
    if (subtotal >= 200000) return 15000; // 15k VND for 200k-500k
    return 30000; // 30k VND for under 200k
  }

  /// Get formatted shipping fee
  String get formattedShippingFee {
    return shippingFee.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// Calculate total (subtotal + shipping)
  int get total => subtotal + shippingFee;

  /// Get formatted total
  String get formattedTotal {
    return total.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// Check if all items are selected
  bool get allItemsSelected =>
      items.isNotEmpty && selectedVariantKeys.length == items.length;

  /// Get selected items count
  int get selectedItemsCount => selectedVariantKeys.length;

  /// Find item by variant key
  CartItem? findItemByVariantKey(String variantKey) {
    try {
      return items.firstWhere((item) => item.variantKey == variantKey);
    } catch (_) {
      return null;
    }
  }

  Cart copyWith({
    List<CartItem>? items,
    Set<String>? selectedVariantKeys,
    bool? isEditing,
  }) {
    return Cart(
      items: items ?? this.items,
      selectedVariantKeys: selectedVariantKeys ?? this.selectedVariantKeys,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [items, selectedVariantKeys, isEditing];
}


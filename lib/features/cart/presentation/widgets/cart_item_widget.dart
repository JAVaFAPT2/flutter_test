import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart_item.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.cartState,
  });

  final CartItem cartItem;
  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Selection Checkbox (only in edit mode)
              // Product Image
              _buildProductImage(),

              const SizedBox(width: 21),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      cartItem.product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E3620),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Category
                    Text(
                      'Mặt hàng: ${cartItem.product.category}',
                      style: const TextStyle(
                        fontSize: 6,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price
                    Text(
                      'Giá: ${cartItem.product.formattedPrice}/Chai',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Total price
                    Text(
                      'Thành tiền: ${cartItem.formattedTotalPrice}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC80000),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Quantity controls
                    _buildQuantityControls(context),
                  ],
                ),
              ),
            ],
          ),
          if (cartState.isEditing)
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  context.read<CartBloc>().add(
                        CartItemSelectionToggled(
                          productId: cartItem.product.id,
                          volume: cartItem.volume,
                          isSelected: !cartState.selectedVariantKeys
                              .contains(cartItem.variantKey),
                        ),
                      );
                },
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: cartState.selectedVariantKeys
                            .contains(cartItem.variantKey)
                        ? const Color(0xFF0B5C2B)
                        : Colors.white,
                    border: Border.all(
                      color: const Color(0xFF7D7D7D),
                      width: 1,
                    ),
                  ),
                  child: cartState.selectedVariantKeys
                          .contains(cartItem.variantKey)
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 79,
      height: 78,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF004917)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          cartItem.product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 24,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Container(
      height: 14,
      width: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.7),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Decrease button
          GestureDetector(
            onTap: () => _decreaseQuantity(context),
            child: Container(
              width: 40,
              height: 14,
              alignment: Alignment.center,
              child: const Text(
                '-',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Quantity display
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                cartItem.quantity.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Increase button
          GestureDetector(
            onTap: () => _increaseQuantity(context),
            child: Container(
              width: 40,
              height: 14,
              alignment: Alignment.center,
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _decreaseQuantity(BuildContext context) {
    if (cartItem.quantity > 1) {
      context.read<CartBloc>().add(CartItemQuantityUpdated(
            productId: cartItem.product.id,
            volume: cartItem.volume,
            quantity: cartItem.quantity - 1,
          ));
    }
  }

  void _increaseQuantity(BuildContext context) {
    context.read<CartBloc>().add(CartItemQuantityUpdated(
          productId: cartItem.product.id,
          volume: cartItem.volume,
          quantity: cartItem.quantity + 1,
        ));
  }
}

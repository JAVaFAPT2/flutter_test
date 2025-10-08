import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';

class CartEditToolbar extends StatelessWidget {
  const CartEditToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Left-aligned label with close icon (matches Figma)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.read<CartBloc>().add(
                      CartEditModeToggled(!state.isEditing),
                    ),
                child: const Row(
                  children: [
                    Icon(Icons.close, size: 18, color: Color(0xFF1E1E1E)),
                    SizedBox(width: 8),
                    Text(
                      'Chỉnh sửa giỏ hàng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Edit mode controls (only visible when editing)
              if (state.isEditing)
                Row(
                  children: [
                    // Select all (dot + label)
                    GestureDetector(
                      onTap: () => context.read<CartBloc>().add(
                            CartSelectAllToggled(
                              state.selectedVariantKeys.length !=
                                  state.items.length,
                            ),
                          ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7A0000),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Chọn tất cả',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF1E1E1E)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Delete (grey dot + label when disabled)
                    GestureDetector(
                      onTap: state.selectedVariantKeys.isNotEmpty
                          ? () => _showDeleteDialog(context)
                          : null,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: state.selectedVariantKeys.isNotEmpty
                                  ? const Color(0xFFEA3125)
                                  : const Color(0xFFBDBDBD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Xóa',
                            style: TextStyle(
                              fontSize: 13,
                              color: state.selectedVariantKeys.isNotEmpty
                                  ? const Color(0xFF1E1E1E)
                                  : const Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final state = context.read<CartBloc>().state;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa sản phẩm đã chọn'),
        content: Text(
          'Bạn có chắc chắn muốn xóa ${state.selectedItemsCount} sản phẩm đã chọn?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CartBloc>().add(const CartDeleteSelectedRequested());
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEA3125),
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa tất cả'),
          ),
        ],
      ),
    );
  }
}

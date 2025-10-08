import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_detail_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/cubit/favorite_cubit.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/widgets/product_detail_shimmer.dart';
import 'package:vietnamese_fish_sauce_app/core/di/injection_container.dart'
    as di;

/// Product detail page matching Figma design
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailBloc>(
          create: (context) => di.getIt<ProductDetailBloc>()
            ..add(ProductDetailLoadRequested(widget.productId)),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit()..loadFavorites(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const ProductDetailShimmer();
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Có lỗi: ${state.errorMessage}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ProductDetailBloc>()
                          .add(ProductDetailLoadRequested(widget.productId)),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            if (state.product != null) {
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    // Product Images Section
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 362.0, // Match Figma design exactly
                      child: Container(
                        color: Colors.white,
                        child: Image.asset(
                          state.product!.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.red,
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'LỖI HÌNH ẢNH',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Back Button and Favorite Button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(
                                    alpha: 0.6), // Improved visibility
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, favoriteState) {
                              final isFavorite = favoriteState is FavoriteLoaded
                                  ? favoriteState.isFavorite(state.product!.id)
                                  : false;

                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<FavoriteCubit>()
                                      .toggleFavorite(state.product!.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(
                                        alpha: 0.6), // Improved visibility
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Product Details Sheet
                    Positioned(
                      top: 264.0, // Match Figma design exactly
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(AppColors.surfaceCream),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, -3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(
                          left: 51, // Match Figma left padding
                          right: 20,
                          top:
                              42, // Top padding to match Figma content positioning
                          bottom:
                              16 + 100, // Extra space for positioned bottom nav
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name
                              Text(
                                state.product!.name,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Color(AppColors.textTitle),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Product Subtitle
                              Text(
                                state.product!.subtitle,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppColors.textMuted),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Price
                              Builder(builder: (context) {
                                final volumePrice = state.product!
                                    .getPriceForVolume(state.selectedVolume);
                                return Text(
                                  '${volumePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ',
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    color: Color(AppColors.price),
                                  ),
                                );
                              }),
                              const SizedBox(height: 12),

                              // Rating
                              Row(
                                children: List.generate(5, (index) {
                                  return Container(
                                    width: 32,
                                    height: 32,
                                    margin: const EdgeInsets.only(right: 3),
                                    child: const Icon(
                                      Icons.star,
                                      color: Color(AppColors.star),
                                      size: 28,
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 12),

                              // Description
                              Text(
                                'Nước mắm nhĩ cá cơm than là loại món ăn bổ dưỡng bậc nhất, với 13 loại enzyme mà cơ thể con người không thể tự tổng hợp được, rất cần thiết cho hệ thần kinh của ch如果我们 ta.',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(AppColors.textBody),
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Volume selector
                              Text(
                                'Dung tích chai',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppColors.textTitle),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Volume buttons
                              Row(
                                children: [
                                  _buildVolumeButton(
                                    '500 ML',
                                    0,
                                    state,
                                    context.read<ProductDetailBloc>(),
                                  ),
                                  const SizedBox(width: 26),
                                  _buildVolumeButton(
                                    '330 ML',
                                    1,
                                    state,
                                    context.read<ProductDetailBloc>(),
                                  ),
                                  const SizedBox(width: 26),
                                  _buildVolumeButton(
                                    '250 ML',
                                    2,
                                    state,
                                    context.read<ProductDetailBloc>(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Quantity selector and Total Price
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Số lượng',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Color(AppColors.textTitle),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Builder(builder: (context) {
                                        return Container(
                                          height: 31,
                                          width: 111,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: const Color(0xFFE0E0E0),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () => context
                                                    .read<ProductDetailBloc>()
                                                    .add(
                                                        const ProductDetailQuantityDecremented()),
                                                child: const SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Color(0xFF333333),
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 33,
                                                child: Text(
                                                  state.quantity
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => context
                                                    .read<ProductDetailBloc>()
                                                    .add(
                                                        const ProductDetailQuantityIncremented()),
                                                child: const SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color(0xFF333333),
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(width: 18),
                                  // Total price box
                                  Expanded(
                                    child: Builder(builder: (context) {
                                      final totalPrice = state.product!
                                          .getTotalPrice(state.selectedVolume,
                                              state.quantity);

                                      return Container(
                                        height: 31,
                                        decoration: BoxDecoration(
                                          color: Color(AppColors.accentOrange),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color(AppColors.accentOrange)
                                                      .withValues(alpha: 0.3),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Thành tiền',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 20,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              color: Colors.white
                                                  .withValues(alpha: 0.3),
                                            ),
                                            Text(
                                              totalPrice
                                                  .toString()
                                                  .replaceAllMapped(
                                                      RegExp(
                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => '${m[1]},'),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Add to cart button
                              SizedBox(
                                width: double.infinity,
                                child: Builder(builder: (context) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      // Add to cart functionality
                                      final cartBloc = context.read<CartBloc>();
                                      cartBloc.add(CartItemAdded(
                                        product: state.product!,
                                        volume: state.selectedVolume,
                                        unitPrice: state.product!
                                            .getPriceForVolume(
                                                state.selectedVolume),
                                        quantity: state.quantity,
                                      ));

                                      // Show success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Đã thêm vào giỏ hàng'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              const Color(0xFF4CAF50),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color(AppColors.ctaBrown),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: const Text(
                                      'Thêm vào giỏ hàng',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Bottom navigation positioned at bottom
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: HomeBottomNavigation(),
                    ),
                  ],
                ),
              );
            }

            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVolumeButton(String volume, int index, ProductDetailState state,
      ProductDetailBloc bloc) {
    final isSelected = state.selectedVolumeIndex == index;
    return GestureDetector(
      onTap: () {
        bloc.add(ProductDetailVolumeChanged(index));
      },
      child: Container(
        width: 94,
        height: 33,
        decoration: BoxDecoration(
          color: isSelected ? Color(AppColors.selected) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected
                ? Color(AppColors.selected)
                : const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color(AppColors.selected).withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            volume.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}

// ... existing code ...

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_list_bloc.dart'
    as ddd;
import 'package:vietnamese_fish_sauce_app/features/product/presentation/cubit/products_view_cubit.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:vietnamese_fish_sauce_app/src/core/di/injection_container.dart'
    as di;
import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart'
    as domain;

/// Vietnamese Fish Sauce Products Page - Matches Figma Design
///
/// This page displays fish sauce products in a list format matching the exact
/// Figma design with Vietnamese text, pricing in VND, and product cards.
class FishSauceProductsPage extends StatefulWidget {
  const FishSauceProductsPage({super.key});

  static const String routeName = '/fish-sauce-products';

  @override
  State<FishSauceProductsPage> createState() => _FishSauceProductsPageState();
}

class _FishSauceProductsPageState extends State<FishSauceProductsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ddd.ProductListBloc>().add(
            const ddd.ProductListLoadMoreRequested(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsViewCubit>(
          create: (_) => ProductsViewCubit(),
        ),
        BlocProvider<ddd.ProductListBloc>(
          create: (_) => di.getIt<ddd.ProductListBloc>()
            ..add(const ddd.ProductListLoadRequested(page: 1, limit: 20)),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5DC), // Warm beige background
        body: SafeArea(
          child: Column(
            children: [
              // Header Section - Matches Figma exactly
              _buildHeader(context),

              // Search Bar - Matches Figma design
              _buildSearchBar(context),

              // Product Category Title
              _buildCategoryTitle(context),

              // Products List
              Expanded(
                child: BlocBuilder<ddd.ProductListBloc, ddd.ProductListState>(
                  builder: (context, state) {
                    if (state.isLoading && state.products.isEmpty) {
                      return _buildLoadingView();
                    }

                    if (state.errorMessage != null && state.products.isEmpty) {
                      return _buildErrorView(state.errorMessage!);
                    }

                    if (state.products.isEmpty) {
                      return _buildEmptyView();
                    }

                    return _buildProductsList(state.products);
                  },
                ),
              ),

              // Order Banner - Matches Figma design
              _buildOrderBanner(context),

              // Bottom Navigation - Matches Figma design
              _buildBottomNavigation(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          // Logo MGF
          Container(
            width: 82,
            height: 37,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'MGF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // MGF Healthy Choice
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MGF',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'HEALTHY CHOICE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC80000),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Greeting and Avatar
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Xin chào,',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF030303),
                    ),
                  ),
                  Text(
                    'Nguyen Van A',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF900407),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 21.5,
                backgroundColor: Color(0xFF900407),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          // Filter Button
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15.5),
            ),
            child: const Icon(
              Icons.tune,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          // Search Bar
          Expanded(
            child: Container(
              height: 29,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.5),
                border: Border.all(color: const Color(0xFF3C3C3C)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.search,
                    size: 17,
                    color: Color(0xFFBBBBBB),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 11,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.read<ddd.ProductListBloc>().add(
                                ddd.ProductListSearchRequested(value),
                              );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'NƯỚC MẮM NHĨ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA70000),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(List<ProductEntity> products) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 44),
      itemCount: products.length + 1, // +1 for load more indicator
      itemBuilder: (context, index) {
        if (index == products.length) {
          // Load more indicator
          return BlocBuilder<ddd.ProductListBloc, ddd.ProductListState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        }

        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(ProductEntity product) {
    final firstVolume =
        product.volumes.isNotEmpty ? product.volumes.first : '500ml';
    final price = product.getFormattedPriceForVolume(firstVolume);

    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 128,
            height: 82,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E3620),
                  ),
                ),
                const SizedBox(height: 6),

                // Original Price
                if (product.originalPrice.isNotEmpty)
                  Text(
                    '${product.originalPrice} (VNĐ)/Chai. Chiết khấu: ${product.discountPercentage}(%)',
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF989898),
                    ),
                  ),
                const SizedBox(height: 6),

                // Current Price
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEA3125),
                  ),
                ),
                const SizedBox(height: 12),

                // Add to Cart and Quantity Controls
                Row(
                  children: [
                    // Add to Cart Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _addToCart(product, firstVolume),
                        child: Container(
                          height: 17,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Thêm vào giỏ hàng',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Quantity Controls
                    Container(
                      width: 60,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Decrease quantity logic
                            },
                            child: const Text(
                              '-',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Text(
                            '01',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Increase quantity logic
                            },
                            child: const Text(
                              '+',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF004917),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đặt hàng ngay',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'hôm nay!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '"Món quà cho những người bạn"',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 84,
            height: 85,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 95,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Cart Icon
          _buildNavItem(Icons.shopping_cart, false),

          // Orders Icon
          _buildNavItem(Icons.receipt_long, false),

          // Home Icon (Active)
          Container(
            width: 89,
            height: 89,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(325),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Container(
              width: 67,
              height: 67,
              margin: const EdgeInsets.all(11),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 37,
              ),
            ),
          ),

          // Notifications Icon
          Stack(
            children: [
              _buildNavItem(Icons.notifications, false),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          // Profile Icon
          _buildNavItem(Icons.person, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey,
        size: 24,
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView(String message) {
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
            'Lỗi: $message',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ddd.ProductListBloc>().add(
                    const ddd.ProductListRefreshRequested(),
                  );
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Không tìm thấy sản phẩm',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Chưa có sản phẩm nào được tải',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(ProductEntity product, String volume) {
    final cartBloc = context.read<CartBloc>();

    // Convert ProductEntity to domain.Product
    final domainProduct = domain.Product(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.getPriceForVolume(volume).toDouble(),
      originalPrice: double.tryParse(
            product.originalPrice.replaceAll(RegExp(r'[^\d]'), ''),
          )?.toDouble() ??
          product.getPriceForVolume(volume).toDouble(),
      imageUrl: product.imageUrl,
      category: product.category,
      brand: product.brand,
      volume: volume,
      ingredients: product.ingredients,
      origin: product.origin,
      rating: product.rating,
      reviewCount: product.reviewCount,
      isAvailable: product.inStock,
      isFeatured: product.isFeatured,
      isOnSale: product.isOnSale,
      discountPercentage: product.discountPercentage,
      stockQuantity: product.stockQuantity,
      nutritionInfo:
          product.nutritionInfo.isEmpty ? null : product.nutritionInfo,
    );

    cartBloc.add(CartItemAdded(
      product: domainProduct,
      quantity: 1,
      volume: volume,
      unitPrice: product.getPriceForVolume(volume),
    ));

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã thêm vào giỏ hàng'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}

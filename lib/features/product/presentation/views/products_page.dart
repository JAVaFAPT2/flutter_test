import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/src/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_list_bloc.dart'
    as ddd;
import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/src/core/di/injection_container.dart'
    as di;
import 'package:vietnamese_fish_sauce_app/features/product/presentation/cubit/products_view_cubit.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/widgets/loading_shimmer.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

// Widget imports
import '../widgets/figma_products_search.dart';
import '../widgets/figma_product_card.dart';
import '../widgets/figma_products_banner.dart';
import '../widgets/products_bottom_navigation.dart';
import '../widgets/figma_filter_dropdown.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_app_bar.dart';

/// Products listing page following clean architecture principles
///
/// Matches Figma design while following established patterns from other screens
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const String routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsViewCubit>(create: (_) => ProductsViewCubit()),
        BlocProvider<ddd.ProductListBloc>(
          create: (_) => di.getIt<ddd.ProductListBloc>()
            ..add(const ddd.ProductListLoadRequested(page: 1, limit: 20)),
        ),
      ],
      child: const ProductsPageView(),
    );
  }
}

class ProductsPageView extends StatefulWidget {
  const ProductsPageView({super.key});

  @override
  State<ProductsPageView> createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
  bool _isFilterOpen = false;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(const ProductLoadMoreRequested());
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),

          // Main content
          Positioned.fill(
            child: Column(
              children: [
                // Header (same as home page)
                const HomeAppBar(),

                // Content
                Expanded(
                  child: BlocBuilder<ddd.ProductListBloc, ddd.ProductListState>(
                    builder: (context, state) {
                      if (state.isLoading && state.products.isEmpty) {
                        return _buildLoadingView(context);
                      }
                      if (state.errorMessage != null &&
                          state.products.isEmpty) {
                        return _buildErrorView(context, state.errorMessage!);
                      }

                      final uiProducts = _mapProducts(state.products);
                      return _buildProductsView(
                          context, uiProducts, scrollController);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Filter dropdown (overlay)
          if (_isFilterOpen)
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: FigmaFilterDropdown(
                categories: [
                  'Show All',
                  'Xuân Thịnh Mậu',
                  'Vĩnh Thái',
                  'Phú Quốc'
                ],
                selectedCategory: _selectedCategory,
                onCategorySelected: (brand) {
                  setState(() {
                    _selectedCategory = brand;
                    _isFilterOpen = false;
                  });

                  // Apply filter to product list by brand
                  context.read<ddd.ProductListBloc>().add(
                        ddd.ProductListFilterChanged(
                          brand: brand == 'Show All' ? null : brand,
                          limit: 20,
                        ),
                      );
                },
              ),
            ),

          // Bottom navigation (fixed position)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: _buildProductsBottomNavigation(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsView(BuildContext context, List<domain.Product> products,
      ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          // Back button and title
          _buildProductsHeader(context),

          // Search section
          FigmaProductsSearch(
            onFilterTap: () {
              setState(() {
                _isFilterOpen = !_isFilterOpen;
              });
            },
            onSearchTap: () => _showSearchDialog(context),
          ),

          // Category title
          _buildCategoryTitle(),

          // Products list
          ...products.map((product) => FigmaProductCard(
                product: product,
                onTap: () => _navigateToProductDetail(context, product),
                onAddToCart: () => _addToCart(context, product),
              )),

          // Banner section
          const FigmaProductsBanner(),

          // Bottom spacing for navigation
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildProductsHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Expanded(
            child: Text(
              'Sản phẩm',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter is now handled by FigmaFilterDropdown overlay
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        'NƯỚC MẮM NHĨ',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.red[800],
        ),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    final isGridView = context.watch<ProductsViewCubit>().state.isGridView;
    return LoadingShimmer(
      itemCount: 10,
      isGridView: isGridView,
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ddd.ProductListBloc>().add(
                    const ddd.ProductListLoadRequested(page: 1, limit: 20),
                  );
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsBottomNavigation() {
    return const ProductsBottomNavigation();
  }

  List<domain.Product> _mapProducts(List<ProductEntity> domainProducts) {
    return domainProducts
        .map((e) => domain.Product(
              id: e.id,
              name: e.name,
              description: e.description,
              price:
                  double.tryParse(e.price.replaceAll(RegExp(r'[^\d]'), '')) ??
                      0,
              originalPrice: double.tryParse(
                      e.originalPrice.replaceAll(RegExp(r'[^\d]'), '')) ??
                  0,
              imageUrl: e.imageUrl,
              category: e.category,
              brand: e.brand,
              volume: e.volumes.isNotEmpty ? e.volumes.first : '500ml',
              ingredients: e.ingredients,
              origin: e.origin,
              rating: e.rating,
              reviewCount: e.reviewCount,
              isAvailable: e.inStock,
              isFeatured: e.isFeatured,
              isOnSale: e.isOnSale,
              discountPercentage: e.discountPercentage,
              stockQuantity: e.stockQuantity,
              nutritionInfo: e.nutritionInfo,
            ))
        .toList();
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ProductSearchDialog(),
    );
  }

  void _navigateToProductDetail(BuildContext context, domain.Product product) {
    context.read<NavigationCubit>().navigateToProductDetail(context, product);
  }

  void _addToCart(BuildContext context, domain.Product product) {
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${product.name} to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

/// Product search dialog
class ProductSearchDialog extends StatefulWidget {
  const ProductSearchDialog({super.key});

  @override
  State<ProductSearchDialog> createState() => _ProductSearchDialogState();
}

class _ProductSearchDialogState extends State<ProductSearchDialog> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.search),
      content: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: AppStrings.searchProducts,
          prefixIcon: Icon(Icons.search),
        ),
        autofocus: true,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context
                .read<ddd.ProductListBloc>()
                .add(ddd.ProductListSearchRequested(value));
            Navigator.of(context).pop();
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final query = _searchController.text.trim();
            if (query.isNotEmpty) {
              context
                  .read<ddd.ProductListBloc>()
                  .add(ddd.ProductListSearchRequested(query));
              Navigator.of(context).pop();
            }
          },
          child: const Text(AppStrings.search),
        ),
      ],
    );
  }
}

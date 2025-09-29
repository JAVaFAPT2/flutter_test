import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/errors/app_error.dart';
import '../../domain/entities/product.dart';
import '../../../features/product/presentation/bloc/product_bloc.dart';
import '../../../features/product/presentation/cubit/products_view_cubit.dart';
import '../widgets/product_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_message.dart';

/// Products listing page for Vietnamese fish sauce e-commerce app
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const String routeName = '/products';

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
      appBar: AppBar(
        title: const Text(AppStrings.products),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          // View toggle button
          BlocBuilder<ProductsViewCubit, ProductsViewState>(
            builder: (context, viewState) {
              return IconButton(
                icon: Icon(viewState.isGridView ? Icons.list : Icons.grid_view),
                onPressed: () => context.read<ProductsViewCubit>().toggleView(),
              );
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsViewCubit>(create: (_) => ProductsViewCubit()),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.isLoading && state.products.isEmpty) {
              return _buildLoadingView(context);
            }
            if (state.errorMessage != null && state.products.isEmpty) {
              return _buildErrorView(context, state.errorMessage!);
            }
            return _buildProductsView(context, state.products, scrollController);
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ErrorMessage(message: message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(const ProductRefreshRequested());
              },
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsView(BuildContext context, List<Product> products, ScrollController scrollController) {
    final isGridView = context.watch<ProductsViewCubit>().state.isGridView;
    if (products.isEmpty) {
      return _buildEmptyView(context);
    }

    return Column(
      children: [
        // Category/Filter Info Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade50,
          child: Row(
            children: [
              Text(
                '${products.length} ${AppStrings.products}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                '${AppConstants.currencySymbol} ${AppConstants.productBrands.first}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),

        // Products List/Grid
        Expanded(
          child:
              isGridView ? _buildGridView(context, products, scrollController) : _buildListView(context, products, scrollController),
        ),

        // Load More Indicator
        if (context.watch<ProductBloc>().state.isLoading)
          Container(
            padding: const EdgeInsets.all(16),
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noResults,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Chưa có sản phẩm nào được tải',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ProductBloc>().add(const ProductRefreshRequested());
            },
            child: const Text(AppStrings.tryAgain),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<Product> products, ScrollController scrollController) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => _navigateToProductDetail(products[index]),
          showCartButton: true,
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Product> products, ScrollController scrollController) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return ProductListItem(
          product: products[index],
          onTap: () => _navigateToProductDetail(products[index]),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Scroll to top
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.arrow_upward),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => const ProductSearchDialog(),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => const ProductFilterDialog(),
    );
  }

  void _navigateToProductDetail(Product product) {
    Navigator.of(context).pushNamed('/product-detail', arguments: product);
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
            context.read<ProductBloc>().add(ProductSearchRequested(value));
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
              context.read<ProductBloc>().add(ProductSearchRequested(query));
              Navigator.of(context).pop();
            }
          },
          child: const Text(AppStrings.search),
        ),
      ],
    );
  }
}

/// Product filter dialog
class ProductFilterDialog extends StatefulWidget {
  const ProductFilterDialog({super.key});

  @override
  State<ProductFilterDialog> createState() => _ProductFilterDialogState();
}

class _ProductFilterDialogState extends State<ProductFilterDialog> {
  String? _selectedCategory;
  String? _selectedBrand;
  String? _sortBy = 'name';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.filters),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            Text(
              'Danh mục',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: AppConstants.productCategories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Brand Filter
            Text(
              'Thương hiệu',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: AppConstants.productBrands.map((brand) {
                return FilterChip(
                  label: Text(brand),
                  selected: _selectedBrand == brand,
                  onSelected: (selected) {
                    setState(() {
                      _selectedBrand = selected ? brand : null;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Sort Options
            Text(
              AppStrings.sort,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Tên A-Z'),
                  value: 'name',
                  groupValue: _sortBy,
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Giá thấp đến cao'),
                  value: 'price_asc',
                  groupValue: _sortBy,
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Giá cao đến thấp'),
                  value: 'price_desc',
                  groupValue: _sortBy,
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            // Apply filters
            context.read<ProductBloc>().add(ProductFilterChanged(
                  category: _selectedCategory,
                  brand: _selectedBrand,
                  sortBy: _sortBy,
                ));
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.confirm),
        ),
      ],
    );
  }
}

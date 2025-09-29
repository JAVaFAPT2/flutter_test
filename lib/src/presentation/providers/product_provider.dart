import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/errors/app_error.dart';
import '../../domain/entities/product.dart';
import '../../data/models/product_model.dart';

/// Product state
class ProductState {
  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  final List<Product> products;
  final bool isLoading;
  final AppError? error;
  final bool hasMore;
  final int currentPage;

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    AppError? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Provider for product state management
class ProductProvider extends ChangeNotifier {
  ProductProvider({
    required this.getProductsUseCase,
  });

  final GetProductsUseCase getProductsUseCase;

  ProductState _state = const ProductState();
  ProductState get state => _state;

  /// Load products
  Future<void> loadProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (page == 1) {
      _state = _state.copyWith(isLoading: true, error: null);
    } else {
      _state = _state.copyWith(isLoading: true);
    }
    notifyListeners();

    try {
      // Use sample data for development
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay

      // Convert sample data to Product entities
      final allProducts = AppConstants.sampleProducts.map((json) {
        final productModel = ProductModel.fromJson(json);
        return productModel.toEntity();
      }).toList();

      // Apply filters
      List<Product> filteredProducts = allProducts;

      if (category != null) {
        filteredProducts =
            filteredProducts.where((p) => p.category == category).toList();
      }

      if (brand != null) {
        filteredProducts =
            filteredProducts.where((p) => p.brand == brand).toList();
      }

      if (search != null && search.isNotEmpty) {
        final searchLower = search.toLowerCase();
        filteredProducts = filteredProducts
            .where((p) =>
                p.name.toLowerCase().contains(searchLower) ||
                p.description.toLowerCase().contains(searchLower) ||
                p.brand.toLowerCase().contains(searchLower))
            .toList();
      }

      // Apply sorting
      if (sortBy != null) {
        filteredProducts.sort((a, b) {
          switch (sortBy) {
            case 'name':
              return a.name.compareTo(b.name);
            case 'price_asc':
              return a.displayPrice.compareTo(b.displayPrice);
            case 'price_desc':
              return b.displayPrice.compareTo(a.displayPrice);
            case 'rating':
              return b.rating.compareTo(a.rating);
            default:
              return 0;
          }
        });
      }

      // Apply pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      final paginatedProducts = filteredProducts.sublist(
        startIndex,
        endIndex > filteredProducts.length ? filteredProducts.length : endIndex,
      );

      if (page == 1) {
        _state = _state.copyWith(
          products: paginatedProducts,
          isLoading: false,
          error: null,
          currentPage: page,
          hasMore: filteredProducts.length > endIndex,
        );
      } else {
        _state = _state.copyWith(
          products: [..._state.products, ...paginatedProducts],
          isLoading: false,
          error: null,
          currentPage: page,
          hasMore: filteredProducts.length > endIndex,
        );
      }
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: ErrorHandler.handleError(e),
      );
    }

    notifyListeners();
  }

  /// Load more products (pagination)
  Future<void> loadMoreProducts({
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (!_state.hasMore || _state.isLoading) return;

    await loadProducts(
      page: _state.currentPage + 1,
      limit: limit,
      category: category,
      brand: brand,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Refresh products
  Future<void> refreshProducts({
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    await loadProducts(
      page: 1,
      limit: limit,
      category: category,
      brand: brand,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    await loadProducts(
      page: 1,
      search: query,
    );
  }

  /// Filter by category
  Future<void> filterByCategory(String category) async {
    await loadProducts(
      page: 1,
      category: category,
    );
  }

  /// Filter by brand
  Future<void> filterByBrand(String brand) async {
    await loadProducts(
      page: 1,
      brand: brand,
    );
  }
}

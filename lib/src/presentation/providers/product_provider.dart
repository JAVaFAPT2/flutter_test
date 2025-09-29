import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/use_cases/product/get_products_use_case.dart';
import '../../domain/value_objects/result.dart';

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
  final String? error;
  final bool hasMore;
  final int currentPage;

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
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

    final result = await getProductsUseCase.execute(
      page: page,
      limit: limit,
      category: category,
      brand: brand,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    switch (result) {
      case Success<List<Product>>(:final data):
        if (page == 1) {
          _state = _state.copyWith(
            products: data,
            isLoading: false,
            error: null,
            currentPage: page,
            hasMore: data.length == limit,
          );
        } else {
          _state = _state.copyWith(
            products: [..._state.products, ...data],
            isLoading: false,
            error: null,
            currentPage: page,
            hasMore: data.length == limit,
          );
        }

      case Failure<List<Product>>(:final message):
        _state = _state.copyWith(
          isLoading: false,
          error: message,
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

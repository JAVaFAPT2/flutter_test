import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_products_query.dart';

part 'product_event.dart';
part 'product_state.dart';

/// ProductBloc - Clean DDD compliant
/// Thin orchestration layer that delegates to use cases
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required GetProductsQuery getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const ProductState()) {
    on<ProductLoadRequested>(_onLoadRequested);
    on<ProductLoadMoreRequested>(_onLoadMoreRequested);
    on<ProductRefreshRequested>(_onRefreshRequested);
    on<ProductSearchRequested>(_onSearchRequested);
    on<ProductFilterChanged>(_onFilterChanged);
  }

  final GetProductsQuery _getProductsUseCase;

  Future<void> _onLoadRequested(
    ProductLoadRequested event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final page = event.page ?? 1;
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Get all products from use case
      final allProducts = await _getProductsUseCase(
        category: event.category,
        brand: event.brand,
      );

      // Apply search filter if needed
      final filtered = _applySearchFilter(allProducts, event.search);

      // Apply sorting
      final sorted = _applySorting(filtered, event.sortBy);

      // Apply pagination
      final startIndex = (page - 1) * event.limit;
      final endIndex = startIndex + event.limit;
      final pageItems = sorted.sublist(
        startIndex,
        endIndex > sorted.length ? sorted.length : endIndex,
      );

      emit(state.copyWith(
        products: page == 1 ? pageItems : [...state.products, ...pageItems],
        isLoading: false,
        hasMore: sorted.length > endIndex,
        currentPage: page,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  Future<void> _onLoadMoreRequested(
    ProductLoadMoreRequested event,
    Emitter<ProductState> emit,
  ) async {
    if (!state.hasMore || state.isLoading) return;
    add(ProductLoadRequested(
      page: state.currentPage + 1,
      limit: event.limit,
      category: state.category,
      brand: state.brand,
      search: state.search,
      sortBy: state.sortBy,
    ));
  }

  Future<void> _onRefreshRequested(
    ProductRefreshRequested event,
    Emitter<ProductState> emit,
  ) async {
    add(ProductLoadRequested(
      page: 1,
      limit: event.limit,
      category: state.category,
      brand: state.brand,
      search: state.search,
      sortBy: state.sortBy,
    ));
  }

  Future<void> _onSearchRequested(
    ProductSearchRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(search: event.query));
    add(ProductLoadRequested(page: 1, limit: event.limit, search: event.query));
  }

  Future<void> _onFilterChanged(
    ProductFilterChanged event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
        category: event.category, brand: event.brand, sortBy: event.sortBy));
    add(ProductLoadRequested(page: 1, limit: event.limit));
  }

  /// Apply search filter
  List<ProductEntity> _applySearchFilter(
    List<ProductEntity> products,
    String? search,
  ) {
    if (search == null || search.isEmpty) return products;

    final q = search.toLowerCase();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q) ||
            p.brand.toLowerCase().contains(q))
        .toList();
  }

  /// Apply sorting
  List<ProductEntity> _applySorting(
    List<ProductEntity> products,
    String? sortBy,
  ) {
    if (sortBy == null) return products;

    final sorted = List<ProductEntity>.from(products);
    sorted.sort((a, b) {
      switch (sortBy) {
        case 'name':
          return a.name.compareTo(b.name);
        case 'price_asc':
          final aPrice = a.volumePrices.values.first;
          final bPrice = b.volumePrices.values.first;
          return aPrice.compareTo(bPrice);
        case 'price_desc':
          final aPrice = a.volumePrices.values.first;
          final bPrice = b.volumePrices.values.first;
          return bPrice.compareTo(aPrice);
        case 'rating':
          return b.rating.compareTo(a.rating);
        default:
          return 0;
      }
    });

    return sorted;
  }
}

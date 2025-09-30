import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../src/domain/entities/product.dart' as domain;
import '../../../../src/domain/use_cases/product/get_products_use_case.dart';
import '../../../../src/core/constants/app_constants.dart';
import '../../../../src/data/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.getProductsUseCase}) : super(const ProductState()) {
    on<ProductLoadRequested>(_onLoadRequested);
    on<ProductLoadMoreRequested>(_onLoadMoreRequested);
    on<ProductRefreshRequested>(_onRefreshRequested);
    on<ProductSearchRequested>(_onSearchRequested);
    on<ProductFilterChanged>(_onFilterChanged);
  }

  final GetProductsUseCase getProductsUseCase;

  Future<void> _onLoadRequested(
    ProductLoadRequested event,
    Emitter<ProductState> emit,
  ) async {
    final page = event.page ?? 1;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(milliseconds: 500));
    final allProducts = AppConstants.sampleProducts.map((json) {
      final model = ProductModel.fromJson(json);
      return model.toEntity();
    }).toList();

    final filtered = _applyFilters(allProducts,
        category: event.category,
        brand: event.brand,
        search: event.search,
        sortBy: event.sortBy);

    final startIndex = (page - 1) * event.limit;
    final endIndex = startIndex + event.limit;
    final pageItems = filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );

    emit(state.copyWith(
      products: page == 1 ? pageItems : [...state.products, ...pageItems],
      isLoading: false,
      hasMore: filtered.length > endIndex,
      currentPage: page,
    ));
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
    emit(state.copyWith(category: event.category, brand: event.brand, sortBy: event.sortBy));
    add(ProductLoadRequested(page: 1, limit: event.limit));
  }

  List<domain.Product> _applyFilters(
    List<domain.Product> products, {
    String? category,
    String? brand,
    String? search,
    String? sortBy,
  }) {
    List<domain.Product> result = products;
    if (category != null) {
      result = result.where((p) => p.category == category).toList();
    }
    if (brand != null) {
      result = result.where((p) => p.brand == brand).toList();
    }
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      result = result
          .where((p) => p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q))
          .toList();
    }
    if (sortBy != null) {
      result.sort((a, b) {
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
    return result;
  }
}


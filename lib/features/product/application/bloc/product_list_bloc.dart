import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_query.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required GetProductsQuery getProducts})
      : _getProducts = getProducts,
        super(const ProductListState()) {
    on<ProductListLoadRequested>(_onLoadRequested);
    on<ProductListLoadMoreRequested>(_onLoadMoreRequested);
    on<ProductListRefreshRequested>(_onRefreshRequested);
    on<ProductListSearchRequested>(_onSearchRequested);
    on<ProductListFilterChanged>(_onFilterChanged);
  }

  final GetProductsQuery _getProducts;

  Future<void> _onLoadRequested(
    ProductListLoadRequested event,
    Emitter<ProductListState> emit,
  ) async {
    final page = event.page ?? 1;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final items = await _getProducts(
        page: page,
        limit: event.limit,
        category: event.category,
        brand: event.brand,
        search: event.search,
        sortBy: event.sortBy,
      );
      emit(state.copyWith(
        products: page == 1 ? items : [...state.products, ...items],
        isLoading: false,
        currentPage: page,
        hasMore: items.length == event.limit,
      ));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load products'));
    }
  }

  Future<void> _onLoadMoreRequested(
    ProductListLoadMoreRequested event,
    Emitter<ProductListState> emit,
  ) async {
    if (!state.hasMore || state.isLoading) return;
    add(ProductListLoadRequested(
      page: state.currentPage + 1,
      limit: event.limit,
      category: state.category,
      brand: state.brand,
      search: state.search,
      sortBy: state.sortBy,
    ));
  }

  Future<void> _onRefreshRequested(
    ProductListRefreshRequested event,
    Emitter<ProductListState> emit,
  ) async {
    add(ProductListLoadRequested(
      page: 1,
      limit: event.limit,
      category: state.category,
      brand: state.brand,
      search: state.search,
      sortBy: state.sortBy,
    ));
  }

  Future<void> _onSearchRequested(
    ProductListSearchRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(search: event.query));
    add(ProductListLoadRequested(
        page: 1, limit: event.limit, search: event.query));
  }

  Future<void> _onFilterChanged(
    ProductListFilterChanged event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(
        category: event.category, brand: event.brand, sortBy: event.sortBy));
    add(ProductListLoadRequested(
      page: 1,
      limit: event.limit,
      category: event.category,
      brand: event.brand,
      sortBy: event.sortBy,
    ));
  }
}

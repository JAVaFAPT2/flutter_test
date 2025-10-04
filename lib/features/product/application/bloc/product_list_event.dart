part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
  @override
  List<Object?> get props => [];
}

class ProductListLoadRequested extends ProductListEvent {
  const ProductListLoadRequested(
      {this.page,
      this.limit = 20,
      this.category,
      this.brand,
      this.search,
      this.sortBy});
  final int? page;
  final int limit;
  final String? category;
  final String? brand;
  final String? search;
  final String? sortBy;
}

class ProductListLoadMoreRequested extends ProductListEvent {
  const ProductListLoadMoreRequested({this.limit = 20});
  final int limit;
}

class ProductListRefreshRequested extends ProductListEvent {
  const ProductListRefreshRequested({this.limit = 20});
  final int limit;
}

class ProductListSearchRequested extends ProductListEvent {
  const ProductListSearchRequested(this.query, {this.limit = 20});
  final String query;
  final int limit;
}

class ProductListFilterChanged extends ProductListEvent {
  const ProductListFilterChanged(
      {this.category, this.brand, this.sortBy, this.limit = 20});
  final String? category;
  final String? brand;
  final String? sortBy;
  final int limit;
}


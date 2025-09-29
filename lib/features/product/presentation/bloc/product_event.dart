part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class ProductLoadRequested extends ProductEvent {
  const ProductLoadRequested({
    this.page,
    this.limit = 20,
    this.category,
    this.brand,
    this.search,
    this.sortBy,
  });
  final int? page;
  final int limit;
  final String? category;
  final String? brand;
  final String? search;
  final String? sortBy;
}

class ProductLoadMoreRequested extends ProductEvent {
  const ProductLoadMoreRequested({this.limit = 20});
  final int limit;
}

class ProductRefreshRequested extends ProductEvent {
  const ProductRefreshRequested({this.limit = 20});
  final int limit;
}

class ProductSearchRequested extends ProductEvent {
  const ProductSearchRequested(this.query, {this.limit = 20});
  final String query;
  final int limit;
}

class ProductFilterChanged extends ProductEvent {
  const ProductFilterChanged({this.category, this.brand, this.sortBy, this.limit = 20});
  final String? category;
  final String? brand;
  final String? sortBy;
  final int limit;
}


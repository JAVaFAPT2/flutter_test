part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  const ProductListState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.category,
    this.brand,
    this.search,
    this.sortBy,
  });

  final List<ProductEntity> products;
  final bool isLoading;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final String? category;
  final String? brand;
  final String? search;
  final String? sortBy;

  ProductListState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        errorMessage,
        currentPage,
        hasMore,
        category,
        brand,
        search,
        sortBy,
      ];
}


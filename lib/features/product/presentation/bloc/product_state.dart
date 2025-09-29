part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasMore = true,
    this.currentPage = 1,
    this.category,
    this.brand,
    this.search,
    this.sortBy,
  });

  final List<domain.Product> products;
  final bool isLoading;
  final String? errorMessage;
  final bool hasMore;
  final int currentPage;
  final String? category;
  final String? brand;
  final String? search;
  final String? sortBy;

  ProductState copyWith({
    List<domain.Product>? products,
    bool? isLoading,
    String? errorMessage,
    bool? hasMore,
    int? currentPage,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
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
        hasMore,
        currentPage,
        category,
        brand,
        search,
        sortBy,
      ];
}


import '../../entities/product.dart';
import '../../repositories/product_repository.dart';
import '../../value_objects/result.dart';

/// Use case for getting products
class GetProductsUseCase {
  const GetProductsUseCase(this._productRepository);

  final ProductRepository _productRepository;

  /// Execute get products with optional filters
  Future<Result<List<Product>>> execute({
    int page = 1,
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    // Basic validation
    if (page < 1) {
      return const Failure('Page must be greater than 0');
    }

    if (limit < 1 || limit > 100) {
      return const Failure('Limit must be between 1 and 100');
    }

    return _productRepository.getProducts(
      page: page,
      limit: limit,
      category: category,
      brand: brand,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }
}

import '../entities/product_entity.dart';

/// Repository interface for product data operations
abstract class ProductRepository {
  /// Get a single product by ID
  Future<ProductEntity?> getById(String id);

  /// Watch a single product by ID (stream)
  Stream<ProductEntity?> watchById(String id);

  /// Get list of products with optional filters
  Future<List<ProductEntity>> list({
    String? category,
    String? brand,
    int? limit,
    int? offset,
  });

  /// Watch list of products with optional filters (stream)
  Stream<List<ProductEntity>> watchList({
    String? category,
    String? brand,
    int? limit,
  });

  /// Get related products for a given product ID
  Future<List<ProductEntity>> related(String productId);

  /// Track product view for analytics
  Future<void> trackView(String productId, String? userId);

  /// Search products by query
  Future<List<ProductEntity>> search(String query);

  /// Get featured products
  Future<List<ProductEntity>> getFeatured();

  /// Get products on sale
  Future<List<ProductEntity>> getOnSale();
}

import '../entities/product.dart';
import '../value_objects/result.dart';

/// Abstract interface for product operations
abstract class ProductRepository {
  /// Get all products with pagination
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  });

  /// Get product by ID
  Future<Result<Product>> getProductById(String id);

  /// Get products by category
  Future<Result<List<Product>>> getProductsByCategory(String category);

  /// Get products by brand
  Future<Result<List<Product>>> getProductsByBrand(String brand);

  /// Search products
  Future<Result<List<Product>>> searchProducts(String query);

  /// Get featured products
  Future<Result<List<Product>>> getFeaturedProducts();

  /// Get product categories
  Future<Result<List<String>>> getCategories();

  /// Get product brands
  Future<Result<List<String>>> getBrands();

  /// Get favorite products
  Future<Result<List<Product>>> getFavoriteProducts();

  /// Add product to favorites
  Future<Result<void>> addToFavorites(String productId);

  /// Remove product from favorites
  Future<Result<void>> removeFromFavorites(String productId);

  /// Check if product is favorite
  Future<Result<bool>> isFavorite(String productId);
}

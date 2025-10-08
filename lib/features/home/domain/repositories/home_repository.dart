import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import '../entities/banner.dart';
import '../entities/category.dart';

/// Repository interface for home data operations
abstract class HomeRepository {
  /// Get banners for home carousel
  Future<List<Banner>> getBanners();

  /// Get categories for home page
  Future<List<Category>> getCategories();

  /// Get featured products for home page
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10});

  /// Get products on sale for home page
  Future<List<ProductEntity>> getSaleProducts({int limit = 10});
}


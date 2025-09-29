import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/value_objects/result.dart';
import '../datasources/local/local_storage.dart';
import '../datasources/remote/api_client.dart';
import '../models/product_model.dart';

/// Implementation of ProductRepository using API and local storage
class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required this.apiClient,
    required this.localStorage,
  });

  final ApiClient apiClient;
  final LocalStorage localStorage;

  @override
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      // Mock API call - in real app this would call the actual API
      final response = await apiClient.get(
        '/products',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (category != null) 'category': category,
          if (brand != null) 'brand': brand,
          if (search != null) 'search': search,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortOrder != null) 'sortOrder': sortOrder,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'] as List<dynamic>;
        final products =
            data.map((json) => ProductModel.fromJson(json).toEntity()).toList();

        return Success(products);
      } else {
        return Failure('Failed to load products: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<Product>> getProductById(String id) async {
    try {
      final response = await apiClient.get('/products/$id');

      if (response.statusCode == 200) {
        final productModel = ProductModel.fromJson(response.data);
        return Success(productModel.toEntity());
      } else {
        return Failure('Product not found: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory(String category) async {
    return getProducts(category: category);
  }

  @override
  Future<Result<List<Product>>> getProductsByBrand(String brand) async {
    return getProducts(brand: brand);
  }

  @override
  Future<Result<List<Product>>> searchProducts(String query) async {
    return getProducts(search: query);
  }

  @override
  Future<Result<List<Product>>> getFeaturedProducts() async {
    return getProducts(
      page: 1,
      limit: 10,
      sortBy: 'featured',
    );
  }

  @override
  Future<Result<List<String>>> getCategories() async {
    try {
      final response = await apiClient.get('/products/categories');

      if (response.statusCode == 200) {
        final List<String> categories =
            List<String>.from(response.data['categories']);
        return Success(categories);
      } else {
        return Failure(
            'Failed to load categories: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<List<String>>> getBrands() async {
    try {
      final response = await apiClient.get('/products/brands');

      if (response.statusCode == 200) {
        final List<String> brands = List<String>.from(response.data['brands']);
        return Success(brands);
      } else {
        return Failure('Failed to load brands: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    try {
      final favoritesData = await localStorage.getFavorites();
      if (favoritesData != null && favoritesData.isNotEmpty) {
        final List<String> favoriteIds =
            List<String>.from(favoritesData.split(','));
        final products = <Product>[];

        for (final id in favoriteIds) {
          final result = await getProductById(id);
          if (result is Success<Product>) {
            products.add(result.data);
          }
        }

        return Success(products);
      } else {
        return const Success([]);
      }
    } catch (e) {
      return Failure('Failed to load favorites: $e');
    }
  }

  @override
  Future<Result<void>> addToFavorites(String productId) async {
    try {
      final favoritesData = await localStorage.getFavorites();
      final favoriteIds = favoritesData?.isNotEmpty == true
          ? favoritesData!.split(',').toList()
          : <String>[];

      if (!favoriteIds.contains(productId)) {
        favoriteIds.add(productId);
        await localStorage.setFavorites(favoriteIds.join(','));
      }

      return const Success(null);
    } catch (e) {
      return Failure('Failed to add to favorites: $e');
    }
  }

  @override
  Future<Result<void>> removeFromFavorites(String productId) async {
    try {
      final favoritesData = await localStorage.getFavorites();
      if (favoritesData?.isNotEmpty == true) {
        final favoriteIds = favoritesData!.split(',').toList();
        favoriteIds.remove(productId);
        await localStorage.setFavorites(favoriteIds.join(','));
      }

      return const Success(null);
    } catch (e) {
      return Failure('Failed to remove from favorites: $e');
    }
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    try {
      final favoritesData = await localStorage.getFavorites();
      if (favoritesData?.isNotEmpty == true) {
        final favoriteIds = favoritesData!.split(',');
        return Success(favoriteIds.contains(productId));
      } else {
        return const Success(false);
      }
    } catch (e) {
      return Failure('Failed to check favorite status: $e');
    }
  }
}

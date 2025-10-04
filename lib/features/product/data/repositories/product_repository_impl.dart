import 'dart:async';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/repositories/product_repository.dart';
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';

/// Fake implementation of ProductRepository using FakeFirestore
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._fakeFirestore);

  final FakeFirestore _fakeFirestore;

  @override
  Future<ProductEntity?> getById(String id) async {
    final productData = await _fakeFirestore.getProductById(id);
    if (productData == null) return null;
    return _mapToEntity(productData);
  }

  @override
  Stream<ProductEntity?> watchById(String id) {
    return _fakeFirestore.watchProducts().map((products) {
      final productData = products.firstWhere(
        (p) => p['id'] == id,
        orElse: () => <String, dynamic>{},
      );
      if (productData.isEmpty) return null;
      return _mapToEntity(productData);
    });
  }

  @override
  Future<List<ProductEntity>> list({
    String? category,
    String? brand,
    int? limit,
    int? offset,
  }) async {
    final productsData =
        await _fakeFirestore.getProducts(category: category, brand: brand);

    // Apply offset and limit
    var result = productsData;
    if (offset != null && offset > 0) {
      result = result.skip(offset).toList();
    }
    if (limit != null && limit > 0) {
      result = result.take(limit).toList();
    }

    return result.map(_mapToEntity).toList();
  }

  @override
  Stream<List<ProductEntity>> watchList({
    String? category,
    String? brand,
    int? limit,
  }) {
    return _fakeFirestore
        .watchProducts(category: category, brand: brand)
        .map((productsData) {
      var result = productsData;
      if (limit != null && limit > 0) {
        result = result.take(limit).toList();
      }
      return result.map(_mapToEntity).toList();
    });
  }

  @override
  Future<List<ProductEntity>> related(String productId) async {
    // Get the current product to find related products by category
    final currentProduct = await getById(productId);
    if (currentProduct == null) return [];

    // Get products from the same category, excluding current product
    final allProducts = await list(category: currentProduct.category);
    return allProducts
        .where((p) => p.id != productId)
        .take(4) // Limit to 4 related products
        .toList();
  }

  @override
  Future<void> trackView(String productId, String? userId) async {
    // NOTE: Analytics tracking will be implemented when Firebase is integrated
    // For now, just a placeholder
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<List<ProductEntity>> search(String query) async {
    final allProducts = await list();
    final lowercaseQuery = query.toLowerCase();

    return allProducts.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
          product.description.toLowerCase().contains(lowercaseQuery) ||
          product.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<List<ProductEntity>> getFeatured() async {
    final allProducts = await list();
    return allProducts.where((product) => product.isFeatured).toList();
  }

  @override
  Future<List<ProductEntity>> getOnSale() async {
    final allProducts = await list();
    return allProducts.where((product) => product.isOnSale).toList();
  }

  /// Map raw data from FakeFirestore to ProductEntity
  ProductEntity _mapToEntity(Map<String, dynamic> data) {
    return ProductEntity(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      subtitle: data['subtitle']?.toString() ?? '',
      price: data['price']?.toString() ?? '',
      imageUrl: data['imageUrl']?.toString() ?? '',
      images: (data['images'] as List<dynamic>?)?.cast<String>() ?? [],
      volumes:
          (data['volumes'] as List<dynamic>?)?.cast<String>() ?? ['500 ML'],
      volumePrices: _parseVolumePrices(data['volumePrices']),
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
      description: data['description']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      origin: data['origin']?.toString() ?? '',
      ingredients:
          (data['ingredients'] as List<dynamic>?)?.cast<String>() ?? [],
      nutritionInfo: _parseNutritionInfo(data['nutritionInfo']),
      inStock: data['inStock'] as bool? ?? true,
      stockQuantity: (data['stockQuantity'] as num?)?.toInt() ?? 0,
      isFeatured: data['isFeatured'] as bool? ?? false,
      isOnSale: data['isOnSale'] as bool? ?? false,
      originalPrice: data['originalPrice']?.toString() ?? '',
      discountPercentage: (data['discountPercentage'] as num?)?.toInt() ?? 0,
      brand: data['brand']?.toString() ?? '',
    );
  }

  /// Parse volume prices from data
  Map<String, int> _parseVolumePrices(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data.map((key, value) => MapEntry(key, (value as num).toInt()));
    }
    return {'500 ML': 225000}; // Default price
  }

  /// Parse nutrition info from data
  Map<String, String> _parseNutritionInfo(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data.map((key, value) => MapEntry(key, value.toString()));
    }
    return {};
  }
}

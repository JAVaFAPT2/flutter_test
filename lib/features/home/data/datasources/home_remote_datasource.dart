import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';

/// Remote data source for home data
abstract class HomeRemoteDataSource {
  Future<List<BannerModel>> getBanners();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10});
  Future<List<ProductEntity>> getSaleProducts({int limit = 10});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._fakeFirestore);

  final FakeFirestore _fakeFirestore;

  @override
  Future<List<BannerModel>> getBanners() async {
    // Mock banners data
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      const BannerModel(
        id: 'banner_1',
        imageUrl: 'assets/figma_exports/banner_product.png',
        title: 'Premium Fish Sauce',
        subtitle: 'Special Offer',
        order: 0,
      ),
      const BannerModel(
        id: 'banner_2',
        imageUrl: 'assets/figma_exports/home_header_bg.png',
        title: 'Traditional Taste',
        subtitle: 'Authentic Vietnamese',
        order: 1,
      ),
    ];
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    // Mock categories data
    await Future.delayed(const Duration(milliseconds: 200));

    return [
      const CategoryModel(
        id: 'cat_premium',
        name: 'Cao cấp',
        iconPath: 'assets/figma_exports/small_icon_1.png',
        badgeCount: 12,
        order: 0,
      ),
      const CategoryModel(
        id: 'cat_traditional',
        name: 'Truyền thống',
        iconPath: 'assets/figma_exports/small_icon_2.png',
        badgeCount: 8,
        order: 1,
      ),
      const CategoryModel(
        id: 'cat_organic',
        name: 'Hữu cơ',
        iconPath: 'assets/figma_exports/small_icon_3.png',
        badgeCount: 5,
        order: 2,
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10}) async {
    final productMaps = await _fakeFirestore.getProducts();
    final featuredMaps =
        productMaps.where((p) => p['isFeatured'] == true).toList();
    return featuredMaps
        .take(limit)
        .map((map) => _mapToProductEntity(map))
        .toList();
  }

  @override
  Future<List<ProductEntity>> getSaleProducts({int limit = 10}) async {
    final productMaps = await _fakeFirestore.getProducts();
    final onSaleMaps = productMaps.where((p) => p['isOnSale'] == true).toList();
    return onSaleMaps
        .take(limit)
        .map((map) => _mapToProductEntity(map))
        .toList();
  }

  /// Convert Map to ProductEntity
  ProductEntity _mapToProductEntity(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      price: map['price']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      volumes: (map['volumes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      volumePrices: (map['volumePrices'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key,
                value is int ? value : int.tryParse(value.toString()) ?? 0),
          ) ??
          {},
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount'] is int
          ? map['reviewCount']
          : int.tryParse(map['reviewCount']?.toString() ?? '0') ?? 0,
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      origin: map['origin']?.toString() ?? '',
      ingredients: (map['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      nutritionInfo: (map['nutritionInfo'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value.toString()),
          ) ??
          {},
      inStock: map['inStock'] == true,
      stockQuantity: map['stockQuantity'] is int
          ? map['stockQuantity']
          : int.tryParse(map['stockQuantity']?.toString() ?? '0') ?? 0,
      isFeatured: map['isFeatured'] == true,
      isOnSale: map['isOnSale'] == true,
      originalPrice: map['originalPrice']?.toString() ?? '',
      discountPercentage: map['discountPercentage'] is int
          ? map['discountPercentage']
          : int.tryParse(map['discountPercentage']?.toString() ?? '0') ?? 0,
      brand: map['brand']?.toString() ?? '',
    );
  }
}

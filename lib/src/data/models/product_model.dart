import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required double originalPrice,
    required String imageUrl,
    required String category,
    required String brand,
    required String volume,
    required List<String> ingredients,
    required String origin,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(true) bool isAvailable,
    @Default(false) bool isFeatured,
    @Default(false) bool isOnSale,
    @Default(0) int discountPercentage,
    @Default(0) int stockQuantity,
    Map<String, String>? nutritionInfo,
    List<String>? certifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        originalPrice: product.originalPrice,
        imageUrl: product.imageUrl,
        category: product.category,
        brand: product.brand,
        volume: product.volume,
        ingredients: product.ingredients,
        origin: product.origin,
        rating: product.rating,
        reviewCount: product.reviewCount,
        isAvailable: product.isAvailable,
        isFeatured: product.isFeatured,
        isOnSale: product.isOnSale,
        discountPercentage: product.discountPercentage,
        stockQuantity: product.stockQuantity,
        nutritionInfo: product.nutritionInfo,
        certifications: product.certifications,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );
}

extension ProductModelX on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      originalPrice: originalPrice,
      imageUrl: imageUrl,
      category: category,
      brand: brand,
      volume: volume,
      ingredients: ingredients,
      origin: origin,
      rating: rating,
      reviewCount: reviewCount,
      isAvailable: isAvailable,
      isFeatured: isFeatured,
      isOnSale: isOnSale,
      discountPercentage: discountPercentage,
      stockQuantity: stockQuantity,
      nutritionInfo: nutritionInfo,
      certifications: certifications,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

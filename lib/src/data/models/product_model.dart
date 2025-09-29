import '../../domain/entities/product.dart';

/// Data model for Product entity
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.volume,
    required this.ingredients,
    required this.origin,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    this.isFeatured = false,
    this.isOnSale = false,
    this.discountPercentage = 0,
    this.stockQuantity = 0,
    this.nutritionInfo,
    this.certifications,
    this.createdAt,
    this.updatedAt,
  });

  /// Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ??
          (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      volume: json['volume'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      origin: json['origin'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isOnSale: json['isOnSale'] as bool? ?? false,
      discountPercentage: json['discountPercentage'] as int? ?? 0,
      stockQuantity: json['stockQuantity'] as int? ?? 0,
      nutritionInfo: json['nutritionInfo'] != null
          ? Map<String, String>.from(json['nutritionInfo'] as Map)
          : null,
      certifications: json['certifications'] != null
          ? List<String>.from(json['certifications'] as List)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Create from domain entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
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

  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final String category;
  final String brand;
  final String volume;
  final List<String> ingredients;
  final String origin;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final bool isFeatured;
  final bool isOnSale;
  final int discountPercentage;
  final int stockQuantity;
  final Map<String, String>? nutritionInfo;
  final List<String>? certifications;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'category': category,
      'brand': brand,
      'volume': volume,
      'ingredients': ingredients,
      'origin': origin,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'isOnSale': isOnSale,
      'discountPercentage': discountPercentage,
      'stockQuantity': stockQuantity,
      'nutritionInfo': nutritionInfo,
      'certifications': certifications,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Convert to domain entity
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

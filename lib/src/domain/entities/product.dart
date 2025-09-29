import 'package:equatable/equatable.dart';

/// Product entity representing a fish sauce product
class Product extends Equatable {
  const Product({
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

  /// Get the display price (with discount if applicable)
  double get displayPrice =>
      isOnSale ? price * (1 - discountPercentage / 100) : price;

  /// Check if product is in stock
  bool get inStock => isAvailable && stockQuantity > 0;

  /// Get formatted price string
  String get formattedPrice => '${displayPrice.toStringAsFixed(0)}₫';

  /// Get formatted original price string
  String get formattedOriginalPrice => '${originalPrice.toStringAsFixed(0)}₫';

  /// Get formatted discount string
  String get formattedDiscount => '-$discountPercentage%';

  /// Create a copy of this product with updated fields
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    String? category,
    String? brand,
    String? volume,
    List<String>? ingredients,
    String? origin,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
    bool? isFeatured,
    bool? isOnSale,
    int? discountPercentage,
    int? stockQuantity,
    Map<String, String>? nutritionInfo,
    List<String>? certifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      volume: volume ?? this.volume,
      ingredients: ingredients ?? this.ingredients,
      origin: origin ?? this.origin,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      isOnSale: isOnSale ?? this.isOnSale,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      certifications: certifications ?? this.certifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        originalPrice,
        imageUrl,
        category,
        brand,
        volume,
        ingredients,
        origin,
        rating,
        reviewCount,
        isAvailable,
        isFeatured,
        isOnSale,
        discountPercentage,
        stockQuantity,
        nutritionInfo,
        certifications,
        createdAt,
        updatedAt,
      ];
}

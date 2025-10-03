/// Product entity representing a product in the system
class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.images = const [],
    this.volumes = const [],
    this.volumePrices = const {},
    this.rating = 0.0,
    this.reviewCount = 0,
    this.description = '',
    this.category = '',
    this.origin = '',
    this.ingredients = const [],
    this.nutritionInfo = const {},
    this.inStock = true,
    this.stockQuantity = 0,
    this.isFeatured = false,
    this.isOnSale = false,
    this.originalPrice = '',
    this.discountPercentage = 0,
    this.brand = '',
  });

  final String id;
  final String name;
  final String subtitle;
  final String price;
  final String imageUrl;
  final List<String> images;
  final List<String> volumes;
  final Map<String, int> volumePrices; // volume -> price in VND
  final double rating;
  final int reviewCount;
  final String description;
  final String category;
  final String origin;
  final List<String> ingredients;
  final Map<String, String> nutritionInfo;
  final bool inStock;
  final int stockQuantity;
  final bool isFeatured;
  final bool isOnSale;
  final String originalPrice;
  final int discountPercentage;
  final String brand;

  /// Get price for specific volume
  int getPriceForVolume(String volume) {
    return volumePrices[volume] ?? volumePrices.values.firstOrNull ?? 0;
  }

  /// Get formatted price for specific volume
  String getFormattedPriceForVolume(String volume) {
    final price = getPriceForVolume(volume);
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ';
  }

  /// Get total price for quantity and volume
  int getTotalPrice(String volume, int quantity) {
    return getPriceForVolume(volume) * quantity;
  }

  /// Get formatted total price for quantity and volume
  String getFormattedTotalPrice(String volume, int quantity) {
    final total = getTotalPrice(volume, quantity);
    return total.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  ProductEntity copyWith({
    String? id,
    String? name,
    String? subtitle,
    String? price,
    String? imageUrl,
    List<String>? images,
    List<String>? volumes,
    Map<String, int>? volumePrices,
    double? rating,
    int? reviewCount,
    String? description,
    String? category,
    String? origin,
    List<String>? ingredients,
    Map<String, String>? nutritionInfo,
    bool? inStock,
    int? stockQuantity,
    bool? isFeatured,
    bool? isOnSale,
    String? originalPrice,
    int? discountPercentage,
    String? brand,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      volumes: volumes ?? this.volumes,
      volumePrices: volumePrices ?? this.volumePrices,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      category: category ?? this.category,
      origin: origin ?? this.origin,
      ingredients: ingredients ?? this.ingredients,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      inStock: inStock ?? this.inStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isFeatured: isFeatured ?? this.isFeatured,
      isOnSale: isOnSale ?? this.isOnSale,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      brand: brand ?? this.brand,
    );
  }
}

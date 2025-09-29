/// Application constants following Vietnamese fish sauce e-commerce domain
abstract class AppConstants {
  // App Information
  static const String appName = 'Nước Mắm MGF';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Ứng dụng thương mại điện tử nước mắm Việt Nam';

  // API Configuration
  static const String baseUrl = 'https://api.mgf-vietnam.com';
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String cartKey = 'shopping_cart';
  static const String favoritesKey = 'favorite_products';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Duration
  static const Duration cacheShortDuration = Duration(minutes: 5);
  static const Duration cacheMediumDuration = Duration(hours: 1);
  static const Duration cacheLongDuration = Duration(days: 1);

  // Image Quality
  static const int imageQuality = 85;
  static const int thumbnailSize = 150;
  static const int previewSize = 400;
  static const int fullSize = 800;

  // Vietnamese Fish Sauce Products
  static const List<String> productCategories = [
    'Nước Mắm Cốt',
    'Nước Mắm Pha Sẵn',
    'Nước Mắm Cao Đạm',
    'Nước Mắm Đặc Biệt',
  ];

  static const List<String> productBrands = [
    'MGF Premium',
    'Vĩnh Thái',
    'Xuân Thịnh Mậu',
    'Traditional',
  ];

  // Sample Product Data for Development
  static const List<Map<String, dynamic>> sampleProducts = [
    {
      'id': '1',
      'name': 'Nước Mắm MGF Premium 500ml',
      'description':
          'Nước mắm cao cấp được sản xuất từ cá cơm tươi nguyên chất, ủ chượp theo phương pháp truyền thống Việt Nam.',
      'price': 85000.0,
      'originalPrice': 95000.0,
      'imageUrl':
          'https://via.placeholder.com/300x300/1976D2/FFFFFF?text=MGF+500ml',
      'category': 'Nước Mắm Cao Đạm',
      'brand': 'MGF Premium',
      'volume': '500ml',
      'ingredients': ['Cá cơm', 'Muối', 'Đường'],
      'origin': 'Phú Quốc, Việt Nam',
      'rating': 4.8,
      'reviewCount': 125,
      'isAvailable': true,
      'isFeatured': true,
      'isOnSale': true,
      'discountPercentage': 11,
      'stockQuantity': 50,
    },
    {
      'id': '2',
      'name': 'Nước Mắm Vĩnh Thái 330ml',
      'description':
          'Nước mắm truyền thống từ làng nghề Vĩnh Thái, được sản xuất theo công thức gia truyền.',
      'price': 45000.0,
      'originalPrice': 45000.0,
      'imageUrl':
          'https://via.placeholder.com/300x300/4CAF50/FFFFFF?text=Vinh+Thai+330ml',
      'category': 'Nước Mắm Cốt',
      'brand': 'Vĩnh Thái',
      'volume': '330ml',
      'ingredients': ['Cá cơm', 'Muối biển'],
      'origin': 'Vĩnh Thái, Việt Nam',
      'rating': 4.5,
      'reviewCount': 89,
      'isAvailable': true,
      'isFeatured': false,
      'isOnSale': false,
      'discountPercentage': 0,
      'stockQuantity': 100,
    },
    {
      'id': '3',
      'name': 'Nước Mắm Xuân Thịnh Mậu 250ml',
      'description':
          'Nước mắm đặc biệt từ vùng biển miền Trung, hương vị đậm đà và tự nhiên.',
      'price': 65000.0,
      'originalPrice': 65000.0,
      'imageUrl':
          'https://via.placeholder.com/300x300/FF9800/FFFFFF?text=Xuan+Thinh+Mau+250ml',
      'category': 'Nước Mắm Đặc Biệt',
      'brand': 'Xuân Thịnh Mậu',
      'volume': '250ml',
      'ingredients': ['Cá cơm than', 'Muối', 'Đường thốt nốt'],
      'origin': 'Miền Trung, Việt Nam',
      'rating': 4.7,
      'reviewCount': 67,
      'isAvailable': true,
      'isFeatured': true,
      'isOnSale': false,
      'discountPercentage': 0,
      'stockQuantity': 75,
    },
    {
      'id': '4',
      'name': 'Nước Mắm Traditional 1L',
      'description':
          'Nước mắm truyền thống Việt Nam, phù hợp cho gia đình và nhà hàng.',
      'price': 120000.0,
      'originalPrice': 120000.0,
      'imageUrl':
          'https://via.placeholder.com/300x300/9C27B0/FFFFFF?text=Traditional+1L',
      'category': 'Nước Mắm Pha Sẵn',
      'brand': 'Traditional',
      'volume': '1L',
      'ingredients': ['Cá cơm', 'Muối', 'Nước'],
      'origin': 'Việt Nam',
      'rating': 4.3,
      'reviewCount': 156,
      'isAvailable': true,
      'isFeatured': false,
      'isOnSale': false,
      'discountPercentage': 0,
      'stockQuantity': 30,
    },
  ];

  // Vietnamese Currency
  static const String currencySymbol = '₫';
  static const String currencyCode = 'VND';

  // Vietnamese Locale
  static const String vietnameseLocale = 'vi_VN';

  // Authentication
  static const int otpLength = 6;
  static const int otpTimeoutSeconds = 300; // 5 minutes

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 11;

  // Performance
  static const int animationDuration = 300; // milliseconds
  static const int debounceDuration = 500; // milliseconds
}

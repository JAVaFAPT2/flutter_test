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

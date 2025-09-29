class AppConstants {
  // App Information
  static const String appName = 'Nước Mắm MGF';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://api.mgf-fishsauce.com';
  static const String apiVersion = 'v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'language';
  static const String themeKey = 'theme_mode';

  // Product Brands
  static const String vinhThaiBrand = 'Vĩnh Thái';
  static const String xuanThinhMauBrand = 'Xuân Thịnh Mậu';

  // Product Sizes
  static const String size250ml = '250ml';
  static const String size330ml = '330ml';
  static const String size500ml = '500ml';

  // Vietnamese Currency
  static const String vietnameseCurrency = 'VND';
  static const String currencySymbol = '₫';

  // Phone Number Configuration
  static const String vietnamCountryCode = '+84';
  static const String phoneNumberRegex = r'^[0-9]{9,10}$';

  // OTP Configuration
  static const int otpLength = 6;
  static const int otpTimeoutSeconds = 300; // 5 minutes

  // Cart Configuration
  static const int maxCartItems = 50;
  static const int minQuantity = 1;
  static const int maxQuantity = 99;

  // Image Configuration
  static const double maxImageSizeMB = 5.0;
  static const List<String> allowedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'webp'
  ];

  // Network Configuration
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Vietnamese Locale
  static const String vietnameseLocaleCode = 'vi';
  static const String vietnameseCountryCode = 'VN';

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Debounce Duration
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100 MB
}

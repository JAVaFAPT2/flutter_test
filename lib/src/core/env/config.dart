// Simple environment configuration for networking and timeouts
class AppConfig {
  AppConfig._();

  // Base URL for API requests
  static const String baseUrl = 'https://api.mgf-vietnam.com';

  // Request timeouts
  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);
}


import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this.logger);

  final Logger logger;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add authentication token if available
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add Vietnamese locale header
    options.headers['Accept-Language'] = AppConstants.vietnameseLocaleCode;

    // Add app version header
    options.headers['App-Version'] = AppConstants.appVersion;

    // Log request
    logger.i('''
🌐 REQUEST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📍 URL: ${options.method} ${options.baseUrl}${options.path}
🔑 Headers: ${options.headers}
📝 Query Parameters: ${options.queryParameters}
📦 Request Data: ${options.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ''');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response
    logger.i('''
✅ RESPONSE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📍 URL: ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}
📊 Status Code: ${response.statusCode} ${response.statusMessage}
🔑 Headers: ${response.headers}
📦 Response Data: ${response.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token refresh for 401 errors
    if (err.response?.statusCode == 401) {
      final refreshed = await _tryRefreshToken(err.requestOptions);
      if (refreshed) {
        // Retry the original request with new token
        final dio = Dio();
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }

    // Log error
    logger.e('''
❌ ERROR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📍 URL: ${err.requestOptions.method} ${err.requestOptions.baseUrl}${err.requestOptions.path}
📊 Status Code: ${err.response?.statusCode} ${err.response?.statusMessage}
🔥 Error Type: ${err.type}
💭 Error Message: ${err.message}
📦 Response Data: ${err.response?.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ''');

    super.onError(err, handler);
  }

  Future<bool> _tryRefreshToken(RequestOptions options) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(AppConstants.refreshTokenKey);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      // Create a new Dio instance for token refresh to avoid infinite loop
      final dio = Dio(BaseOptions(
        baseUrl: options.baseUrl,
        connectTimeout:
            const Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout:
            const Duration(milliseconds: AppConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: AppConstants.sendTimeout),
      ));

      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final newToken = responseData['accessToken'] as String?;
        final newRefreshToken = responseData['refreshToken'] as String?;

        if (newToken != null) {
          // Save new tokens
          await prefs.setString(AppConstants.tokenKey, newToken);
          if (newRefreshToken != null) {
            await prefs.setString(
                AppConstants.refreshTokenKey, newRefreshToken);
          }

          // Update the original request with new token
          options.headers['Authorization'] = 'Bearer $newToken';

          logger.i('🔄 Token refreshed successfully');
          return true;
        }
      }
    } catch (e) {
      logger.e('❌ Token refresh failed: $e');

      // Clear tokens and redirect to login
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.refreshTokenKey);
      await prefs.remove(AppConstants.userKey);
    }

    return false;
  }
}

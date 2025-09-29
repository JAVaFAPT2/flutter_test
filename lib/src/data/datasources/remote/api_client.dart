import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Abstract interface for API client operations
abstract class ApiClient {
  /// Perform GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Perform POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Perform PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Perform PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Perform DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Set authorization token
  void setToken(String token);

  /// Remove authorization token
  void removeToken();

  /// Check if client has token
  bool hasToken();
}

/// Implementation of API client using Dio
class ApiClientImpl implements ApiClient {
  ApiClientImpl(this._dio) {
    _setupInterceptors();
  }

  final Dio _dio;
  String? _token;

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      // Request interceptor for adding auth token
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // Handle common errors
          if (error.response?.statusCode == 401) {
            // Handle unauthorized - could trigger logout
            removeToken();
          }
          handler.next(error);
        },
      ),
      // Log interceptor for debugging
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        // Using debugPrint for production-safe logging
        logPrint: (object) => debugPrint('API_LOG: $object'),
      ),
    ]);
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  void setToken(String token) {
    _token = token;
  }

  @override
  void removeToken() {
    _token = null;
  }

  @override
  bool hasToken() {
    return _token != null;
  }
}

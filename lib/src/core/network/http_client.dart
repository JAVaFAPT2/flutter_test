import 'package:dio/dio.dart';

import '../env/config.dart';
import '../errors/app_error.dart';
import 'error_mapper.dart';

/// Lightweight custom HTTP client on top of Dio returning Result-like responses
class HttpClient {
  HttpClient({Dio? dio}) : _dio = dio ?? _createDio();

  final Dio _dio;

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<({Response? response, AppError? error})> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final res = await _dio.get(path,
          queryParameters: queryParameters, options: options);
      return (response: res, error: null);
    } catch (e) {
      return (response: null, error: ErrorMapper.fromDio(e));
    }
  }

  Future<({Response? response, AppError? error})> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final res = await _dio.post(path,
          data: data, queryParameters: queryParameters, options: options);
      return (response: res, error: null);
    } catch (e) {
      return (response: null, error: ErrorMapper.fromDio(e));
    }
  }

  Dio get raw => _dio;
}


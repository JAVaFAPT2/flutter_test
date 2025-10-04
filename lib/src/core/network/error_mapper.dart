import 'package:dio/dio.dart';

import '../errors/app_error.dart';

/// Maps DioException and HTTP status codes to domain AppError types
class ErrorMapper {
  static AppError fromDio(Object error) {
    if (error is DioException) {
      final type = error.type;
      switch (type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return const NetworkError('Network timeout or connection error');
        case DioExceptionType.badResponse:
          final status = error.response?.statusCode ?? 0;
          if (status == 401) return const AuthError('Unauthorized');
          if (status == 400) return const ValidationError('Bad request');
          if (status >= 500) return const ServerError('Server error');
          return UnknownError('HTTP $status');
        case DioExceptionType.cancel:
          return const UnknownError('Request cancelled');
        case DioExceptionType.badCertificate:
          return const UnknownError('Bad certificate');
        case DioExceptionType.unknown:
          return const UnknownError('Unknown network error');
      }
    }
    return ErrorHandler.handleError(error);
  }
}


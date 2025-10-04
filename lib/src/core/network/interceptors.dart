import 'package:dio/dio.dart';

typedef TokenProvider = Future<String?> Function();
typedef TenantIdProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._getToken);
  final TokenProvider _getToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class TenantInterceptor extends Interceptor {
  TenantInterceptor(this._getTenantId);
  final TenantIdProvider _getTenantId;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final tenantId = await _getTenantId();
    if (tenantId != null && tenantId.isNotEmpty) {
      options.headers['X-Tenant-Id'] = tenantId;
    }
    handler.next(options);
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Keep concise; rely on Dio's LogInterceptor in dev if needed
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Avoid leaking sensitive info in logs
    handler.next(err);
  }
}

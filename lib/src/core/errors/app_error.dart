import 'package:equatable/equatable.dart';

/// Base class for all application errors
abstract class AppError extends Equatable {
  const AppError(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];

  /// Get user-friendly error message in Vietnamese
  String get localizedMessage;

  /// Get error type for categorization
  ErrorType get type;
}

/// Error types for categorization
enum ErrorType {
  network,
  authentication,
  validation,
  server,
  unknown,
}

/// Network-related errors
class NetworkError extends AppError {
  const NetworkError(String message, [String? code])
      : super(message, code ?? 'NETWORK_ERROR');

  @override
  String get localizedMessage =>
      'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  ErrorType get type => ErrorType.network;
}

/// Authentication-related errors
class AuthError extends AppError {
  const AuthError(String message, [String? code])
      : super(message, code ?? 'AUTH_ERROR');

  @override
  String get localizedMessage {
    if (message.contains('Invalid credentials') || message.contains('wrong')) {
      return 'Thông tin đăng nhập không đúng. Vui lòng kiểm tra lại.';
    }
    if (message.contains('expired')) {
      return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
    }
    if (message.contains('not found')) {
      return 'Tài khoản không tồn tại hoặc đã bị khóa.';
    }
    return 'Lỗi xác thực. Vui lòng thử lại.';
  }

  @override
  ErrorType get type => ErrorType.authentication;
}

/// Validation-related errors
class ValidationError extends AppError {
  const ValidationError(String message, [String? code])
      : super(message, code ?? 'VALIDATION_ERROR');

  @override
  String get localizedMessage => message; // Use the specific validation message

  @override
  ErrorType get type => ErrorType.validation;
}

/// Server-related errors
class ServerError extends AppError {
  const ServerError(String message, [String? code])
      : super(message, code ?? 'SERVER_ERROR');

  @override
  String get localizedMessage => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  ErrorType get type => ErrorType.server;
}

/// Unknown/unexpected errors
class UnknownError extends AppError {
  const UnknownError(String message, [String? code])
      : super(message, code ?? 'UNKNOWN_ERROR');

  @override
  String get localizedMessage =>
      'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';

  @override
  ErrorType get type => ErrorType.unknown;
}

/// Error handler utility
abstract class ErrorHandler {
  /// Convert any error to AppError
  static AppError handleError(dynamic error) {
    if (error is AppError) {
      return error;
    }

    // Handle specific error types
    if (error.toString().contains('Network')) {
      return NetworkError(error.toString());
    }

    if (error.toString().contains('auth') ||
        error.toString().contains('token') ||
        error.toString().contains('login')) {
      return AuthError(error.toString());
    }

    if (error.toString().contains('validation') ||
        error.toString().contains('invalid')) {
      return ValidationError(error.toString());
    }

    return UnknownError(error.toString());
  }

  /// Get error message for UI display
  static String getErrorMessage(AppError error) {
    return error.localizedMessage;
  }

  /// Check if error is retryable
  static bool isRetryable(AppError error) {
    return error.type == ErrorType.network || error.type == ErrorType.server;
  }

  /// Get suggested action for error
  static String getSuggestedAction(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return 'Kiểm tra kết nối internet và thử lại';
      case ErrorType.authentication:
        return 'Đăng nhập lại hoặc kiểm tra thông tin tài khoản';
      case ErrorType.validation:
        return 'Kiểm tra lại thông tin đã nhập';
      case ErrorType.server:
        return 'Thử lại sau hoặc liên hệ hỗ trợ';
      case ErrorType.unknown:
        return 'Liên hệ bộ phận hỗ trợ';
    }
  }
}

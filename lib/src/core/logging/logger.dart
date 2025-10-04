import 'package:logger/logger.dart' as l;

/// Simple wrapper around logger with sane defaults
class AppLogger {
  AppLogger._internal() : _logger = l.Logger();
  static final AppLogger instance = AppLogger._internal();

  final l.Logger _logger;

  void info(String message, [Map<String, dynamic>? context]) {
    _logger.i(_format(message, context));
  }

  void warn(String message, [Map<String, dynamic>? context]) {
    _logger.w(_format(message, context));
  }

  void error(String message,
      [Object? error, StackTrace? stackTrace, Map<String, dynamic>? context]) {
    _logger.e(_format(message, context), error: error, stackTrace: stackTrace);
  }

  String _format(String message, Map<String, dynamic>? context) {
    if (context == null || context.isEmpty) return message;
    return '$message | ${context.toString()}';
  }
}


/// Result type for handling success and failure cases
/// Used across all use cases for consistent error handling
sealed class Result<T> {
  const Result();
}

/// Success result containing data
class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

/// Failure result containing error message
class Failure<T> extends Result<T> {
  const Failure(this.message);
  final String message;
}


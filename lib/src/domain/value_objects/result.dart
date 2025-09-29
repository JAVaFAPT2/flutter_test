/// Generic result type for domain operations
/// Follows the Result pattern for better error handling
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.message, [this.code, this.details]);
  final String message;
  final int? code;
  final Map<String, dynamic>? details;
}

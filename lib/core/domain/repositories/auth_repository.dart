import '../entities/user.dart';
import '../value_objects/result.dart';

/// Repository interface for authentication operations
/// Shared across auth-related features
abstract class AuthRepository {
  /// Login with phone and password
  Future<Result<User>> login({
    required String phone,
    required String password,
  });

  /// Register new user
  Future<Result<User>> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  });

  /// Request OTP for phone verification
  Future<Result<void>> requestOtp({required String phone});

  /// Verify OTP code
  Future<Result<User>> verifyOtp({
    required String phone,
    required String otp,
  });

  /// Get current authenticated user
  Future<User?> getCurrentUser();

  /// Logout current user
  Future<void> logout();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
}


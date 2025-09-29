import '../entities/user.dart';
import '../value_objects/result.dart';

/// Abstract interface for authentication operations
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

  /// Send OTP for verification
  Future<Result<void>> sendOTP(String phone);

  /// Verify OTP code
  Future<Result<User>> verifyOTP({
    required String phone,
    required String otp,
  });

  /// Get current user
  Future<Result<User>> getCurrentUser();

  /// Logout user
  Future<Result<void>> logout();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Refresh authentication token
  Future<Result<String>> refreshToken();

  /// Reset password
  Future<Result<void>> resetPassword({
    required String phone,
    required String newPassword,
  });

  /// Update user profile
  Future<Result<User>> updateProfile({
    String? fullName,
    String? email,
    String? address,
  });
}

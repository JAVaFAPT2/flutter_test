import '../models/user_model.dart';

/// Remote data source for authentication
/// Handles API calls for auth operations
abstract class AuthRemoteDataSource {
  /// Login with phone and password
  Future<UserModel> login({
    required String phone,
    required String password,
  });

  /// Register new user
  Future<UserModel> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  });

  /// Request OTP for phone verification
  Future<void> requestOtp({required String phone});

  /// Verify OTP code
  Future<UserModel> verifyOtp({
    required String phone,
    required String otp,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Mock implementation - replace with actual API calls
  @override
  Future<UserModel> login({
    required String phone,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (phone == '0123456789' && password == 'password') {
      return UserModel(
        id: 'user_001',
        phone: phone,
        fullName: 'Test User',
        email: 'test@example.com',
        createdAt: DateTime.now(),
      );
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<UserModel> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user creation
    return UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      phone: phone,
      fullName: fullName,
      email: email,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> requestOtp({required String phone}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock OTP request (in real app, send SMS)
    return;
  }

  @override
  Future<UserModel> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock OTP verification
    if (otp == '123456') {
      return UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        phone: phone,
        fullName: 'OTP User',
        createdAt: DateTime.now(),
      );
    }

    throw Exception('Invalid OTP');
  }
}


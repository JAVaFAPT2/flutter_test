import 'dart:convert';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/value_objects/result.dart';
import '../datasources/local/local_storage.dart';
import '../datasources/local/secure_storage.dart';
import '../datasources/remote/api_client.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository using API and local storage
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localStorage,
    required this.secureStorage,
    required this.apiClient,
  });

  final LocalStorage localStorage;
  final SecureStorage secureStorage;
  final ApiClient apiClient;

  @override
  Future<Result<User>> login({
    required String phone,
    required String password,
  }) async {
    try {
      // Mock API call - in real app this would call the actual API
      final response = await apiClient.post(
        '/auth/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data['user']);
        final token = response.data['token'] as String;

        // Save token to secure storage
        await secureStorage.setSecureToken(token);

        // Save user data to local storage
        await localStorage.setUserData(json.encode(userModel.toJson()));

        return Success(userModel.toEntity());
      } else {
        return Failure('Login failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<User>> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    try {
      // Mock API call - in real app this would call the actual API
      final response = await apiClient.post(
        '/auth/register',
        data: {
          'phone': phone,
          'password': password,
          'fullName': fullName,
          'email': email,
        },
      );

      if (response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.data['user']);
        final token = response.data['token'] as String;

        // Save token to secure storage
        await secureStorage.setSecureToken(token);

        // Save user data to local storage
        await localStorage.setUserData(json.encode(userModel.toJson()));

        return Success(userModel.toEntity());
      } else {
        return Failure('Registration failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<void>> requestOtp({
    required String phone,
  }) async {
    try {
      final response =
          await apiClient.post('/auth/request-otp', data: {'phone': phone});

      if (response.statusCode == 200) {
        return const Success(null);
      } else {
        return Failure('Failed to request OTP: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<User>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await apiClient.post(
        '/auth/verify-otp',
        data: {
          'phone': phone,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data['user']);
        final token = response.data['token'] as String;

        // Save token to secure storage
        await secureStorage.setSecureToken(token);

        // Save user data to local storage
        await localStorage.setUserData(json.encode(userModel.toJson()));

        return Success(userModel.toEntity());
      } else {
        return Failure('OTP verification failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final userData = await localStorage.getUserData();
      if (userData != null) {
        final userModel = UserModel.fromJson(json.decode(userData));
        return Success(userModel.toEntity());
      } else {
        return const Failure('No user data found');
      }
    } catch (e) {
      return Failure('Failed to get user data: $e');
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      // Call logout API
      await apiClient.post('/auth/logout');

      // Clear local data
      await secureStorage.remove('secure_token');
      await localStorage.remove('user_data');

      return const Success(null);
    } catch (e) {
      // Even if API fails, clear local data
      await secureStorage.remove('secure_token');
      await localStorage.remove('user_data');
      return Failure('Logout error: $e');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await secureStorage.getSecureToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Result<String>> refreshToken() async {
    try {
      final response = await apiClient.post('/auth/refresh');

      if (response.statusCode == 200) {
        final newToken = response.data['token'] as String;
        await secureStorage.setSecureToken(newToken);
        return Success(newToken);
      } else {
        return Failure('Token refresh failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<void>> resetPassword({
    required String phone,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.post(
        '/auth/reset-password',
        data: {
          'phone': phone,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return const Success(null);
      } else {
        return Failure('Password reset failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }

  @override
  Future<Result<User>> updateProfile({
    String? fullName,
    String? email,
    String? address,
  }) async {
    try {
      final response = await apiClient.put(
        '/user/profile',
        data: {
          if (fullName != null) 'fullName': fullName,
          if (email != null) 'email': email,
          if (address != null) 'address': address,
        },
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data['user']);

        // Update local storage
        await localStorage.setUserData(json.encode(userModel.toJson()));

        return Success(userModel.toEntity());
      } else {
        return Failure('Profile update failed: ${response.data['message']}');
      }
    } catch (e) {
      return Failure('Network error: $e');
    }
  }
}

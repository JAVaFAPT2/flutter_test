import 'package:flutter/foundation.dart';

import '../../data/datasources/local/secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/auth/login_use_case.dart';
import '../../domain/use_cases/auth/otp_verification_use_case.dart';
import '../../domain/use_cases/auth/register_use_case.dart';
import '../../domain/value_objects/result.dart';

/// Authentication state
class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// Provider for authentication state management
class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.otpVerificationUseCase,
    required this.secureStorage,
  });

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final OtpVerificationUseCase otpVerificationUseCase;
  final SecureStorage secureStorage;

  /// Callback for successful authentication navigation
  VoidCallback? _onAuthenticationSuccess;

  AuthState _state = const AuthState();
  AuthState get state => _state;

  /// Login user
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    final result = await loginUseCase.execute(
      phone: phone,
      password: password,
    );

    switch (result) {
      case Success<User>(:final data):
        _state = _state.copyWith(
          user: data,
          isLoading: false,
          isAuthenticated: true,
          error: null,
        );
        // Save token to secure storage
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());

        // Trigger success callback
        _onAuthenticationSuccess?.call();

      case Failure<User>(:final message):
        _state = _state.copyWith(
          isLoading: false,
          error: message,
          isAuthenticated: false,
        );
    }

    notifyListeners();
  }

  /// Register user
  Future<void> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    final result = await registerUseCase.execute(
      phone: phone,
      password: password,
      fullName: fullName,
      email: email,
    );

    switch (result) {
      case Success<User>(:final data):
        _state = _state.copyWith(
          user: data,
          isLoading: false,
          isAuthenticated: true,
          error: null,
        );
        // Save token to secure storage
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());

        // Trigger success callback
        _onAuthenticationSuccess?.call();

      case Failure<User>(:final message):
        _state = _state.copyWith(
          isLoading: false,
          error: message,
          isAuthenticated: false,
        );
    }

    notifyListeners();
  }

  /// Logout user
  Future<void> logout() async {
    _state = const AuthState();
    await secureStorage.remove('secure_token');
    await secureStorage.remove('user_session');
    notifyListeners();
  }

  /// Check authentication status
  Future<void> checkAuthStatus() async {
    final hasToken = await secureStorage.containsKey('secure_token');
    if (hasToken) {
      final session = await secureStorage.getUserSession();
      if (session != null) {
        // Mock: In real app, decode session and verify token
        _state = _state.copyWith(isAuthenticated: true);
        notifyListeners();
      }
    }
  }

  /// Set callback for successful authentication navigation
  void setAuthenticationSuccessCallback(VoidCallback callback) {
    _onAuthenticationSuccess = callback;
  }

  /// Handle successful authentication (call this after login/register success)
  void onAuthenticationSuccess() {
    _state = _state.copyWith(isAuthenticated: true);
    notifyListeners();
  }

  /// Request OTP for phone verification
  Future<void> requestOtp({
    required String phone,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    final result = await otpVerificationUseCase.requestOtp(phone: phone);

    switch (result) {
      case Success<void>():
        _state = _state.copyWith(
          isLoading: false,
          error: null,
        );

      case Failure<void>(:final message):
        _state = _state.copyWith(
          isLoading: false,
          error: message,
          isAuthenticated: false,
        );
    }

    notifyListeners();
  }

  /// Verify OTP code
  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    final result = await otpVerificationUseCase.execute(
      phone: phone,
      otp: otp,
    );

    switch (result) {
      case Success<User>(:final data):
        _state = _state.copyWith(
          user: data,
          isLoading: false,
          isAuthenticated: true,
          error: null,
        );
        // Save token to secure storage
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());

        // Trigger success callback
        _onAuthenticationSuccess?.call();

      case Failure<User>(:final message):
        _state = _state.copyWith(
          isLoading: false,
          error: message,
          isAuthenticated: false,
        );
    }

    notifyListeners();
  }
}

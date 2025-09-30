import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../src/domain/entities/user.dart' as domain;
import '../../../../src/domain/use_cases/auth/login_use_case.dart';
import '../../../../src/domain/use_cases/auth/otp_verification_use_case.dart';
import '../../../../src/domain/use_cases/auth/register_use_case.dart';
import '../../../../src/domain/value_objects/result.dart';
import '../../../../src/data/datasources/local/secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.otpUseCase,
    required this.secureStorage,
  }) : super(const AuthState.unauthenticated()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpVerifyRequested>(_onOtpVerifyRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
  }

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final OtpVerificationUseCase otpUseCase;
  final SecureStorage secureStorage;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await loginUseCase.execute(
      phone: event.phone,
      password: event.password,
    );

    switch (result) {
      case Success<domain.User>(:final data):
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());
        emit(AuthState.authenticated(user: data));
      case Failure<domain.User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await registerUseCase.execute(
      phone: event.phone,
      password: event.password,
      fullName: event.fullName,
      email: event.email,
    );

    switch (result) {
      case Success<domain.User>(:final data):
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());
        emit(AuthState.authenticated(user: data));
      case Failure<domain.User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onOtpRequested(
    AuthOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await otpUseCase.requestOtp(phone: event.phone);
    switch (result) {
      case Success<void>():
        emit(state.copyWith(isLoading: false));
      case Failure<void>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onOtpVerifyRequested(
    AuthOtpVerifyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await otpUseCase.execute(phone: event.phone, otp: event.otp);
    switch (result) {
      case Success<domain.User>(:final data):
        await secureStorage.setSecureToken('mock_token_${data.id}');
        await secureStorage.setUserSession(data.toString());
        emit(AuthState.authenticated(user: data));
      case Failure<domain.User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await secureStorage.remove('secure_token');
    await secureStorage.remove('user_session');
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final hasToken = await secureStorage.containsKey('secure_token');
    if (!hasToken) {
      emit(const AuthState.unauthenticated());
      return;
    }
    final session = await secureStorage.getUserSession();
    if (session != null) {
      emit(state.copyWith(isAuthenticated: true));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}


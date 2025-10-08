import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/core/domain/entities/user.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/login_use_case.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/otp_verification_use_case.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/register_use_case.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// AuthBloc - Clean DDD compliant
/// Thin orchestration layer that delegates to use cases
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required OtpVerificationUseCase otpUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _otpUseCase = otpUseCase,
        _authRepository = authRepository,
        super(const AuthState.unauthenticated()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpVerifyRequested>(_onOtpVerifyRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final OtpVerificationUseCase _otpUseCase;
  final AuthRepository _authRepository;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _loginUseCase.execute(
      phone: event.phone,
      password: event.password,
    );

    switch (result) {
      case Success<User>(:final data):
        emit(AuthState.authenticated(user: data));
      case Failure<User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _registerUseCase.execute(
      phone: event.phone,
      password: event.password,
      fullName: event.fullName,
      email: event.email,
    );

    switch (result) {
      case Success<User>(:final data):
        emit(AuthState.authenticated(user: data));
      case Failure<User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onOtpRequested(
    AuthOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _otpUseCase.requestOtp(phone: event.phone);

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

    final result = await _otpUseCase.execute(
      phone: event.phone,
      otp: event.otp,
    );

    switch (result) {
      case Success<User>(:final data):
        emit(AuthState.authenticated(user: data));
      case Failure<User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await _authRepository.isAuthenticated();

    if (!isAuthenticated) {
      emit(const AuthState.unauthenticated());
      return;
    }

    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthState.authenticated(user: user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}

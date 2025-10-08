part of 'auth_bloc.dart';

/// Base class for auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to request login
class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.phone,
    required this.password,
  });

  final String phone;
  final String password;

  @override
  List<Object?> get props => [phone, password];
}

/// Event to request registration
class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.phone,
    required this.password,
    required this.fullName,
    this.email,
  });

  final String phone;
  final String password;
  final String fullName;
  final String? email;

  @override
  List<Object?> get props => [phone, password, fullName, email];
}

/// Event to request OTP
class AuthOtpRequested extends AuthEvent {
  const AuthOtpRequested({required this.phone});

  final String phone;

  @override
  List<Object?> get props => [phone];
}

/// Event to verify OTP
class AuthOtpVerifyRequested extends AuthEvent {
  const AuthOtpVerifyRequested({
    required this.phone,
    required this.otp,
  });

  final String phone;
  final String otp;

  @override
  List<Object?> get props => [phone, otp];
}

/// Event to request logout
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Event to check authentication status
class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}

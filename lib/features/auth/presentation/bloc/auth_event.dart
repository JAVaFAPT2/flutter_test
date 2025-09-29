part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.phone, required this.password});
  final String phone;
  final String password;
}

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
}

class AuthOtpRequested extends AuthEvent {
  const AuthOtpRequested({required this.phone});
  final String phone;
}

class AuthOtpVerifyRequested extends AuthEvent {
  const AuthOtpVerifyRequested({required this.phone, required this.otp});
  final String phone;
  final String otp;
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}


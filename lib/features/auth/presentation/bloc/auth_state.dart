part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    required this.isAuthenticated,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  const AuthState.unauthenticated()
      : this._(isAuthenticated: false, user: null);
  const AuthState.authenticated({required domain.User user})
      : this._(isAuthenticated: true, user: user);

  final bool isAuthenticated;
  final domain.User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    bool? isAuthenticated,
    domain.User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState._(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user, isLoading, errorMessage];
}


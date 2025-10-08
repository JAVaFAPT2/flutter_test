part of 'auth_bloc.dart';

/// State for authentication
class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.errorMessage,
  });

  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;

  /// Factory for unauthenticated state
  const AuthState.unauthenticated()
      : user = null,
        isAuthenticated = false,
        isLoading = false,
        errorMessage = null;

  /// Factory for authenticated state
  const AuthState.authenticated({required this.user})
      : isAuthenticated = true,
        isLoading = false,
        errorMessage = null;

  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, isAuthenticated, isLoading, errorMessage];
}

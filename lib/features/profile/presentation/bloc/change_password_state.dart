part of 'change_password_bloc.dart';

/// State for change password flow
class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.errorMessage,
  });

  final ChangePasswordStatus status;
  final String? errorMessage;

  /// Factory for initial state
  const ChangePasswordState.initial()
      : status = ChangePasswordStatus.initial,
        errorMessage = null;

  /// Factory for loading state
  const ChangePasswordState.loading()
      : status = ChangePasswordStatus.loading,
        errorMessage = null;

  /// Factory for success state
  const ChangePasswordState.success()
      : status = ChangePasswordStatus.success,
        errorMessage = null;

  /// Factory for error state
  const ChangePasswordState.error({required String message})
      : status = ChangePasswordStatus.error,
        errorMessage = message;

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}

/// Enum for change password status
enum ChangePasswordStatus {
  initial,
  loading,
  success,
  error,
}

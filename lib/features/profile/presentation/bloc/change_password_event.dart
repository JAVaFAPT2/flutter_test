part of 'change_password_bloc.dart';

/// Base class for change password events
abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Event when user submits password change
class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String userId;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  @override
  List<Object?> get props =>
      [userId, oldPassword, newPassword, confirmPassword];
}

/// Event to reset the change password state
class ChangePasswordReset extends ChangePasswordEvent {
  const ChangePasswordReset();
}

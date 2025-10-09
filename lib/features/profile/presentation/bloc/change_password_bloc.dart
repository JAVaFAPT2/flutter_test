import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/usecases/change_password.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

/// BLoC for handling change password functionality
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required ChangePassword changePasswordUseCase,
  })  : _changePasswordUseCase = changePasswordUseCase,
        super(const ChangePasswordState.initial()) {
    on<ChangePasswordSubmitted>(_onPasswordChangeSubmitted);
    on<ChangePasswordReset>(_onPasswordChangeReset);
  }

  final ChangePassword _changePasswordUseCase;

  Future<void> _onPasswordChangeSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    // Validate confirm password
    if (event.newPassword != event.confirmPassword) {
      emit(const ChangePasswordState.error(
        message: 'Mật khẩu xác nhận không khớp',
      ));
      return;
    }

    emit(const ChangePasswordState.loading());

    final result = await _changePasswordUseCase.call(
      userId: event.userId,
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    );

    switch (result) {
      case Success<void>():
        emit(const ChangePasswordState.success());
      case Failure<void>(:final message):
        // Translate error messages to Vietnamese
        final vietnameseMessage = _translateError(message);
        emit(ChangePasswordState.error(message: vietnameseMessage));
    }
  }

  void _onPasswordChangeReset(
    ChangePasswordReset event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(const ChangePasswordState.initial());
  }

  String _translateError(String message) {
    if (message.contains('Old password is incorrect')) {
      return 'Mật khẩu cũ không đúng';
    }
    if (message.contains('Old password is required')) {
      return 'Vui lòng nhập mật khẩu cũ';
    }
    if (message.contains('New password is required')) {
      return 'Vui lòng nhập mật khẩu mới';
    }
    if (message.contains('at least 6 characters')) {
      return 'Mật khẩu mới phải có ít nhất 6 ký tự';
    }
    if (message.contains('must be different')) {
      return 'Mật khẩu mới phải khác mật khẩu cũ';
    }
    return message;
  }
}

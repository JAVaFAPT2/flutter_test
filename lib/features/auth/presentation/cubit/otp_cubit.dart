import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  const OtpState({this.countdown = 60, this.canResend = false});
  final int countdown;
  final bool canResend;

  OtpState copyWith({int? countdown, bool? canResend}) {
    return OtpState(
      countdown: countdown ?? this.countdown,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [countdown, canResend];
}

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpState());
  Timer? _timer;

  void start() {
    _timer?.cancel();
    emit(const OtpState(countdown: 60, canResend: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdown > 0) {
        emit(state.copyWith(countdown: state.countdown - 1));
      } else {
        emit(state.copyWith(canResend: true));
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}


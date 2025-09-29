import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({this.obscurePassword = true});
  final bool obscurePassword;

  LoginState copyWith({bool? obscurePassword}) {
    return LoginState(obscurePassword: obscurePassword ?? this.obscurePassword);
  }

  @override
  List<Object?> get props => [obscurePassword];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}


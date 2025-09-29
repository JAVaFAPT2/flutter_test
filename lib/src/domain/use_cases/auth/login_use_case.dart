import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for user login
class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Execute login with phone and password
  Future<Result<User>> execute({
    required String phone,
    required String password,
  }) async {
    // Vietnamese validation messages
    if (phone.isEmpty || password.isEmpty) {
      return const Failure('Vui lòng nhập đầy đủ thông tin');
    }

    if (phone.length < 10 || phone.length > 11) {
      return const Failure('Số điện thoại không hợp lệ');
    }

    if (password.length < 6) {
      return const Failure('Mật khẩu phải có ít nhất 6 ký tự');
    }

    return _authRepository.login(
      phone: phone,
      password: password,
    );
  }
}

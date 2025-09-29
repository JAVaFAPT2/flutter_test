import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for OTP verification during registration/login
class OtpVerificationUseCase {
  const OtpVerificationUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Execute OTP verification
  Future<Result<User>> execute({
    required String phone,
    required String otp,
  }) async {
    // Validate input
    if (phone.isEmpty || otp.isEmpty) {
      return const Failure('Vui lòng nhập đầy đủ thông tin');
    }

    if (phone.length < 10 || phone.length > 11) {
      return const Failure('Số điện thoại không hợp lệ');
    }

    if (otp.length != 6) {
      return const Failure('Mã OTP phải có 6 chữ số');
    }

    return _authRepository.verifyOtp(
      phone: phone,
      otp: otp,
    );
  }

  /// Request OTP for phone number
  Future<Result<void>> requestOtp({
    required String phone,
  }) async {
    if (phone.isEmpty) {
      return const Failure('Vui lòng nhập số điện thoại');
    }

    if (phone.length < 10 || phone.length > 11) {
      return const Failure('Số điện thoại không hợp lệ');
    }

    return _authRepository.requestOtp(phone: phone);
  }
}


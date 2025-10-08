import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for OTP verification
class OtpVerificationUseCase {
  const OtpVerificationUseCase(this._repository);

  final AuthRepository _repository;

  /// Request OTP for phone number
  Future<Result<void>> requestOtp({required String phone}) async {
    if (phone.isEmpty) {
      return const Failure('Phone number is required');
    }

    return await _repository.requestOtp(phone: phone);
  }

  /// Verify OTP code
  Future<Result<User>> execute({
    required String phone,
    required String otp,
  }) async {
    if (phone.isEmpty) {
      return const Failure('Phone number is required');
    }
    if (otp.isEmpty) {
      return const Failure('OTP code is required');
    }
    if (otp.length != 6) {
      return const Failure('OTP must be 6 digits');
    }

    return await _repository.verifyOtp(phone: phone, otp: otp);
  }
}


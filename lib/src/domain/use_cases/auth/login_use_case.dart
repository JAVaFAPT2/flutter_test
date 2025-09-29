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
    // Basic validation
    if (phone.isEmpty || password.isEmpty) {
      return const Failure('Phone and password are required');
    }

    if (phone.length < 10 || phone.length > 11) {
      return const Failure('Invalid phone number format');
    }

    if (password.length < 8) {
      return const Failure('Password must be at least 8 characters');
    }

    return _authRepository.login(
      phone: phone,
      password: password,
    );
  }
}

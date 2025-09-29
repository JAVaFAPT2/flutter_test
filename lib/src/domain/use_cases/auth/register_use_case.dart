import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for user registration
class RegisterUseCase {
  const RegisterUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Execute registration with user details
  Future<Result<User>> execute({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    // Basic validation
    if (phone.isEmpty || password.isEmpty || fullName.isEmpty) {
      return const Failure('All fields are required');
    }

    if (phone.length < 10 || phone.length > 11) {
      return const Failure('Invalid phone number format');
    }

    if (password.length < 8) {
      return const Failure('Password must be at least 8 characters');
    }

    if (fullName.trim().length < 2) {
      return const Failure('Full name must be at least 2 characters');
    }

    return _authRepository.register(
      phone: phone,
      password: password,
      fullName: fullName,
      email: email,
    );
  }
}

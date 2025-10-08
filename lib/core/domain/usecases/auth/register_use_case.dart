import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for user registration
class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> execute({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    // Add any business logic/validation here
    if (phone.isEmpty) {
      return const Failure('Phone number is required');
    }
    if (password.isEmpty) {
      return const Failure('Password is required');
    }
    if (password.length < 6) {
      return const Failure('Password must be at least 6 characters');
    }
    if (fullName.isEmpty) {
      return const Failure('Full name is required');
    }

    return await _repository.register(
      phone: phone,
      password: password,
      fullName: fullName,
      email: email,
    );
  }
}


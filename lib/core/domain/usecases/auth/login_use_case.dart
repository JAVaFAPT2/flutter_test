import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/result.dart';

/// Use case for user login
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> execute({
    required String phone,
    required String password,
  }) async {
    // Add any business logic/validation here
    if (phone.isEmpty) {
      return const Failure('Phone number is required');
    }
    if (password.isEmpty) {
      return const Failure('Password is required');
    }

    return await _repository.login(
      phone: phone,
      password: password,
    );
  }
}


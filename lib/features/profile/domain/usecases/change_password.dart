import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import '../repositories/profile_repository.dart';

/// Use case for changing password
class ChangePassword {
  const ChangePassword(this._repository);

  final ProfileRepository _repository;

  Future<Result<void>> call({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    // Add validation business logic
    if (oldPassword.isEmpty) {
      return const Failure('Old password is required');
    }
    if (newPassword.isEmpty) {
      return const Failure('New password is required');
    }
    if (newPassword.length < 6) {
      return const Failure('New password must be at least 6 characters');
    }
    if (oldPassword == newPassword) {
      return const Failure('New password must be different from old password');
    }

    return await _repository.changePassword(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}


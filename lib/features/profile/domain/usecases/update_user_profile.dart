import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Use case for updating user profile
class UpdateUserProfile {
  const UpdateUserProfile(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserProfile>> call(UserProfile profile) async {
    // Add validation business logic
    if (profile.fullName.isEmpty) {
      return const Failure('Full name is required');
    }
    if (profile.phone.isEmpty) {
      return const Failure('Phone number is required');
    }

    return await _repository.updateProfile(profile);
  }
}


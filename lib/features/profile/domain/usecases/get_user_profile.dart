import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Use case for getting user profile
class GetUserProfile {
  const GetUserProfile(this._repository);

  final ProfileRepository _repository;

  Future<UserProfile?> call(String userId) async {
    return await _repository.getProfile(userId);
  }
}


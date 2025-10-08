import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import '../entities/user_settings.dart';
import '../repositories/profile_repository.dart';

/// Use case for updating user settings
class UpdateSettings {
  const UpdateSettings(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserSettings>> call(
    String userId,
    UserSettings settings,
  ) async {
    return await _repository.updateSettings(userId, settings);
  }
}


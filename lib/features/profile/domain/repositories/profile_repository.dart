import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import '../entities/user_profile.dart';
import '../entities/user_settings.dart';

/// Repository interface for profile operations
abstract class ProfileRepository {
  /// Get user profile
  Future<UserProfile?> getProfile(String userId);

  /// Update user profile
  Future<Result<UserProfile>> updateProfile(UserProfile profile);

  /// Change user password
  Future<Result<void>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  /// Get user settings
  Future<UserSettings> getSettings(String userId);

  /// Update user settings
  Future<Result<UserSettings>> updateSettings(
    String userId,
    UserSettings settings,
  );
}


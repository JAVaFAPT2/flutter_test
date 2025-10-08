import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/entities/user_profile.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/entities/user_settings.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/repositories/profile_repository.dart';
import '../models/user_profile_model.dart';

/// Implementation of profile repository
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _profileKeyPrefix = 'user_profile_';
  static const String _settingsKeyPrefix = 'user_settings_';

  @override
  Future<UserProfile?> getProfile(String userId) async {
    try {
      final jsonString = _prefs.getString('$_profileKeyPrefix$userId');
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json).toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Result<UserProfile>> updateProfile(UserProfile profile) async {
    try {
      final model = UserProfileModel.fromEntity(profile);
      final jsonString = jsonEncode(model.toJson());
      await _prefs.setString('$_profileKeyPrefix${profile.id}', jsonString);
      return Success(profile);
    } catch (e) {
      return Failure('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    // Mock implementation - would call API in real app
    await Future.delayed(const Duration(seconds: 1));

    // Simulate validation
    if (oldPassword != 'password') {
      return const Failure('Old password is incorrect');
    }

    return const Success(null);
  }

  @override
  Future<UserSettings> getSettings(String userId) async {
    try {
      final jsonString = _prefs.getString('$_settingsKeyPrefix$userId');
      if (jsonString == null) return const UserSettings();

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserSettings(
        notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
        emailNotificationsEnabled:
            json['emailNotificationsEnabled'] as bool? ?? true,
        smsNotificationsEnabled:
            json['smsNotificationsEnabled'] as bool? ?? false,
        language: json['language'] as String? ?? 'vi',
        theme: json['theme'] as String? ?? 'light',
      );
    } catch (e) {
      return const UserSettings();
    }
  }

  @override
  Future<Result<UserSettings>> updateSettings(
    String userId,
    UserSettings settings,
  ) async {
    try {
      final json = {
        'notificationsEnabled': settings.notificationsEnabled,
        'emailNotificationsEnabled': settings.emailNotificationsEnabled,
        'smsNotificationsEnabled': settings.smsNotificationsEnabled,
        'language': settings.language,
        'theme': settings.theme,
      };
      final jsonString = jsonEncode(json);
      await _prefs.setString('$_settingsKeyPrefix$userId', jsonString);
      return Success(settings);
    } catch (e) {
      return Failure('Failed to update settings: ${e.toString()}');
    }
  }
}


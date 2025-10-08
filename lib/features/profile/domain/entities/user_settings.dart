import 'package:equatable/equatable.dart';

/// Domain entity for user settings
class UserSettings extends Equatable {
  const UserSettings({
    this.notificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.smsNotificationsEnabled = false,
    this.language = 'vi',
    this.theme = 'light',
  });

  final bool notificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool smsNotificationsEnabled;
  final String language;
  final String theme;

  UserSettings copyWith({
    bool? notificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? smsNotificationsEnabled,
    String? language,
    String? theme,
  }) {
    return UserSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      smsNotificationsEnabled:
          smsNotificationsEnabled ?? this.smsNotificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [
        notificationsEnabled,
        emailNotificationsEnabled,
        smsNotificationsEnabled,
        language,
        theme,
      ];
}

